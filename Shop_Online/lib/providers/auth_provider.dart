import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  bool get isLoggedIn => _auth.currentUser != null;

  // Tài khoản demo fix cứng
  static const String demoEmail = 'admin@gmail.com';
  static const String demoPassword = '123456';

  Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (userCredential.user != null) {
        notifyListeners();
        return 'success';
      }

      return 'Không thể tạo tài khoản';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email đã tồn tại';
        case 'invalid-email':
          return 'Email không hợp lệ';
        case 'weak-password':
          return 'Mật khẩu quá yếu';
        case 'operation-not-allowed':
          return 'Chưa bật Email/Password trong Firebase';
        case 'network-request-failed':
          return 'Không có kết nối mạng';
        default:
          return 'Lỗi đăng ký: ${e.message}';
      }
    } catch (e) {
      return 'Đăng ký thất bại';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      // Demo login fix cứng
      if (email.trim() == demoEmail && password.trim() == demoPassword) {
        return 'success';
      }

      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (userCredential.user != null) {
        notifyListeners();
        return 'success';
      }

      return 'Không thể đăng nhập';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Không tìm thấy tài khoản';
        case 'wrong-password':
          return 'Sai mật khẩu';
        case 'invalid-email':
          return 'Email không hợp lệ';
        case 'invalid-credential':
          return 'Sai email hoặc mật khẩu';
        case 'network-request-failed':
          return 'Không có kết nối mạng';
        default:
          return 'Lỗi đăng nhập: ${e.message}';
      }
    } catch (e) {
      return 'Đăng nhập thất bại';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}