import 'package:new_task/models/order_details_model.dart';
import 'package:new_task/models/uniqueProductModel.dart';

import '../models/get_order_model.dart';

abstract class CommonState {}

class InitialState extends CommonState {}

class LoadingState extends CommonState {}


class SuccessState<T> extends CommonState {
  final T data;
  SuccessState(this.data);
}

class FailedState extends CommonState {
  final String message;
  FailedState(this.message);
}
class ForgetPassError extends CommonState {}
class ForgetPassSuccess extends CommonState {}
class OTPSuccess extends CommonState {}
class OTPError extends CommonState {}
class RestPasswordSuccess extends CommonState {}
class RestPasswordError extends CommonState {}
class AddOrderSuccess extends CommonState {}
class AddOrderError extends CommonState {}
class GetUniqueProductSuccess extends CommonState {
  final UniqueProductModel uniqueProductModel;
   GetUniqueProductSuccess({required this.uniqueProductModel});
}
class GetUniqueProductError extends CommonState {}
class GetMyOrdersLoading extends CommonState {}

class GetMyOrdersSuccess extends CommonState {
final List<GetOrderModel>? myOrders;
GetMyOrdersSuccess({required this.myOrders});
}
class GetMyOrdersError extends CommonState {}
//***Order Details

class GetOrdersDetailsLoading extends CommonState {}

class GetOrdersDetailsSuccess extends CommonState {
  final OrderDetailsModel order;
  GetOrdersDetailsSuccess({required this.order});
}
class GetOrdersDetailsError extends CommonState {}



class SignInSuccess extends CommonState {}
class SignInError extends CommonState {}
class SignUpSuccess extends CommonState {}
class SignUpError extends CommonState {
  final String errorMsg;
  SignUpError({required this.errorMsg});
}