import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


import '../cubits/products_cubit.dart';
import '../cubits/state.dart';
import '../drawer/app_bar_drawer_icon.dart';
import '../drawer/category_drawer.dart';
import '../models/product.dart';
import '../navigationBar.dart';
import '../order/order_page.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    return Scaffold(
      drawer: const CategoryDrawer(),
      bottomNavigationBar: const NavBar(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        centerTitle: true,
        title: const Text('Wishlist', style: TextStyle(color: Colors.black)),
        leading: const AppBarDrawerIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/total cost.svg'),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersPage()),
            ),
            icon: SvgPicture.asset('assets/shopping-cart.svg'),
            color: Colors.black,
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: cubit.getFavouriteProducts(),
          builder: (context, snapshot) => Padding(
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<ProductCubit, CommonState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuccessState) {
                  final List<Product> products = state.data;
                  return products.isEmpty
                      ? const Center(
                          child: Text('No Favourite Products Yet'),
                        )
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductItem(data: products[index]);
                          },
                        );
                } else if (state is FailedState) {
                  return const Center(child: Text('Failed to fetch favourites'));
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Product data;

  const ProductItem({super.key, required this.data});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool clicked = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 233, 233, 233)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.data.image!),
                    fit: BoxFit.cover,
                  ),
                  color: const Color.fromARGB(255, 233, 233, 233),
                ),
                height: 100,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.name!,
                      style: const TextStyle(
                        color: Color(0xFF4A5F73),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${widget.data.price} EGP",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF262840),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset('assets/star.svg'),
                        const SizedBox(width: 12),
                        Text(widget.data.rate.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() => clicked = !clicked);
                    context.read<ProductCubit>().deleteProductFromFav(widget.data.id.toString());
                  },
                  child: Icon(
                    clicked ? Icons.favorite : Icons.favorite_outline_outlined,
                    size: 20,
                    color: const Color(0xFf262840),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
