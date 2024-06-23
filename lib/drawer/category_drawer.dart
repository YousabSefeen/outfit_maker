
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubits/products_cubit.dart';
import '../cubits/state.dart';
import '../profile/my_profile.dart';
import '../view_all.dart';

const TextStyle drawerItemStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
    color: Color(0xFF262840));

class CategoryDrawer extends StatefulWidget {
  const CategoryDrawer({super.key});

  @override
  State<CategoryDrawer> createState() => _CategoryDrawerState();
}

class _CategoryDrawerState extends State<CategoryDrawer> {

  @override
  void initState() {

    super.initState();
    _getEmail();
  }
  String emailAddress='';
  Future<void> _getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    emailAddress=  prefs.getString('user_email')??'hh';
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Image.asset(
                'assets/logo.png',
                height: 100,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoModalPopupRoute(
                            builder: (_) => const ProfileScreen())),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const    SizedBox(width: 10),
        const    Text(
                          'Holy Rezk',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
        const    SizedBox(width: 10),
                        Text(emailAddress,style:const TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.w700,letterSpacing: 1.3)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                shape: const Border(),
                controlAffinity: ListTileControlAffinity.leading,
                tilePadding: EdgeInsets.zero,
                title: const Text("Categories ", style: drawerItemStyle),
                initiallyExpanded: true,
                childrenPadding: const EdgeInsets.only(left: 16),
         children: [
           ListTile(
             onTap: ()async{
               final ProductCubit cubit = ProductCubit();
               await cubit.getMaleProducts();

               final state = cubit.state;
               if (state is SuccessState) {
                 final products = state.data;

                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => ViewAll(products: products)));
               }
             },
             leading:const Icon(Icons.file_open,size: 20,color: Colors.amber) ,
             title:const Text('Men',style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w700,
               color: Colors.black,

             ),) ,
             trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.grey.shade500,),
           ),
           ListTile(
             onTap: ()async{
               final ProductCubit cubit = ProductCubit();
               await cubit.getFemaleProducts();
               final state = cubit.state;
               if (state is SuccessState) {
               final products = state.data;

               Navigator.push(
               context,
               MaterialPageRoute(
               builder: (context) => ViewAll(products: products)));
               }
             },
             leading:const Icon(Icons.file_open,size: 20,color: Colors.amber) ,
             title:const Text('Women',style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w700,
               color: Colors.black,

             ),) ,
             trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.grey.shade500,),
           ),
         ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const DrawerItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: drawerItemStyle,
          ),
        ),
      ),
    );
  }
}
/*
       children: [
                  ExpansionTile(
                    shape: const Border(),
                    controlAffinity: ListTileControlAffinity.leading,
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    title: const Text(
                      'Men',
                      style: drawerItemStyle,
                    ),
                    childrenPadding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 24,
                    ),
                    children: [
                      DrawerItem(title: "Crew neck", onTap: () {}),
                      DrawerItem(title: "V-neck", onTap: () {}),
                      DrawerItem(title: 'Long sleeve', onTap: () {}),
                      DrawerItem(title: 'Henley neck', onTap: () {}),
                      DrawerItem(title: 'Short sleeve', onTap: () {}),
                    ],
                  ),
                  ExpansionTile(
                    shape: const Border(),
                    controlAffinity: ListTileControlAffinity.leading,
                    tilePadding: EdgeInsets.zero,
                    title: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Woman',
                        style: drawerItemStyle,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 24,
                    ),
                    children: [
                      DrawerItem(title: "Crew neck", onTap: () {}),
                      DrawerItem(title: "V-neck", onTap: () {}),
                      DrawerItem(title: 'Long sleeve', onTap: () {}),
                      DrawerItem(title: 'Henley neck', onTap: () {}),
                      DrawerItem(title: 'Short sleeve', onTap: () {}),
                    ],
                  ),
                ],
 */