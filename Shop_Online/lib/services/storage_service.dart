import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference reference =
    _storage.ref().child('products/$fileName.jpg');

    UploadTask uploadTask = reference.putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}