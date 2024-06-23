
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../core/cache_manager.dart';
import '../drawer/app_bar_drawer_icon.dart';
import '../drawer/category_drawer.dart';
import '../login.dart';
import '../navigationBar.dart';
import '../order/addreesDetails.dart';
import '../order/order_page.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    _nameController.text = CacheHelper.getFromShared('name');
    _ageController.text = "21";
    _weightController.text = "85";

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      drawer: const CategoryDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        centerTitle: true,
        title: const Text('My Profile', style: TextStyle(color: Colors.black)),
        leading: const AppBarDrawerIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/total cost.svg'),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () =>
                navigateWithRTFTransition(context, const OrdersPage()),
            icon: SvgPicture.asset('assets/shopping-cart.svg'),
            color: Colors.black,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Hero(
                    tag: 'profile_picture',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              CacheHelper.getFromShared('name') ?? 'Holy Rizk',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 10),
                            Text(CacheHelper.getFromShared('email') ??
                                'holyrezk@mail.com'),
                          ],
                        ),
                        SizedBox(width: ScreenSize.width * 0.24),
                        IconButton(
                          icon: SvgPicture.asset('assets/Vector.svg'),
                          color: Colors.grey,
                          iconSize: 30,
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoModalPopupRoute(
                                  builder: (builder) => const EditProfile())),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ProfileListTile(
                      assetPath: 'assets/server.svg',
                      title: "My orders",
                      onTap: () {}),
                  const SizedBox(height: 20),
                  ProfileListTile(
                      assetPath: 'assets/map-pin.svg',
                      title: "Delivery address",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const AddressDetailsPage(),
                            ));
                      }),
                  const SizedBox(height: 20),
                  ProfileListTile(
                      assetPath: 'assets/log-out.svg',
                      title: "Sign out",
                      showTrailing: false,
                      onTap: () {
                        CacheHelper.removeAll();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String assetPath;
  final String title;
  final void Function()? onTap;
  final bool showTrailing;

  const ProfileListTile({
    super.key,
    required this.assetPath,
    required this.title,
    this.onTap,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Color of the border
          width: 1.0, // Width of the border
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(assetPath),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: showTrailing
            ? const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              )
            : null,
      ),
    );
  }
}
