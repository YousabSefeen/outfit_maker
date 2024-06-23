import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/colors.dart';

import '../cubits/order_cubit.dart';
import '../cubits/state.dart';
import '../drawer/app_bar_drawer_icon.dart';
import '../drawer/category_drawer.dart';
import '../navigationBar.dart';

class OrderViewModel {
  double subTotal = 270;

  List<OrderItemModel> orders = [
    OrderItemModel(
      price: 150,
      color: 'Red',
      size: 'AI',
      isSale: true,
      salePrice: 120,
      name: 'Crew neck summer t-shirt',
    ),
    OrderItemModel(
      price: 150,
      color: 'Red',
      size: 'AI',
      name: 'Crew neck summer t-shirt',
    ),
  ];
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage> {
  final ordersVM = OrderViewModel();

  void addItem(double price) => setState(() => ordersVM.subTotal += price);

  void removeItem(double price) => setState(() => ordersVM.subTotal -= price);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final cubit = context.read<OrderCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavBar(),
      appBar: AppBar(
        title: const Text('Order'),
        centerTitle: true,
        leading: const AppBarDrawerIcon(),
      ),
      drawer: const CategoryDrawer(),
      body: FutureBuilder(
        future: cubit.getMyOrders(),
        builder: (context, snapshot) => BlocProvider<OrderCubit>(
          create: (context) => OrderCubit()..getMyOrders(),
          child: BlocBuilder<OrderCubit, CommonState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is GetMyOrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.darkblue,
                  ),
                );
              } else if (state is GetMyOrdersSuccess) {
                return cubit.orders.isEmpty
                    ? const Center(
                        child: Text('No Orders Products Yet',style: TextStyle(fontSize: 18,color: Colors.black)
                      ))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: state.myOrders!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = state.myOrders![index];
                          return SizedBox(
                            width: deviceSize.width * 0.8,
                            height: deviceSize.height * 0.22,
                            child: Card(
                              elevation: 8,
                              color: Colors.white,
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) => InkWell(
                                  onTap: null,
                                  splashColor: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth * 0.4,
                                        child: CachedNetworkImage(
                                          imageUrl: product.imageUrl,
                                          fit: BoxFit.cover,
                                          placeholder: (context, _) =>
                                              Image.asset(
                                            'assets/loadingImage.gif',
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                            width: double.infinity,
                                          ),
                                          errorWidget: (context, s, _) =>
                                              Image.asset(
                                            'assets/errorImage.png',
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color:
                                                          AppColors.darkblue),
                                                ),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Text(
                                                        'Total amount',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .darkblue,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      Text(
                                                        '${product.total} EG',
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .darkblue,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ],
                                                  )),
                                              TextButton.icon(
                                                onPressed: null,
                                                icon: const Icon(
                                                  Icons.date_range_outlined,
                                                  color: AppColors.darkblue,
                                                  size: 27,
                                                ),
                                                label: Text(
                                                  getDate(product.date),
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              } else {
                return Center(
                  child: Container(
                    width: 220,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'An error occurred please try again later',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),

                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  getDate(String date) {
    // تعريف التعبير المنتظم لاستخراج التاريخ
    RegExp regExp = RegExp(r"^\d{4}-\d{2}-\d{2}");

    // استخدام التعبير المنتظم للعثور على التاريخ
    Match match = regExp.firstMatch(date) as Match;

    if (match != null) {
      // استخراج التاريخ من النص
      return match.group(0);
      print(date); // 2024-06-19
    } else {
      return 'kk';
    }
  }
}

class OrderItemModel {
  final double price;
  final String color;
  final String size;
  final bool isSale;

  final double salePrice;
  final String name;
  final int count;

  OrderItemModel(
      {required this.price,
      required this.color,
      required this.size,
      required this.name,
      this.count = 1,
      this.isSale = false,
      this.salePrice = 0});
}

class OrderItem extends StatefulWidget {
  final OrderViewModel orderVM;
  final int index;
  final void Function(double) addItem;
  final void Function(double) removeItem;

  const OrderItem({
    super.key,
    required this.addItem,
    required this.removeItem,
    required this.orderVM,
    required this.index,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late OrderItemModel model;
  int itemCount = 0;

  @override
  void initState() {
    model = widget.orderVM.orders[widget.index];
    itemCount = model.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    double quarter = size.width * 0.25;
    return Container(
      height: quarter,
      width: width,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF6F8FB), width: 2)),
      child: SizedBox(
        height: quarter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: quarter,
              height: quarter,
              child: Stack(children: [
                Container(
                  width: quarter,
                  height: quarter,
                  color: const Color(0xffF6F8FB),
                  child: const SizedBox(),
                ),
                if (model.isSale)
                  Positioned(
                    left: 4,
                    bottom: 4,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 6,
                        top: 1,
                        right: 6,
                        bottom: 1,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                          color: const Color(0xffdbe9f5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'sale',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 8,
                            color: Color(0xff262840),
                            fontFamily: 'DMSans-Bold',
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff4a5f73),
                        fontWeight: FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${model.price} EG",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: model.isSale
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: model.isSale ? 12 : 14,
                            color: const Color(0xff262840),
                            fontFamily: 'DMSans-Regular',
                            fontWeight: model.isSale
                                ? FontWeight.w400
                                : FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 4),
                      if (model.isSale)
                        Text(
                          '${model.salePrice} EG',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              color: Color(0xff262840),
                              fontFamily: 'DMSans-Bold',
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Color: red',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            color: Color(0xff4a5f73),
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 14),
                      Text(
                        'Size: AI',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            color: Color(0xff4a5f73),
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: quarter * 0.35,
                  width: quarter * 0.35,
                  child: IconButton(
                    onPressed: () {
                      setState(() => itemCount += 1);
                      widget.orderVM.orders[widget.index] = OrderItemModel(
                          price: model.price,
                          color: model.color,
                          size: model.size,
                          name: model.name,
                          count: itemCount,
                          isSale: model.isSale,
                          salePrice: model.salePrice);
                      widget.addItem(
                          model.isSale ? model.salePrice : model.price);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xff4A5F73),
                      size: 12,
                    ),
                  ),
                ),
                Text(
                  '$itemCount',
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    color: Color(0xff4A5F73),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: quarter * 0.35,
                  width: quarter * 0.35,
                  child: IconButton(
                    onPressed: () {
                      if (itemCount > 1) {
                        setState(() => itemCount -= 1);
                        widget.removeItem(
                            model.isSale ? model.salePrice : model.price);
                        widget.orderVM.orders[widget.index] = OrderItemModel(
                            price: model.price,
                            color: model.color,
                            size: model.size,
                            name: model.name,
                            count: itemCount,
                            isSale: model.isSale,
                            salePrice: model.salePrice);
                      }
                    },
                    icon: const Icon(Icons.remove),
                    color: const Color(0xff4A5F73),
                    iconSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TotalBox extends StatelessWidget {
  final double subTotal;

  const TotalBox({
    super.key,
    required this.subTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: const Color(0xffDBE9F5).withOpacity(0.15),
          border: Border.all(
            color: const Color(0xffDBE9F5),
          )),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Subtotal',
              style: TextStyle(
                  color: Color(0xFF262840),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              '$subTotal EG',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xFF262840),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery',
                  style: TextStyle(
                      color: Color(0xFF4A5F73),
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    '15 EG',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF4A5F73),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              color: Color(0xffDBE9F5),
            ),
          ),
          ListTile(
            title: const Text(
              'Total',
              style: TextStyle(
                  color: Color(0xFF262840),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              '${subTotal + 15} EG',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF262840),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
