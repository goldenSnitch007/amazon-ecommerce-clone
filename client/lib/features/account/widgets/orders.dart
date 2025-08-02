import 'package:client/common/widgets/loader.dart';
import 'package:client/constants/global_variables.dart';
import 'package:client/features/account/screens/your_orders_screen.dart';
import 'package:client/features/account/services/account_service.dart';
import 'package:client/features/account/widgets/single_product.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
    if (orders == null) {
      return const Loader();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, YourOrdersScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: orders!.isEmpty
              ? const Center(
                  child: Text('You have not placed any orders yet.'),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    if (orders![index].products.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return SingleProduct(
                      image: orders![index].products[0].images[0],
                    );
                  },
                ),
        ),
      ],
    );
  }
}