import 'package:flutter/material.dart';
import 'package:sca_shop/models/response_models/products_model.dart';
import 'package:sca_shop/shared/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sca_shop/shared/constants.dart';


class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({super.key, this.productModel});

  final ProductModel? productModel;
  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:   AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.appColor,
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(

            itemCount: widget.productModel?.images?.length ?? 0, 
            itemBuilder: (context,itemIndex,  _){
              final image = widget.productModel?.images?[itemIndex];
                return SizedBox(
                  height: height * 5,
                  width: width,
                  child: Image.network(
                    image ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                        return Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.black.withOpacity(.1)),
                          height: height * .5,
                          width: width,
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.black.withOpacity(.3),
                          ),
                        );
                      },
                    ),
                );
            }, 
            options: CarouselOptions(
              autoPlay: false,
              enableInfiniteScroll: true,
              reverse: false,
              scrollDirection: Axis.horizontal,
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0
            )),
            const SizedBox(
              height: 20,
            ),
            Text(widget.productModel?.title ?? "",
            style: style.copyWith(
               fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 20,
            ),),
            Text( CurrencyConverter().formatToNaira(priceInDollars: widget.productModel?.price?.toDouble()),
            style: style.copyWith(
               fontWeight: FontWeight.w600,
                  color: AppColors.appColor,
                  fontSize: 20,
            ),),
            const SizedBox(
              height: 20,
            ),
            Text(widget.productModel?.description ?? "",
            style: style.copyWith(
               fontWeight: FontWeight.w600,
                   color: Colors.black54,
                  fontSize: 15,
            ),),
          ],
        ),
      ),
      ),
    );
  }
}

