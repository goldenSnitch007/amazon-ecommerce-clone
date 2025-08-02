import 'package:client/common/widgets/stars.dart';
import 'package:client/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    if (product.rating != null) {
      for (int i = 0; i < product.rating!.length; i++) {
        totalRating += product.rating![i].rating;
      }
    }

    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.network(
                product.images[0],
                fit: BoxFit.contain, // <-- THIS IS THE FIX
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Stars(rating: avgRating),
                const SizedBox(width: 5),
                if (product.rating != null)
                  Text('(${product.rating!.length})'),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}