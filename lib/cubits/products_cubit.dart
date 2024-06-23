import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_task/cubits/state.dart';

import '../apis/dio_helper.dart';
import '../models/product.dart';
import '../repos/apis_repo.dart';

class ProductCubit extends Cubit<CommonState> {
  final ApiRepository _apiRepository = ApiRepository(ApiService());

  ProductCubit() : super(InitialState());

  Future<void> getFavouriteProducts() async {
    emit(LoadingState());
    final result = await _apiRepository.getFavouriteProducts();
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }

  Future<void> addProductToFavourite(String productId) async {
    emit(LoadingState());
    final result = await _apiRepository.addProductToFavourite(productId);
    result.fold(
      (error) {
        emit(FailedState(error.message));
        Fluttertoast.showToast(msg: error.message);
        debugPrint(error.message);
      },
      (_) {
        emit(SuccessState(true));
        Fluttertoast.showToast(msg: 'Added Successfully');
      },
    );
  }

  Future<void> deleteProductFromFav(String productId) async {
    emit(LoadingState());
    final result = await _apiRepository.deleteProductToFavourite(productId);
    result.fold(
      (error) {
        emit(FailedState(error.message));
        Fluttertoast.showToast(msg: error.message);
      },
      (_) {
        emit(SuccessState(true));
        Fluttertoast.showToast(msg: 'Removed!');
        getFavouriteProducts();
      },
    );
  }

  Future<void> getBestSellerProducts() async {
    emit(LoadingState());
    final result = await _apiRepository.getBestSellerProducts();
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    print(result);
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }

  Future<void> getMaleProducts() async {
    emit(LoadingState());
    final result = await _apiRepository.getMaleProducts();
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }

  Future<void> getFemaleProducts() async {
    emit(LoadingState());
    final result = await _apiRepository.getFemaleProducts();
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }

  Future<void> getMaleProductsWithCategory(String categoryId) async {
    emit(LoadingState());
    final result = await _apiRepository.getMaleProductsWithCategory(categoryId);
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }

  Future<void> getFemaleProductsWithCategory(String categoryId) async {
    emit(LoadingState());
    final result =
        await _apiRepository.getFemaleProductsWithCategory(categoryId);
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }

  Future<void> getUniqueProducts() async {
    emit(LoadingState());
    final result = await _apiRepository.getUniqueProducts();
    result.fold(
      (error) => emit(FailedState(error.message)),
      (products) => emit(SuccessState<List<Product>>(products)),
    );
  }
}
