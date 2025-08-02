import 'package:client/common/widgets/loader.dart';
import 'package:client/constants/global_variables.dart';
import 'package:client/features/account/services/account_service.dart';
import 'package:client/features/account/widgets/single_product.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';

class YourOrdersScreen extends StatefulWidget {
  static const String routeName = '/your-orders';
  const YourOrdersScreen({Key? key}) : super(key: key);

  @override
  State<YourOrdersScreen> createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  List<Order>? orders;
  final AccountService accountService = AccountService();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountService.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text('Your Orders', style: TextStyle(color: Colors.black)),
        ),
      ),
      body: orders == null
          ? const Loader()
          : ListView.builder(
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID: ${orders![index].id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Total: \$${orders![index].totalPrice.toStringAsFixed(2)}'),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: orders![index].products.length,
                          itemBuilder: (context, prodIndex) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SingleProduct(
                                image: orders![index].products[prodIndex].images[0],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}