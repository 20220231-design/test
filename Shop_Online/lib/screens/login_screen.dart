import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscure = true;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập email và mật khẩu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    String result = await authProvider.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
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
                                  Icons.shopping_cart,
                                  size: 60,
                                  color: Colors.blue,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Shop Online',
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
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                        labelText: 'Mật khẩu',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              obscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () {
                                              setState(() => obscure = !obscure);
                                            },
                                        ),
                                    ),
                                ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: isLoading ? null : login,
                                        child: isLoading
                                            ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                            : const Text('Đăng nhập'),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Tài khoản demo:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const Text('Email: admin@gmail.com'),
                                    const Text('Password: 123456'),
                                    const SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text('Chưa có tài khoản? Đăng ký'),
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