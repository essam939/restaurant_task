import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/presentation/controller/counter/counter_cubit.dart';

// Product Details Widget
class ProductDetails extends StatefulWidget {
  final ProductResponse productResponse;
  const ProductDetails({Key? key, required this.productResponse}) : super(key: key);

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
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border, size: 25)),
        ],
      ),
      backgroundColor: Colors.green,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
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

// Product Details Content
class ProductDetailsContent extends StatelessWidget {
  final ProductResponse productResponse;
  const ProductDetailsContent({Key? key, required this.productResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterCubit = ServiceLocator.instance<CounterCubit>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: productResponse.id.toString(),
            child: CachedNetworkImage(
              imageUrl: productResponse.imageUrl.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(productResponse.title.en, style: TextStyle(fontSize: 20, color: Colors.green)),
          Text(productResponse.description.en, style: TextStyle(fontSize: 20, color: Colors.grey)),
          Text('\$${productResponse.price.toString()}', style: TextStyle(fontSize: 20, color: Colors.black)),
          SizedBox(height: 10),
          CounterWidget(),
        ],
      ),
    );
  }
}

// Counter Widget
class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            counterCubit.increment();
          },
          child: Container(
            height: 55,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green,
            ),
            child: Center(child: Icon(Icons.add, color: Colors.white, size: 30)),
          ),
        ),
        SizedBox(width: 10),
        BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Container(
              height: 55,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text(state.toString(), style: TextStyle(fontSize: 20, color: Colors.green))),
            );
          },
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            if (counterCubit.state > 1) {
              counterCubit.decrement();
            }
          },
          child: Container(
            height: 55,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green,
            ),
            child: Center(child: Icon(Icons.remove, color: Colors.white, size: 30)),
          ),
        ),
      ],
    );
  }
}
