import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String?> loginAPI(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.21:3000/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Trả về token nếu thành công
    } else {
      return null; // Đăng nhập thất bại
    }
  }

  // Hàm xử lý đăng nhập
  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final token = await loginAPI(email, password);

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('jwtToken', token);

      final Map<String, String> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>? ??
          {};

      String? articleId = args['articleId'];
      Navigator.of(context).pop();
      if (articleId != null) {
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email hoặc mật khẩu không đúng')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Đăng nhập')),
          ],
        ),
      ),
    );
  }
}
