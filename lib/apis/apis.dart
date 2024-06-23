class ApiEndpoints {
  static const String baseUrl = "https://lemur-glorious-neatly.ngrok-free.app/api";

  // Order endpoints
  static const String predictOrder = "/Order/predict";
  static const String recommendOrder = "/Order/recommend";
  static const String addOrder = "/Order/Addorder";
  static const String addFavouriteProduct =
      "/Order/AddFavouriteProduct/{ProductId}";
  static const String deleteFavouriteProduct =
      "/Order/DeleteFavouriteProduct/{ProductId}";
  static const String confirmOrder = "/Order/ConfirmOrder/{OrderId}";
  static const String getFavouriteProducts = "/Order/GetFavouriteProducts";
  static const String getMyOrders = "/Order/GetMyOrders/";
  static const String getBestSellerProducts = "/Order/GetBestSellerProducts";
  static const String getMaleProducts = "/Order/GetMaleProducts";
  static const String getFemaleProducts = "/Order/GetFemaleProducts";
  static const String getMaleProductsWithCategory =
      "/Order/GetMaleProductsWithCategory/{CategoryId}";
  static const String getFemaleProductsWithCategory =
      "/Order/GetFemaleProductsWithCategory/{CategoryId}";
  static const String getUniqueProducts = "/Order/GetUniqueProducts";
  static const String getOrderDetails = "/Order/GetOrderDetails/";

  // User endpoints
  static const String signIn = "/User/SignIn";
  static const String signUp = "/User/SignUp";
  static const String confirmEmail = "/User/ConfirmEmail";
  static const String resendPasswordCode = "/User/ResendPasswordCode";
  static const String confirmPasswordCode = "/User/ConfirmPasswordCode";
  static const String resetPassword = "/User/ResetPassword";
  static const String confirmSize = "/User/ConfirmSize";
}
