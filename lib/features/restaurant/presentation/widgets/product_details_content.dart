import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/presentation/widgets/container.dart';

class ProductDetailsContent extends StatelessWidget {
  final ProductResponse productResponse;
  const ProductDetailsContent({super.key, required this.productResponse});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: productResponse.id.toString(),
            child: CachedNetworkImage(
              imageUrl: productResponse.imageUrl.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Text(productResponse.title.en, style:  TextStyle(fontSize: 20.sp, color: Colors.green)),
          Text(productResponse.description.en, style:  TextStyle(fontSize: 20.sp, color: Colors.grey)),
          Text('\$${productResponse.price.toString()}', style:  TextStyle(fontSize: 20.sp, color: Colors.black)),
          10.verticalSpace,
          const CounterWidget(),
        ],
      ),
    );
  }
}