import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Image.network(product.image, height: 200),
            const SizedBox(height: 20),
            Text(product.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            Text("${product.price} VND",
                style: const TextStyle(
                    color: Colors.red, fontSize: 18)),
            const SizedBox(height: 10),
            Text(product.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Thêm vào giỏ hàng"),
            )
          ],
        ),
      ),
    );
  }
}