import 'package:flutter/material.dart';
import 'package:sca_shop/models/response_models/category_model.dart';
import 'package:sca_shop/models/response_models/products_model.dart';
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (contect, index){
                      final each = snapshot.data?.cats?[index];
                      return ListViewItem(
                  
                        title: each?.name ?? '',
                        imageUrl: each?.image ?? "",
                        onTap: (){
                          AppRouter.push(AppRouteStrings.productListScreen,
                          args: each);
                          
                        },
                        );
                    }, 
                    separatorBuilder: (context, index ){
                      return Divider();
                    }, 
                    itemCount: snapshot.data?.cats?.length ?? 0);
                 }
                 ),
              SizedBox(height: 30,),
            Text(
                  "All Products",
                  style: style.copyWith(
                    fontSize: 20,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),  
                SizedBox(height: 20,), 
                FutureBuilder(
                  future: _apiRepo.fetchPrducts() , 
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
                      ),);
                    }
                    else if(snapshot.hasError ){
                      return Text('Could not fetch products');
                    }
                    else if(snapshot.data?.error != null){
                      return Text(snapshot.data?.error ?? "Could not display error message/ products");
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        final product= snapshot.data?.eachProduct?[index];
                        // final imageUrl = (product?.images?.isNotEmpty ?? false)
                        //     ? product!.images![0] // Use the first image
                        //     : "https://imgur.com/HqYqLnW";
                        // print("Image URL: ${product?.images?[0]}");
                        return  ListViewItem(
                          title: product?.title ?? "",
                           imageUrl: product?.images?[0] ?? "",
                           onTap: (){
                              AppRouter.push(AppRouteStrings.productDetailsScreen,
                              args: product
                              );
                           },
                           );
                      },
                      separatorBuilder: (context, index){
                        return Divider();
                      },
                       itemCount: snapshot.data?.eachProduct?.length ?? 0
                       );
                  }) 
          ],
        ),
      ),) ,
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    super.key,
    required this.title,
    required this.imageUrl, this.onTap
  });

  final String title;
  final String imageUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title ,
      style: style.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appColor,
                  fontSize: 15,
                ),),
      leading: ClipRRect(
         borderRadius: BorderRadius.circular(20),
        child: Image.network(imageUrl ,
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
  }
}