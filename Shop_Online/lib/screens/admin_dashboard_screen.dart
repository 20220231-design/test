import 'package:flutter/material.dart';
import 'add_product_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text('Thêm sản phẩm'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddProductScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text('Quản lý đơn hàng'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}