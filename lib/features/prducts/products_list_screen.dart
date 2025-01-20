import 'package:flutter/material.dart';
import 'package:sca_shop/models/response_models/category_model.dart';
import 'package:sca_shop/repository/api_repository.dart';
import 'package:sca_shop/shared/navigation/app_router.dart';
import 'package:sca_shop/shared/navigation/route_strings.dart';

import '../../shared/colors.dart';
import '../../shared/constants.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key,  this.category});
  final CategoryModel? category;

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {

    final _apiRepo = ApiRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.appColor,
        title: Text(widget.category?.name ?? 'Product List',
          style: style.copyWith(
            fontSize: 20,
            color: AppColors.white,
          ),),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
              future: _apiRepo.getProductById((widget.category?.id ?? 0).toString()),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
                    ),
                  );
                }
                else if(snapshot.hasError){
                  return Text('Could not fetch products');
                }
                else if(snapshot.data?.error != null){
                  return Text(snapshot.data?.error ?? "Could not fetch products");
                }
                return Expanded(
                    child: ListView.separated(
                        itemBuilder: (_, index){
                          final each = snapshot.data?.products?[index];
                          return ListTile(
                            onTap: (){
                              return AppRouter.push(AppRouteStrings.productDetailsScreen,
                              args: each
                              );
                            },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(each?.title ?? "",
                                    style: style.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                      fontSize: 15,
                                    ),),
                                  Text(each?.description ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:style.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(.4),
                                    fontSize: 14,
                                  ), )
                                ],
                              ),
                              trailing: Text(CurrencyConverter().formatToNaira(
                                priceInDollars: each?.price?.toDouble()
                                 ),
                                style: style.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appColor,
                                  fontSize: 15,
                                ),),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(each?.images?.firstOrNull ?? "",
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
                        separatorBuilder: (context, index){
                          return Divider();
                        },
                        itemCount: snapshot.data?.products?.length ?? 0),
                );
              }
          )
        ],
      ) ,
      ),
    );
  }
}
