import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('products').get();

      _products = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return ProductModel(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Lỗi lấy sản phẩm: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').add({
        'name': product.name,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
      });

      await fetchProducts();
    } catch (e) {
      debugPrint('Lỗi thêm sản phẩm: $e');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.id).update({
        'name': product.name,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
      });

      await fetchProducts();
    } catch (e) {
      debugPrint('Lỗi cập nhật sản phẩm: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();

      _products.removeWhere((product) => product.id == productId);

      notifyListeners();
    } catch (e) {
      debugPrint('Lỗi xoá sản phẩm: $e');
    }
  }

  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}