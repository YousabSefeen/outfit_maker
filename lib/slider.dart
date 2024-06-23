import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:new_task/product.dart';
import 'package:page_transition/page_transition.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> imageList = [
      {'imagePath': 'assets/logos/orange1.png', 'productName': 'Orange T-Shirt', 'price': '420'},
      {'imagePath': 'assets/logos/blue1.png', 'productName': 'Blue T-Shirt', 'price': '360'},
      {'imagePath': 'assets/logos/yellow1.png', 'productName': 'Yellow T-Shirt', 'price': '300'},
    ];

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: imageList
          .map(
            (item) => Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDBE9F5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 500,
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/logo.png",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              item['productName'], // Access productName from item
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF262840),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        item['imagePath'], // Access imagePath from item
                        height: 200,
                        width: 200,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
