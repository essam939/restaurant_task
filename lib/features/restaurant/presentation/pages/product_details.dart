import 'package:flutter/material.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/presentation/controller/counter/counter_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/widgets/product_details_content.dart';

// Product Details Widget
class ProductDetails extends StatefulWidget {
  final ProductResponse productResponse;
  const ProductDetails({super.key, required this.productResponse});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late CounterCubit counterCubit;

  @override
  void initState() {
    super.initState();
    counterCubit = ServiceLocator.instance<CounterCubit>();
  }
  @override
  void dispose() {
    counterCubit.reset();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, size: 25)),
        ],
      ),
      backgroundColor: Colors.green,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ProductDetailsContent(productResponse: widget.productResponse),
      ),
    );
  }
}