import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/presentation/controller/categories/categories_cubit.dart';

class HomeScreen extends StatelessWidget {
  final int branchId;
  HomeScreen({Key? key, required this.branchId}) : super(key: key);
  final categoriesCubit = ServiceLocator.instance<CategoriesCubit>();
  final List<Product> products = [
    Product(
      name: "Smartphone",
      description: "Latest smartphone model",
      price: 999,
      imageUrl: "https://placehold.co/600x400.png",
    ),
    Product(
      name: "T-shirt",
      description: "Comfortable cotton t-shirt",
      price: 20,
      imageUrl: "https://placehold.co/600x400.png",
    ),
    Product(
      name: "Book",
      description: "Bestseller novel",
      price: 15,
      imageUrl: "https://placehold.co/600x400.png",
    ),
    Product(
      name: "Book",
      description: "Bestseller novel",
      price: 15,
      imageUrl: "https://placehold.co/600x400.png",
    ),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    categoriesCubit.getCategories(branchId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Catalog'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if(state is CategoriesLoading){
                return Center(child: CircularProgressIndicator(),);
              }else if(state is CategoriesLoaded){
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
              }else if(state is CategoriesError){
                return Center(child: Text(state.errorMessage.msg),);
              }else{
                return Center(child: Text('Something went wrong'),);
              }

            },
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoriesResponse category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
        height: 80.h,
        width: 80.w,
        child: Center(
          child: Image.network(category.image),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  product.description,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  '\$${product.price.toString()}',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
