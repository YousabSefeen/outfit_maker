import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/splash_screen.dart';

import 'core/bloc_observer.dart';
import 'core/cache_manager.dart';
import 'core/dio_class.dart';
import 'cubits/order_cubit.dart';
import 'cubits/products_cubit.dart';
import 'cubits/user_cubit.dart';
import 'homepage.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => OrderCubit()..getMyOrders()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'DM Sans',
        ),
        home: CacheHelper.getFromShared('isFirstTime') != null
            ? CacheHelper.getToken() != null
                ? const Home()
                : const LoginPage()
            : const SplashScreen(),
        //  home: BottomNavigationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/* CacheHelper.getFromShared('isFirstTime') != null
            ? CacheHelper.getToken() != null
                ? const Home()
                : const LoginPage()
            : const SplashScreen(),*/
