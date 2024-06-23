import 'package:bloc/bloc.dart';
import 'package:new_task/cubits/state.dart';
import 'package:new_task/models/uniqueProductModel.dart';

import '../apis/dio_helper.dart';
import '../models/PredSize.dart';
import '../models/get_order_model.dart';
import '../repos/apis_repo.dart';

class OrderCubit extends Cubit<CommonState> {
  final ApiRepository _apiRepository = ApiRepository(ApiService());

  OrderCubit() : super(InitialState());

  Future<void> predictOrder(Map<String, dynamic> data) async {
    emit(LoadingState());
    final result = await _apiRepository.predictOrder(data);
    result.fold(
      (error) => emit(FailedState(error.message)),
      (predsize) => emit(SuccessState<PredSize>(predsize)),
    );
  }

  UniqueProductModel? uniqueProductModel;

  Future<void> getUniqueProduct(
      {required int gender,
      required String categoryId,
      required String colorId,
      required int feature}) async {
    try {
      final result = await _apiRepository.getUniqueProduct(
          gender: gender,
          categoryId: categoryId,
          colorId: colorId,
          feature: feature);

      result.fold(
        (error) {
          emit(GetUniqueProductError());
        },
        (product) {
          emit(GetUniqueProductSuccess(uniqueProductModel: product));
        },
      );
    } catch (error) {
      print('GetUniqueProductError ${error.toString()}');
      emit(GetUniqueProductError());
    }
  }

  Future<void> addOrders({
    required String productId,
    required int quantity,
  }) async {
    try {
      await _apiRepository.addOrder(productId: productId, quantity: quantity);

      emit(AddOrderSuccess());
    } catch (error) {
      print('AddOrders ${error.toString()}');
      emit(AddOrderError());
    }
    // emit(LoadingState());
  }

    List<GetOrderModel> orders=[];
  Future<void> getMyOrders() async {
    emit(GetMyOrdersLoading());
    try {
      final result = await _apiRepository.getMyOrders();

      result.fold((error) {
        print('AddOrders ${error.toString()}');
        emit(GetMyOrdersError());
      }, (myOrders) {
        orders=myOrders??[];
        emit(GetMyOrdersSuccess(myOrders: myOrders));
      });
    } catch (error) {
      print('AddOrders ${error.toString()}');
      emit(GetMyOrdersError());
    }
  }

  Future<void> getOrderDetails({required String id}) async {
    emit(GetOrdersDetailsLoading());
    try {
      final result = await _apiRepository.getOrderDetails(id: id);

      result.fold((error) {
        print('Error getOrderDetails ${error.toString()}');
        emit(GetOrdersDetailsError());
      }, (orderDetails) {

        emit(GetOrdersDetailsSuccess(order: orderDetails));
      });
    } catch (error) {
      print('Error getOrderDetails ${error.toString()}');
      emit(GetOrdersDetailsError());
    }
  }
}
