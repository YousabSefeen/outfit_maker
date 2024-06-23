import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/app_alerts.dart';
import 'package:new_task/models/recommend_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:svg_flutter/svg.dart';

import 'colors.dart';
import 'cubits/order_cubit.dart';
import 'cubits/state.dart';
import 'navigationBar.dart';
import 'order/order_page.dart';

class ProductPage extends StatefulWidget {
  final String? productId;
  final productName;
  final productPrice;
  final productimg;

  const ProductPage({
    super.key,
    this.productId,
    this.productName,
    this.productPrice,
    this.productimg,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _quantity = 1; // Track the quantity
  String _selectedCategory = ''; // Track the selected category
  String _selectedCategoryStyle = "";
  String _selectedCategoryNeckline = "";
  int _selectedColorIndex = 0;
  int _selectedImgIndex = 0;
  int _selectedSizeIndex = 0;

  // Scroll controller to scroll to a specific part of the page
  final ScrollController _scrollController = ScrollController();

  String? startProductId;
  String? startProductName;
  int? startProductPrice;
  String? startProductImageUrl;

  int initGender = 1;

  //*******Style************
  String cREWWomen = '04278274-DC8F-46D2-3C18-08DC76B5E73E';
  String vNECKWomen = '04278274-DC8F-46D2-3C18-08DC76B5E73E';

  String cREWMen = '611BBEAC-9C06-4C25-3C17-08DC76B5E73E';
  String vNECKMen = 'BF950ECE-FFC4-4F36-A44C-C992DADFB0D6';
  String initNeckline = '';

  //*******Colors************
  String colorOne = '9CDE1F11-44F5-48C3-1227-08DC76B74035';
  String colorTwo = '1E1EBCBE-C698-4CC9-1228-08DC76B74035';
  String colorThree = '6ADDF2AD-777A-49BA-1226-08DC76B74035';
  String colorFour = 'B64B4BE5-8376-4E61-1229-08DC76B74035';
  String colorFive = '7618F128-0518-4FBD-122A-08DC76B74035';
  String initColor = '';

  int initFeature = 0;
  bool isRecommendingLoading = false;

  RecommendModel? recommendModel;

  Future<void> uploadImageTwo() async {
    setState(() => isRecommendingLoading = true);
    String assetPath = 'assets/reco.jpeg';
    ByteData byteData = await rootBundle.load(assetPath);

    // الحصول على المسار المؤقت للجهاز
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // كتابة البيانات في ملف مؤقت
    File tempFile = File('$tempPath/reco.jpeg');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    try {
      var dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 10);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(tempFile.path),
      });

      Response response = await dio.post(
          'https://lemur-glorious-neatly.ngrok-free.app/api/Order/recommend',
          data: formData);
      print('jesus ${response.data}');
      if (response.statusCode == 200) {
        recommendModel = RecommendModel.fromJson(response.data);

        print('888888888888   ${recommendModel!.data![0].name}');
        print('Response Data: ${response.data}');
      } else {
        print('An Error Occurred: ${response.statusCode}');
      }
      setState(() => isRecommendingLoading = false);
    } catch (e) {
      setState(() => isRecommendingLoading = false);
      print('An Error Occurred: $e');
    } finally {
      setState(() => isRecommendingLoading = false);
      // حذف الملف المؤقت بعد الانتهاء
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    uploadImageTwo();
    startProductId = widget.productId;
    startProductName = widget.productName;
    startProductPrice = widget.productPrice;
    startProductImageUrl = widget.productimg;
    initNeckline = cREWWomen;
    initColor = colorOne;
    // Set the default selected category here
    _selectedCategory = "Women";
    _selectedCategoryStyle = "Crew neck";
    _selectedCategoryNeckline = "Short";
  }

  void _selectCategory(String category, {bool isStyle = false}) {
    setState(() {
      if (isStyle) {
        _selectedCategoryStyle = category;
      } else {
        _selectedCategory = category;
      }
    });
  }

  void _resetSelections() {
    setState(() {
      _quantity = 1;
      _selectedCategory = 'Women';
      _selectedCategoryStyle = 'Crew neck';
      _selectedCategoryNeckline = 'Short';
      _selectedColorIndex = 0;
      _selectedImgIndex = -1;
      _selectedSizeIndex = 0;
    });
  }

  Widget _buildColorContainer(
      {required int index,
      required Color color,
      required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border: _selectedColorIndex == index
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
        child: _selectedColorIndex == index
            ? const Icon(
                Icons.done,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, CommonState>(
      listener: (context, state) async {
        if (state is GetUniqueProductSuccess) {
          setState(() {
            startProductImageUrl = state.uniqueProductModel.imageUrl;
            startProductName = state.uniqueProductModel.name;
          });
        } else if (state is OTPError) {
          AppAlerts.customSnackBar(
              context: context, msg: 'Invalid Otp provided');
        }
      },
      child: Scaffold(
        bottomNavigationBar: const NavBar(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 22)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const OrdersPage()));
                },
                child: SvgPicture.asset('assets/Icons/cart.svg',
                    width: 26, height: 26),
              ),
            ),
          ],
        ),
        body: isRecommendingLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.darkblue,
              ))
            : SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Add space
                      Container(
                        height: 300,
                        color: AppColors
                            .white, // Change color based on selected category
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: CachedNetworkImage(
                            imageUrl: startProductImageUrl!,
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
                          ), // Remove .image from widget.productimg
                        ),
                      ),

                      const SizedBox(height: 20),
                      // Add space
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              startProductName ?? 'Unknown Product',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),

                            const SizedBox(height: 20), // Add space
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(143, 38, 40, 64),
                                      width: .5,
                                    ),
                                  ),
                                  height: 60,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "$startProductPrice EG",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.remove,
                                                color: AppColors.darkblue,
                                              ),
                                              onPressed: _decrementQuantity,
                                            ),
                                            Text(
                                              _quantity.toString(),
                                              // Display quantity
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: AppColors.darkblue,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.add,
                                                color: AppColors.darkblue,
                                              ),
                                              onPressed: _incrementQuantity,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                "Categories",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Add space
                            Row(
                              children: [
                                CategoryButton(
                                  text: "Women",
                                  isSelected: _selectedCategory == "Women",
                                  onTap: () {
                                    initGender = 1;
                                    _selectCategory("Women");
                                  },
                                ),
                                const SizedBox(width: 20),
                                CategoryButton(
                                  text: "Men",
                                  isSelected: _selectedCategory == "Men",
                                  onTap: () {
                                    initGender = 0;
                                    _selectCategory("Men");
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            ///************** Add space
                            const Center(
                              child: Text(
                                "Style",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Add space
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Neckline",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CategoryButton(
                                      text: "Crew neck",
                                      isSelected:
                                          _selectedCategoryStyle == "Crew neck",
                                      onTap: () {
                                        if (initGender == 1) {
                                          initNeckline = initNeckline;
                                        } else {
                                          initNeckline = cREWMen;
                                        }
                                        _selectCategory("Crew neck",
                                            isStyle: true);
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    CategoryButton(
                                      text: "V-neck",
                                      isSelected:
                                          _selectedCategoryStyle == "V-neck",
                                      onTap: () {
                                        if (initGender == 1) {
                                          initNeckline = vNECKWomen;
                                        } else {
                                          initNeckline = vNECKMen;
                                        }
                                        _selectCategory("V-neck",
                                            isStyle: true);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            /*    const SizedBox(height: 20), // Add space
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sleeve Length",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10), // Add space
                          Row(
                            children: [
                              CategoryButton(
                                text: "Long",
                                isSelected: _selectedCategoryNeckline == "Long",
                                onTap: () =>
                                    _selectSleeveLenght("Long", isStyle: true),
                              ),
                              const SizedBox(width: 20),
                              CategoryButton(
                                text: "Short",
                                isSelected: _selectedCategoryNeckline == "Short",
                                onTap: () =>
                                    _selectSleeveLenght("Short", isStyle: true),
                              ),
                            ],
                          ),
                        ],
                      ),
      */
                            const SizedBox(height: 20),
                            // Add space
                            const Center(
                              child: Text(
                                "Design",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Color",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    _buildColorContainer(
                                        index: 0,
                                        color: const Color.fromARGB(
                                            255, 242, 126, 2),
                                        onTap: () {
                                          setState(() {
                                            initColor = colorOne;
                                            _selectedColorIndex = 0;
                                          });
                                        }),
                                    const SizedBox(width: 20),
                                    _buildColorContainer(
                                        index: 1,
                                        color: const Color(0xff67A0A4),
                                        onTap: () {
                                          initColor = colorTwo;

                                          setState(() {
                                            _selectedColorIndex = 1;
                                          });
                                        }),
                                    const SizedBox(width: 20),
                                    _buildColorContainer(
                                        index: 2,
                                        color: const Color(0xffF8E7CD),
                                        onTap: () {
                                          initColor = colorThree;

                                          setState(() {
                                            _selectedColorIndex = 2;
                                          });
                                        }),
                                    const SizedBox(width: 20),
                                    _buildColorContainer(
                                        index: 3,
                                        color: AppColors.orange,
                                        onTap: () {
                                          initColor = colorFour;

                                          setState(() {
                                            _selectedColorIndex = 3;
                                          });
                                        }),
                                    const SizedBox(width: 20),
                                    _buildColorContainer(
                                        index: 4,
                                        color: const Color(0xff142535),
                                        onTap: () {
                                          initColor = colorFive;

                                          setState(() {
                                            _selectedColorIndex = 4;
                                          });
                                        }),
                                    const SizedBox(width: 20),
                                  ],
                                )
                              ],
                            ),

                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Graphic Tees",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int i = 0; i < 3; i++)
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                                () => _selectedImgIndex = i);
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color: _selectedImgIndex == i
                                                  ? AppColors.orange
                                                  : AppColors.darkblue,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: _selectedImgIndex == i
                                                  ? Border.all(
                                                      color: AppColors.orange,
                                                      width: 2,
                                                    )
                                                  : null,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/Icons/Asset${i + 1}.svg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                /* const Center(
                            child: Text(
                              "Size",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 7; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedSizeIndex = i;
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        color: _selectedSizeIndex == i
                                            ? AppColors.darkblue
                                            : AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          [
                                            "AI",
                                            "S",
                                            "M",
                                            "L",
                                            "XL",
                                            "XXL",
                                            "XXXL"
                                          ][i],
                                          style: TextStyle(
                                            color: _selectedSizeIndex == i
                                                ? AppColors.white
                                                : AppColors.darkblue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),*/
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () async {
                                  await context
                                      .read<OrderCubit>()
                                      .getUniqueProduct(
                                        gender: initGender,
                                        categoryId: initNeckline,
                                        colorId: initColor,
                                        feature: initFeature,
                                      );
                                  setState(() {});
                                },
                                child: const Text(
                                  'Product preview',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                )),
                            const SizedBox(height: 20),

                            ///   FeatureProductsWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: _resetSelections,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.darkblue),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Clear",
                                      style: TextStyle(
                                        color: AppColors.darkblue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            const Text(
                              'Product recommendation',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.darkblue,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1),
                              textAlign: TextAlign.start,
                            ),
                            GridView.builder(
                              shrinkWrap: true,

                              /// It is very important that someone else can get me an error
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 20),

                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 4,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: recommendModel!.data!.length,
                              itemBuilder: (ctx, index) => InkWell(
                                splashColor: Colors.blue,
                                onTap: () {},
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://lemur-glorious-neatly.ngrok-free.app/images/${recommendModel!.data![index].imageUrl}',
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() => isLoading = true);
                                  await context.read<OrderCubit>().addOrders(
                                      productId: startProductId!,
                                      quantity: _quantity);
                                  setState(() => isLoading = false);
                                  AppAlerts.customSnackBar(
                                      context: context,
                                      msg: 'Added successfully',
                                      isSuccess: true);
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkblue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add,
                                                  color: AppColors.white),
                                              Text(
                                                "Add to Cart",
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20), // Add space
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkblue : Colors.transparent,
          border: Border.all(color: AppColors.darkblue),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.darkblue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
