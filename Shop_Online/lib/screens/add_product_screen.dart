import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import '../services/storage_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController =
  TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final ProductService productService = ProductService();
  final StorageService storageService = StorageService();
  final ImagePicker picker = ImagePicker();

  File? selectedImage;
  bool isLoading = false;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> saveProduct() async {
    if (nameController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin và chọn ảnh'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String imageUrl = await storageService.uploadImage(selectedImage!);

      ProductModel product = ProductModel(
        id: '',
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        imageUrl: imageUrl,
      );

      await productService.addProduct(product);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm sản phẩm thành công'),
        ),
      );

      nameController.clear();
      descriptionController.clear();
      priceController.clear();

      setState(() {
        selectedImage = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $e'),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text('Nhấn để chọn ảnh sản phẩm'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Tên sản phẩm',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Mô tả sản phẩm',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Giá sản phẩm',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveProduct,
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  'Lưu sản phẩm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}