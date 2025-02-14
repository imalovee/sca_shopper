import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sca_shop/services/cache_service.dart';
import 'package:sca_shop/shared/navigation/app_router.dart';
import 'package:sca_shop/shared/navigation/route_strings.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load()  ;
  
  await CacheService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: AppRouter.navKey,
      onGenerateRoute: AppRouter.onGenerateRoute ,
      initialRoute: CacheService().getToken() != null? AppRouteStrings.homeScreen:
      AppRouteStrings.loginScreen,
    );
  }
}

