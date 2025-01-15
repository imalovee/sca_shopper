import 'package:flutter/material.dart';
import 'package:sca_shop/repository/api_repository.dart';
import 'package:sca_shop/services/cache_service.dart';
import 'package:sca_shop/shared/colors.dart';
import 'package:sca_shop/shared/constants.dart';
import 'package:sca_shop/shared/navigation/app_router.dart';
import 'package:sca_shop/shared/navigation/route_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cacheService = CacheService();
  final _apiRepo = ApiRepository();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
          title: Text(
            "Home Screen",
            style: style.copyWith(
              fontSize: 20,
              color: AppColors.white,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await _cacheService.deleteToken().then((_) {
                    AppRouter.push(AppRouteStrings.loginScreen);
                  });
                },
                child: Text(
                  "Logout",
                  style: style.copyWith(fontSize: 15, color: AppColors.white),
                ))
          ],
          automaticallyImplyLeading: false,
      ),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Text(
                "Categories",
                style: style.copyWith(
                  fontSize: 20,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
             FutureBuilder(
              future: _apiRepo.fetchCategories(),
               builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
                  ),);
                }
               else if(snapshot.hasError ){
                  return Text('Could Not Fetch Categories');
                }
                else if(snapshot.data?.error != null){
                    return Center(child: Text(snapshot.data?.error ?? 'Could not fetch categories'),);
                }
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (contect, index){
                      final each = snapshot.data?.cats?[index];
                      return ListTile(
                        title: Text(each?.name ?? "",
                        style: style.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.appColor,
                                    fontSize: 15,
                                  ),),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(each?.image ?? "",
                          height: 60,
                          width: 60,
                          errorBuilder: (_, __, ___){
                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.black.withOpacity(.1)
                                               
                              ),
                                height: 60,
                                 width: 60,
                              child: Icon(Icons.image_not_supported_outlined),
                            );
                          },
                          ),
                        )
                      );
                    }, 
                    separatorBuilder: (context, index ){
                      return Divider();
                    }, 
                    itemCount: snapshot.data?.cats?.length ?? 0),
                );
               }
               )
        ],
      ),) ,
    );
  }
}