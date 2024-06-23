
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../drawer/app_bar_drawer_icon.dart';
import '../drawer/category_drawer.dart';
import '../navigationBar.dart';

/// option list view
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  // Product data list
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Orange T-Shirt',
      'price': '600',
      'imagePath': 'assets/logos/orange1.png',
    },
    {
      'name': 'Blue Polo T-Shirt',
      'price': '250',
      'imagePath': 'assets/logos/blue1.png',
    },
    {
      'name': 'Yellow Polo T-Shirt',
      'price': '500',
      'imagePath': 'assets/logos/yellow1.png',
    },
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      drawer: const CategoryDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white70,
        centerTitle: true,
        leading: const AppBarDrawerIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/total cost.svg'),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/shopping-cart.svg'),
            color: Colors.black,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Based on your taste',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Expanded(
                    child: ExpansionTile(
                      title: MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          'View All ',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: (products.length / 2).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      final int firstIndex = index * 2;
                      final int secondIndex = firstIndex + 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductItem(data: products[firstIndex]),
                          if (secondIndex < products.length)
                            ProductItem(data: products[secondIndex]),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Map data;

  const ProductItem({super.key, required this.data});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool clicked = true;

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Stack(children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            widget.data['imagePath'],
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey),
                    height: ScreenSize.height * 0.27,
                    width: ScreenSize.width * 0.4,
                  ),
                  SizedBox(
                    height: 180,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: ScreenSize.width * 0.37,
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() => clicked = !clicked);
                                },
                                child: Icon(
                                  clicked
                                      ? Icons.favorite
                                      : Icons.favorite_outline_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.abc),
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: ScreenSize.width * 0.1,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/plus.svg'),
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.data['name'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  //    SvgPicture.asset('assets/discount.svg'),
                  Text(
                    " ${widget.data['price']} EGP",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
