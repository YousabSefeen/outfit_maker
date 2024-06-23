
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class AppBarDrawerIcon extends StatelessWidget {
  const AppBarDrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: SvgPicture.asset(
          'assets/Burger.svg',
          colorFilter:
              const ColorFilter.mode(AppColors.darkblue, BlendMode.srcIn),
        ),
        color: Colors.black,
      ),
    );
  }
}
