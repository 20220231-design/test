import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;
  bool obscure1 = true;
  bool obscure2 = true;

  Future<void> register() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu phải từ 6 ký tự trở lên'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordController.text.trim() != confirmController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu xác nhận không khớp'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String result = await authProvider.register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 380),
                        child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  const Icon(
                                  Icons.person_add,
                                  size: 60,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                    'Đăng ký tài khoản',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        prefixIcon: const Icon(Icons.email),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: obscure1,
                                      decoration: InputDecoration(
                                        labelText: 'Mật khẩu',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        prefixIcon: const Icon(Icons.lock),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextField(
                                      controller: confirmController,
                                      obscureText: obscure2,
                                      decoration: InputDecoration(
                                        labelText: 'Xác nhận mật khẩu',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        prefixIcon: const Icon(Icons.lock_outline),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: isLoading ? null : register,
                                        child: isLoading
                                            ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                            : const Text('Đăng ký'),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        ),
    );
  }
}