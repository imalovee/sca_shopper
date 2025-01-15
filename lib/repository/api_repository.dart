import 'package:sca_shop/models/request_models/login_model.dart';
import 'package:sca_shop/models/request_models/register_model.dart';
import 'package:sca_shop/models/response_models/category_model.dart';
import 'package:sca_shop/models/response_models/login_response_model.dart';
import 'package:sca_shop/models/response_models/user_models.dart';
import 'package:sca_shop/services/api_service.dart';
import 'package:sca_shop/services/cache_service.dart';

class ApiRepository {
  final _apiService = ApiService();
  final _cacheService = CacheService();

  Future<({UserModel? user, String? error})> createUser(RegisterModel model)async{
    final req = await _apiService.post(endPoint: "api/v1/users/", data: model.toJson());
    if(req.data != null){
      return (user: UserModel.fromJson(req.data), error: null);
    }else{
      return (user: null, error: req.error);
    }
  }

  Future<({bool? login, String? error})> loginUser(LoginModel model )async{
    final req = await _apiService.post(endPoint: "api/v1/auth/login", data: model.toJson());
    if(req.data != null){
      final loginModel = LoginResponseModel.fromJson(req.data);

      if(loginModel.accessToken != null){
        await _cacheService.saveToken(loginModel.accessToken ?? "");
      }
      return (login: true, error: null);
    }else{
      return (login: false, error: req.error);
    }
  }

  Future<({List<CategoryModel>? cats, String? error})> fetchCategories()async{
    final req = await _apiService.get(endPoint: "api/v1/categories?limit=100");
    if(req.data !=null){
      //cast the returned data to a list
      final data = req.data as List;
      //map each element in the data list to a CategoryModel object and conver it to a list<CategoryModel>
      final listofCats = List<CategoryModel>.from(data.map((e) {
        return CategoryModel.fromJson(e);
      },));
      return (cats: listofCats, error: null);
    }else{
      return (cats: null, error: req.error);
    }
  }
}