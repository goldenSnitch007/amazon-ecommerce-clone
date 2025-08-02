import 'package:client/common/widgets/loader.dart';
import 'package:client/features/home/services/home_service.dart';
import 'package:client/features/product_details/screens/product_details_screen.dart';
import 'package:client/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product!,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const SizedBox(
        height: 250,
        child: Loader(),
      );
    }
    if (product!.name.isEmpty) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: navigateToDetailScreen,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Deal of the Day',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.network(
                  product!.images[0],
                  height: 235,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product!.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                  Text(
                    product!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (product!.images.length > 1)
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product!.images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.network(
                          product!.images[index],
                          fit: BoxFit.contain,
                          width: 80,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'See all deals',
                  style: TextStyle(
                    color: Colors.cyan[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}