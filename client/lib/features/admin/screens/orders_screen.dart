import 'package:client/common/widgets/loader.dart';
import 'package:client/features/account/widgets/single_product.dart';
import 'package:client/features/admin/services/admin_service.dart';
import 'package:client/features/order_details/screens/order_details_screen.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    List<Order> fetchedOrders = await adminService.fetchAllOrders(context);
    // THIS IS THE FIX: Filter the list to only include orders with products
    orders = fetchedOrders.where((order) => order.products.isNotEmpty).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return const Loader();
    }
    if (orders!.isEmpty) {
      return const Center(child: Text('No valid orders found.'));
    }

    return GridView.builder(
      itemCount: orders!.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final orderData = orders![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              OrderDetailScreen.routeName,
              arguments: orderData,
            );
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(
              image: orderData.products[0].images[0],
            ),
          ),
        );
      },
    );
  }
}