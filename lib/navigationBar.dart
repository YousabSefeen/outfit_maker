
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_task/product.dart';
import 'package:new_task/profile/my_profile.dart';
import 'package:page_transition/page_transition.dart';

import 'colors.dart';
import 'favourite/favourite_screen.dart';
import 'homepage.dart';
import 'order/order_page.dart';

navigateWithRTFTransition(BuildContext context, Widget widget) =>
    Navigator.push(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: widget));

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: AppColors.darkblue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => navigateWithRTFTransition(context, const Home()),
            child: SvgPicture.asset(
              'assets/Icons/home.svg',
              width: 24,
              height: 24,
            ),
          ),
          GestureDetector(
            onTap: () =>
                navigateWithRTFTransition(context, const ProductPage()),
            child: SvgPicture.asset(
              'assets/Icons/painting.svg',
              width: 24,
              height: 24,
            ),
          ),
          GestureDetector(
            onTap: () => navigateWithRTFTransition(context, const OrdersPage()),
            child: SvgPicture.asset(
              'assets/Icons/cart2.svg',
              width: 24,
              height: 24,
            ),
          ),
          GestureDetector(
            onTap: () => navigateWithRTFTransition(context, const FavouriteScreen()),
            child: SvgPicture.asset(
              'assets/Icons/heart.svg',
              width: 24,
              height: 24,
            ),
          ),
          GestureDetector(
            onTap: () =>
                navigateWithRTFTransition(context, const ProfileScreen()),
            child: SvgPicture.asset(
              'assets/Icons/user.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
