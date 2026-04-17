import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').add({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
    });
  }

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore.collection('products').get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromMap(
        doc.data(),
        doc.id,
      );
    }).toList();
  }
}