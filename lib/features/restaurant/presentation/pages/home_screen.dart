import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/service/remote/service_locator.dart';
import 'package:restaurant/features/restaurant/domain/entities/categories/categories_response.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_request.dart';
import 'package:restaurant/features/restaurant/domain/entities/product/product_response.dart';
import 'package:restaurant/features/restaurant/presentation/controller/categories/categories_cubit.dart';
import 'package:restaurant/features/restaurant/presentation/controller/product/product_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/features/restaurant/presentation/pages/product_details.dart';
class HomeScreen extends StatefulWidget {
  final int branchId;

  const HomeScreen({super.key, required this.branchId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedCategoryId;
  final categoriesCubit = ServiceLocator.instance<CategoriesCubit>();
  final productCubit = ServiceLocator.instance<ProductCubit>();

  @override
  void initState() {
    super.initState();
    categoriesCubit.getCategories(widget.branchId);
    // Initialize with no category selected
    selectedCategoryId = 0;
  }
  @override
  void dispose() {
 productCubit.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CategoriesLoaded) {
                // Update products when a category is selected
                if (selectedCategoryId == 0) {
                  selectedCategoryId = state.categoriesResponse.first.id;
                  productCubit.getProducts(ProductsRequest(
                      categoryId: state.categoriesResponse.first.id,
                      branchId: widget.branchId));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.categoriesResponse
                        .map(
                          (category) => CategoryItem(
                        category: category,
                        branchId: widget.branchId,
                        isSelected: selectedCategoryId == category.id,
                        onTap: () {
                          productCubit.getProducts(ProductsRequest(
                              categoryId: category.id,
                              branchId: widget.branchId));
                          setState(() {
                            selectedCategoryId = category.id;
                          });
                        },
                      ),
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
                      childAspectRatio: 0.58,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductItem(product: product);
                    },
                  ),
                );
              } else if (state is ProductError) {
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

class CategoryItem extends StatelessWidget {
  final CategoriesResponse category;
  final int branchId;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.branchId,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.green.shade300 : Colors.grey.shade300,
          ),
          height: 80,
          width: 80,
          child: Center(
            child: Image.network(category.image),
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
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(productResponse: product,)));
      },
      child: Card(
        child: Column(
          children: [
            Hero(
              tag: product.id.toString(),
              child: CachedNetworkImage(
                imageUrl:  product.imageUrl.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text(
                    product.description.en,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toString()}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border))
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}