import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin nhận hàng',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Họ tên',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Địa chỉ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Tổng tiền: ${cartProvider.totalPrice.toStringAsFixed(0)} VNĐ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đặt hàng thành công'),
                    ),
                  );
                  cartProvider.clearCart();
                  Navigator.pop(context);
                },
                child: const Text('Xác nhận đặt hàng'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}