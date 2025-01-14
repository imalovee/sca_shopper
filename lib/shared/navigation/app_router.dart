import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sca_shop/features/authentication/login_screen.dart';
import 'package:sca_shop/features/authentication/register_screen.dart';
import 'package:sca_shop/features/home/home_screen.dart';
import 'package:sca_shop/features/prducts/prducts_screen.dart';
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
      case AppRouteStrings.productScreen:
        return CupertinoPageRoute(builder: (_) => const ProductsScreen());

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