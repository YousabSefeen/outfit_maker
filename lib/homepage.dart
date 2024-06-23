import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_task/slider.dart';
import 'package:new_task/widgets/best_seller.dart';
import 'package:new_task/widgets/feature_products.dart';
import 'package:page_transition/page_transition.dart';

import 'categories.dart';
import 'drawer/app_bar_drawer_icon.dart';
import 'drawer/category_drawer.dart';
import 'navigationBar.dart';
import 'order/order_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> imageList = [
    {
      'imagePath': 'assets/logos/orange1.png',
      'productName': 'Orange T-Shirt',
      'price': '420'
    },
    {
      'imagePath': 'assets/logos/blue1.png',
      'productName': 'Blue T-Shirt',
      'price': '360'
    },
    {
      'imagePath': 'assets/logos/yellow1.png',
      'productName': 'Yellow T-Shirt',
      'price': '300'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      // resizeToAvoidBottomInset: false,
      drawer: const CategoryDrawer(),
      appBar: AppBar(
        leading: const AppBarDrawerIcon(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const OrdersPage()));
              },
              child: SvgPicture.asset(
                'assets/Icons/cart.svg',
                width: 26,
                height: 26,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeSlider(),
                const SizedBox(height: 20),
                const Categories(),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                BestSellerWidget(),
                const SizedBox(height: 20),
                FeatureProductsWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
