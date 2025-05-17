import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  DataService dataService = DataService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordSecondController =
      TextEditingController();

  Future<void> registerAccount() async {
    final email = _emailController.text;
    final name = _nameController.text;
    final password = _passwordController.text;
    final secondPassword = _passwordSecondController.text;

    if (password != secondPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mật khẩu và mật khẩu xác nhận sai')),
      );
    } else {
      final checkIsExist = await dataService.checkExistAccount(email);
      if (!checkIsExist) {
        await dataService.addNewUser(name, email, password);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Đăng ký thành công')));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Email đã tồn tại')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng ký')),
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
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.account_box_rounded),
                ),
                labelText: 'Tên của bạn',
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            TextField(
              controller: _passwordSecondController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.password),
                ),
                labelText: 'Xác nhận mật khẩu',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Đã có tài khoản ? Đăng nhập tại đây',
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
                  registerAccount();
                },
                child: Text(
                  'Đăng ký',
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
