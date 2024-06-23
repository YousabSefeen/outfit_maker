import 'dart:convert';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:new_task/models/get_order_model.dart';
import 'package:new_task/models/uniqueProductModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/apis.dart';
import '../apis/dio_helper.dart';
import '../core/cache_manager.dart';
import '../models/PredSize.dart';
import '../models/error_model.dart';
import '../models/order_details_model.dart';
import '../models/product.dart';
import '../models/user.dart';

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  // Order APIs
  Future<Either<ApiError, PredSize>> predictOrder(
      Map<String, dynamic> data) async {
    try {
      final response =
          await apiService.postRequest(ApiEndpoints.predictOrder, data);
      print(response.data);
      final responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      return Right(PredSize.fromJson(responseData));
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getFavouriteProducts() async {
    try {
      final response = await apiService.getRequest(
          ApiEndpoints.getFavouriteProducts,
          token: CacheHelper.getToken());
      final data = response.data['data'];
      print(data);
      final products =
          (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, bool>> addProductToFavourite(String productId) async {
    try {
      final endpoint =
          ApiEndpoints.addFavouriteProduct.replaceAll('{ProductId}', productId);
      final response = await apiService.postRequest(endpoint, {},
          token: CacheHelper.getToken());
      final data = response.data['data'];
      debugPrint(data.toString());
      if (data == true) {
        return const Right(true);
      } else {
        return Left(ApiError('Something went Wrong!'));
      }
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, bool>> deleteProductToFavourite(
      String productId) async {
    try {
      final endpoint = ApiEndpoints.deleteFavouriteProduct
          .replaceAll('{ProductId}', productId);
      final response = await apiService.deleteRequest(endpoint, {},
          token: CacheHelper.getToken());
      final data = response.data['data'];
      debugPrint(data.toString());
      if (data == true) {
        return const Right(true);
      } else {
        return Left(ApiError('Something went Wrong!'));
      }
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, UniqueProductModel>> getUniqueProduct(
      {required int gender,
      required String categoryId,
      required String colorId,
      required int feature}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? 'Token is Null';
      print(token);
      final response = await apiService.getRequest(
          ApiEndpoints.getUniqueProducts,
          //    token: CacheHelper.getToken());

         token: 'Bearer $token',
        queryParams: {
            'Gender': gender,
            'CategoryId': categoryId,
            'ColorId': colorId,
            'Feature': feature
          });

      final data = response.data['data'];

      final uniqueProduct = (data as List<dynamic>)
          .map((e) => UniqueProductModel.fromJson(e))
          .toList();

      print('gggggggg :${uniqueProduct[0].name}');

      return Right(uniqueProduct[0]);
    } catch (e) {
      print('Error in getUniqueProduct: ${e.toString()}');
      return Left(ApiError(e.toString()));
    }
  }

  addOrder({
    required String productId,
    required int quantity,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? 'Token is Null';
    print(token);
    try {
      await Dio(BaseOptions(
        headers: {
          'Authorization': 'Bearer $token',
        },
      )).post('https://lemur-glorious-neatly.ngrok-free.app/api/Order/Addorder',
          data: {
            "orderItems": [
              {"productId": productId, "quantity": quantity, "note": "string"}
            ]
          });

      // token: CacheHelper.getToken());
      // final data = response.data['data'];
      // final orders =
      // (data as List<dynamic>).map((e) => Order.fromJson(e)).toList();
      // return Right(orders);
    } catch (e) {
      print('object  ${e.toString()}');
    }
  }

  Future<Either<ApiError, List<GetOrderModel>?>> getMyOrders() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? 'Token is Null';
    print(token);
    try {
      final response = await Dio(BaseOptions(headers: {
        'Authorization': 'Bearer $token',
      })).get('${ApiEndpoints.baseUrl}${ApiEndpoints.getMyOrders}');

      final allProducts=['data'] as List?;
      if(allProducts==null){
        return const Right([]);
      }else{
        final List<GetOrderModel> data = (response.data['data'] as List)
            .map((e) => GetOrderModel.fromJson(e))
            .toList();

        return Right(data);
      }

    } catch (e) {
      print('Error in getMyOrders: ${e.toString()}');
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, OrderDetailsModel>> getOrderDetails(
      {required String id}) async {
    try {
      final response = await Dio(BaseOptions())
          .get('${ApiEndpoints.baseUrl}${ApiEndpoints.getOrderDetails}$id');

      final data = OrderDetailsModel.fromJson(response.data);
      print('dddd   $data');
      return Right(data);
    } catch (e) {
      print('Error in getOrderDetails: ${e.toString()}');
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getBestSellerProducts() async {
    final url =
        "https://lemur-glorious-neatly.ngrok-free.app/api/Order/GetBestSellerProducts";

    try {
      final response = await apiService.getRequest(url);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final products =
            (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
        return Right(products);
      } else {
        return Left(ApiError('Unexpected response: ${response.data}'));
      }
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getMaleProducts() async {
    try {
      final response =
          await apiService.getRequest(ApiEndpoints.getMaleProducts);
      final data = response.data['data'];
      final products =
          (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getFemaleProducts() async {
    try {
      final response =
          await apiService.getRequest(ApiEndpoints.getFemaleProducts);
      final data = response.data['data'];
      final products =
          (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getMaleProductsWithCategory(
      String categoryId) async {
    try {
      final endpoint = ApiEndpoints.getMaleProductsWithCategory
          .replaceAll('{CategoryId}', categoryId);
      final response = await apiService.getRequest(endpoint);
      final data = response.data['data'];
      final products =
          (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getFemaleProductsWithCategory(
      String categoryId) async {
    try {
      final endpoint = ApiEndpoints.getFemaleProductsWithCategory
          .replaceAll('{CategoryId}', categoryId);
      final response = await apiService.getRequest(endpoint);
      final data = response.data['data'];
      final products =
          (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, List<Product>>> getUniqueProducts() async {
    try {
      final response =
          await apiService.getRequest(ApiEndpoints.getUniqueProducts);
      final data = response.data['data'];
      final products =
          (data as List<dynamic>).map((e) => Product.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  // User APIs
  Future<Either<ApiError, User>> signIn(Map<String, dynamic> data) async {
    try {
      final response = await apiService.postRequest(ApiEndpoints.signIn, data);
      return Right(User.fromJson(response.data['data']));
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

/*  Future signUp(Map<String, dynamic> data) async {
    try {
      final response = await Dio(
        BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            receiveDataWhenStatusError: true,
           ),
      ).post(ApiEndpoints.signUp,data: data);
 print(response.data);
            if(response.data['status']==200){
              print('wwwwww  ${response.data['status']}');
                return Right(response.data);
            }else{
              return Left(ApiError(response.data['message']));
            }
    // return Right(response.data);
    } catch (e) {
      print('Error Sign Up ${e.toString()}');
       return Left(ApiError(e.toString()));
    }
  }*/

  Future<Either<ApiError, Response>> confirmEmail(
      Map<String, dynamic> data) async {
    try {
      final response =
          await apiService.postRequest(ApiEndpoints.confirmEmail, data);
      return Right(response);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, Response>> resendPasswordCode(
      Map<String, dynamic> data) async {
    try {
      // final response = await apiService
      //     .postRequest(ApiEndpoints.resendPasswordCode, data);
      final response = await Dio(
        BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            receiveDataWhenStatusError: true,
            queryParameters: data),
      ).post(ApiEndpoints.resendPasswordCode);
      return Right(response);
    } catch (e) {
      print(e.toString());
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, Response>> confirmPasswordCode(
      Map<String, dynamic> data) async {
    try {
      final response =
          await apiService.postRequest(ApiEndpoints.confirmPasswordCode, data);
      return Right(response);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, Response>> resetPassword(
      Map<String, dynamic> data) async {
    try {
      final response =
          await apiService.postRequest(ApiEndpoints.resetPassword, data);
      return Right(response);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }

  Future<Either<ApiError, Response>> confirmSize(String size) async {
    try {
      final response = await apiService
          .postRequest(ApiEndpoints.confirmSize, {'size': size});
      return Right(response);
    } catch (e) {
      return Left(ApiError(e.toString()));
    }
  }
}
