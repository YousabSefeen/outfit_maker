import 'package:flutter/material.dart';

class CustomAnimationRoute extends PageRouteBuilder {
  final Widget screen;
  final bool isAnimationVertical;

  CustomAnimationRoute({this.isAnimationVertical = false, required this.screen})
      : super(
          pageBuilder: (context, animation, _) => screen,
          transitionsBuilder: (context, animation, _, child) {
            if (isAnimationVertical) {
              final position = Tween<Offset>(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                    parent: animation, curve: Curves.easeInOutCubic),
              );
              return SlideTransition(position: position, child: screen);
            } else {
              final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation, curve: Curves.easeInOutCubic));

              return ScaleTransition(scale: scale, child: screen);
            }
          },
          transitionDuration: const Duration(milliseconds: 900),
          reverseTransitionDuration: const Duration(milliseconds: 900),
        );
}
