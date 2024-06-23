import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:new_task/product.dart';

import 'package:page_transition/page_transition.dart';

import 'colors.dart';
import 'models/product.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products.first.category ?? ''),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ProductPage(
              productName: product.name,
              productPrice: product.price,
              productimg: product.image,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 3.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                    child: CachedNetworkImage(
                      imageUrl: product.image!,
                      fit: BoxFit.cover,
                      placeholder: (context, _) => Image.asset(
                        'assets/loadingImage.gif',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      errorWidget: (context, s, _) => Image.asset(
                        'assets/errorImage.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${product.price} EG',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.favorite_border,
              color: AppColors.darkblue,
            ),
          ),
        ],
      ),
    );
  }
}
