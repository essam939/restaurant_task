import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/presentation/controller/categories/categories_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/controller/product/product_cubit.dart';

class HomeScreen extends StatelessWidget {
  final int branchId;

  HomeScreen({Key? key, required this.branchId}) : super(key: key);
  final categoriesCubit = ServiceLocator.instance<CategoriesCubit>();


  @override
  Widget build(BuildContext context) {
    categoriesCubit.getCategories(branchId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoriesLoaded) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.categoriesResponse
                        .map(
                          (category) => CategoryItem(category: category),
                    )
                        .toList(),
                  ),
                );
              } else if (state is CategoriesError) {
                return Center(
                  child: Text(state.errorMessage.msg),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductLoaded) {
                final products = state.productResponse;
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductItem(product: product);
                    },
                  ),
                );
              }else if (state is ProductError) {
                return Center(
                  child: Text(state.errorMessage.msg),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

            },
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final CategoriesResponse category;

  const CategoryItem({super.key, required this.category});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final productCubit = ServiceLocator.instance<ProductCubit>();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print(widget.category.id);
          productCubit.getProducts(widget.category.id);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
          ),
          height: 80.h,
          width: 80.w,
          child: Center(
            child: Image.network(widget.category.image),
          ),
        ),
      ),
    );
  }
}


class ProductItem extends StatelessWidget {
  final ProductResponse product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title.en,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  product.description.en,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  '\$${product.price.toString()}',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
