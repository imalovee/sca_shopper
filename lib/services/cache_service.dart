import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
   CacheService._privateConstructor();

  static final CacheService _instance = CacheService._privateConstructor();

  factory CacheService() {
    return _instance;
  }

  late final SharedPreferences _sharedPreferences;

  Future<void> init()async{
   _sharedPreferences = await SharedPreferences.getInstance();
  }

  final accessKey = 'access-token-key';

  Future<void> saveToken(String accessToken)async{
    _sharedPreferences.setString(accessKey, accessToken);
  }

  Future<void> deleteToken()async{
    _sharedPreferences.remove(accessKey);
  }

  String? getToken(){
   return _sharedPreferences.getString(accessKey);
  }
}