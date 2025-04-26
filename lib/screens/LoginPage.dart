import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Giả lập thông tin đăng nhập
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hàm xử lý đăng nhập
  Future<void> _login() async {
    // Kiểm tra thông tin đăng nhập (thực tế, bạn cần gọi API ở đây)
    if (_emailController.text == 'test@example.com' &&
        _passwordController.text == 'password') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Lưu trạng thái đăng nhập

      // Lấy thông tin từ arguments để chuyển về bài báo đã like
      final Map<String, String> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, String> ??
          {};
      String? articleId = args['articleId'];

      Navigator.pop(context); // Quay lại trang trước (Home)
      if (articleId != null) {
        // Quay lại trang Home và thực hiện hành động like
        Navigator.pop(context);
        // Thực hiện lại hành động like ở đây nếu cần
      }
    } else {
      // Thông báo lỗi đăng nhập
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đăng nhập thất bại')));
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
