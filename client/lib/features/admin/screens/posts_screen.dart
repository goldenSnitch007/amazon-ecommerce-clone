import 'package:client/common/widgets/loader.dart';
import 'package:client/constants/utils.dart';
import 'package:client/features/admin/screens/add_product_screen.dart';
import 'package:client/features/admin/services/admin_service.dart';
import 'package:client/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    products = await adminService.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
        showSnackBar(context, 'Product Deleted Successfully!');
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                final productData = products![index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading: Image.network(
                      productData.images[0],
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      productData.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteProduct(productData, index),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}