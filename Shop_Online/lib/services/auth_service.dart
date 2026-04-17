import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Đăng ký thất bại');
    }
  }

  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Đăng nhập thất bại');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Không thể gửi email đặt lại mật khẩu');
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email đã tồn tại';
      case 'invalid-email':
        return 'Email không hợp lệ';
      case 'weak-password':
        return 'Mật khẩu quá yếu';
      case 'operation-not-allowed':
        return 'Chưa bật Email/Password trong Firebase';
      case 'user-not-found':
        return 'Không tìm thấy tài khoản';
      case 'wrong-password':
        return 'Sai mật khẩu';
      case 'invalid-credential':
        return 'Sai email hoặc mật khẩu';
      case 'network-request-failed':
        return 'Không có kết nối mạng';
      case 'too-many-requests':
        return 'Bạn thao tác quá nhiều lần, thử lại sau';
      default:
        return e.message ?? 'Có lỗi xảy ra';
    }
  }
}