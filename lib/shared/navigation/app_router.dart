import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sca_shop/features/authentication/login_screen.dart';
import 'package:sca_shop/features/authentication/register_screen.dart';
import 'package:sca_shop/features/home/home_screen.dart';
import 'package:sca_shop/features/prducts/prducts_details_screen.dart';
import 'package:sca_shop/features/prducts/products_list_screen.dart';
import 'package:sca_shop/models/response_models/category_model.dart';
import 'package:sca_shop/models/response_models/products_model.dart';
import 'package:sca_shop/shared/navigation/route_strings.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

    static Route onGenerateRoute(RouteSettings settings){
      switch (settings.name) {
        case AppRouteStrings.loginScreen:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case AppRouteStrings.registerScreen:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      case AppRouteStrings.homeScreen:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());
      case AppRouteStrings.productDetailsScreen:
        return CupertinoPageRoute(builder: (_) =>  ProductsDetailsScreen(
          productModel: settings.arguments as ProductModel? ,
        ));
        case AppRouteStrings.productListScreen:
          return CupertinoPageRoute(builder: (_) =>  ProductsListScreen(
            category: settings.arguments as CategoryModel?
          ));

      default:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      }
    }

    static void push(String name, {Object? args}){
      navKey.currentState?.pushNamed(name, arguments: args) ;
    }

    static void pushReplace(String name, {Object? args}){
      navKey.currentState?.pushReplacementNamed(name, arguments: args);
    }

     static void pop(String name, {Object? arg}) {
    navKey.currentState?.pop(arg);
  }

  static void pushAndClear(String name, {Object? arg}) {
    navKey.currentState?.pushNamedAndRemoveUntil(name, (_) => false);
  }
}