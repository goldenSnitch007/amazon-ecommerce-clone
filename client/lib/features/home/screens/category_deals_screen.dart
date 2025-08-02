import 'package:client/common/widgets/loader.dart';
import 'package:client/common/widgets/product_card.dart';
import 'package:client/constants/global_variables.dart';
import 'package:client/features/home/services/home_service.dart';
import 'package:client/features/product_details/screens/product_details_screen.dart';
import 'package:client/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  void fetchCategoryProducts() async {
    productList = await homeService.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : productList!.isEmpty
              ? const Center(
                  child: Text('No products found in this category.'),
                )
              : ListView.builder(
                  itemCount: productList!.length,
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailScreen.routeName,
                          arguments: product,
                        );
                      },
                      child: ProductCard(
                        product: product,
                      ),
                    );
                  },
                ),
    );
  }
}