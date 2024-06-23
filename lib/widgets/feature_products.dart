import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../colors.dart';
import '../cubits/products_cubit.dart';
import '../cubits/state.dart';
import '../models/product.dart';
import '../product.dart';
import '../view_all.dart';

class FeatureProductsWidget extends StatelessWidget {
  FeatureProductsWidget({
    super.key,
  });

  final ProductCubit cubit = ProductCubit();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cubit.getUniqueProducts(),
      builder: (context, snapshot) => BlocConsumer<ProductCubit, CommonState>(
          listener: (context, state) {},
          bloc: cubit,
          builder: (context, state) {
            if (state is LoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Row(
                  children: List.generate(
                    2, // Number of shimmer placeholders
                    (index) => Container(
                      height: 300,
                      width: 240,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is FailedState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is SuccessState) {
              final products = state.data as List<Product>;
              products.shuffle();
              final previewProducts = products.sublist(0, 2);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Feature Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewAll(products: products)));
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: previewProducts.reversed.map((item) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ProductPage(
                                      productName: item.name,
                                      productPrice: item.price,
                                      productimg: item.image,
                                      productId: item.id,
                                    )));
                          },
                          child: Container(
                            height: 350,
                            width: 240,
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:

                                        CachedNetworkImage(

                                          imageUrl: item.image!,
                                          height: 220,
                                          width: 200,
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
                                const SizedBox(height: 10),
                                Text(
                                  item.name!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ("${item.price} EG"),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
