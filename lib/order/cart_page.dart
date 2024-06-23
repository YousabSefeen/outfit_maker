
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../navigationBar.dart';
import '../product.dart';

class CartPage extends StatelessWidget {
  static const List<Map<String, dynamic>> cartData = [
    {
      'imagePath': 'assets/logos/blue1.png',
      'productName': 'Blue T-Shirt',
      'price': 360
    },
    {
      'imagePath': 'assets/logos/yellow1.png',
      'productName': 'Yellow T-Shirt',
      'price': 300
    },
    {
      'imagePath': 'assets/logos/orange1.png',
      'productName': 'Orange T-Shirt',
      'price': 420
    },
  ];

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      appBar: AppBar(
        title: const Text('Cart '),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartData.length,
        itemBuilder: (BuildContext context, int index) {
          final item = cartData[index];
          return Dismissible(
              key: Key(item['productName']),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // Remove the item from the cartData list
                cartData.removeAt(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ProductPage(
                              productPrice: item['price'],
                              productName: item['productName'],
                              productimg: item['imagePath'])));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        item['imagePath'],
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['productName'],
                          style: const TextStyle(fontSize: 17),
                        ),
                        Text(('${item['price']} EG'))
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
