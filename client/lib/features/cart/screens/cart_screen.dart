import 'package:client/common/widgets/custom_button.dart';
import 'package:client/constants/global_variables.dart';
import 'package:client/features/address/screens/address_screen.dart';
import 'package:client/features/cart/widgets/cart_product.dart';
import 'package:client/features/cart/widgets/cart_subtotal.dart';
import 'package:client/features/home/widgets/address_box.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToAddressScreen(double sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toStringAsFixed(2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'])
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Proceed to Buy (${user.cart.length} items)',
                onTap: user.cart.isEmpty ? (){} : () => navigateToAddressScreen(sum),
                color: const Color(0xffFFD814),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.cart.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}