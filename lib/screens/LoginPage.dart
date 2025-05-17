import 'package:flutter/material.dart';
import 'package:flutter_project_group4/main.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/screens/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hàm xử lý đăng nhập
  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final token = await DataService.getTokenLogin(email, password);

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('jwtToken', token);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false, // Xóa tất cả các route trước đó
      );
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
            SizedBox(height: 30),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                'https://play-lh.googleusercontent.com/P8D-vfnCmeaP3b3pbS_JmWlDkGGYaPg1xE4rOXMWPiTsL8fKlpsTxgVOkWj7w1ryx0pC',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Báo Mới',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            Text(
              'Luôn cập nhật những tin tức mới trong và ngoài nước',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.email),
                ),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.password),
                ),
                labelText: 'Mật khẩu',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text(
                'Chưa có tài khoản ? Đăng ký tại đây',
                style: TextStyle(
                  color: const Color.fromARGB(255, 81, 50, 238),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _login();
                },
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
