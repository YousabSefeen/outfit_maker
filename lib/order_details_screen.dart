import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/order/order_page.dart';

import 'colors.dart';
import 'core/custom_animation_route.dart';
import 'cubits/order_cubit.dart';
import 'cubits/state.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String id;

  const OrderDetailsScreen({super.key, required this.id});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    final cubit = context.read<OrderCubit>();
     context.read<OrderCubit>().getMyOrders();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        // leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColors.darkblue,size: 18 ),
        //   onPressed: () => Navigator.of(context).push(
        //
        //     CustomAnimationRoute(
        //       screen: const OrdersPage(),
        //       isAnimationVertical: true,
        //     ),
        //   ),
        //
        // ),
      ),
      body: FutureBuilder(
        future: cubit.getOrderDetails(id: widget.id),
        builder: (context, snapshot) => BlocBuilder<OrderCubit, CommonState>(
          builder: (context, state) {
            if (state is GetOrdersDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.darkblue,
                ),
              );
            } else if (state is GetOrdersDetailsSuccess) {
              final product=state.order.data!.data![0];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CachedNetworkImage(

                      height: deviceSize.height*0.4,
                      imageUrl: product.productImg!,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.productName!,
                      style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkblue),
                    ),
                  ),
                   const SizedBox(height: 30 ),
                   Row(
                   children: [
                     Text('Product price: ${product.productPrice}',style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700),)
                   ],
                 )

                ],
              );
            } else {
              return Center(
                child: Container(
                  width: 220,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'An error occurred please try again later',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
