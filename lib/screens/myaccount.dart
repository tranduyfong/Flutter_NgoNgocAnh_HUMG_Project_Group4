import 'package:flutter/material.dart';
import 'package:flutter_project_group4/main.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreen();
}

class _MyAccountScreen extends State<MyAccountScreen> {
  DataService dataService = DataService();
  bool userIsLoggedIn = false;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final token = prefs.getString('jwtToken');

    setState(() {
      userIsLoggedIn = isLoggedIn && token != null && token.isNotEmpty;
    });

    if (userIsLoggedIn) {
      _getDataUserName(); // Chỉ gọi khi đã đăng nhập
    }
  }

  Future<void> _getDataUserName() async {
    final data = await dataService.getUserData();
    setState(() {
      userName = data[0]['TenNguoiDung'];
    });
  }

  // Đăng xuất
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Xóa token và trạng thái đăng nhập
    await prefs.remove('jwtToken');
    await prefs.setBool('isLoggedIn', false);

    // Cập nhật lại trạng thái đăng nhập và điều hướng người dùng
    setState(() {
      userIsLoggedIn = false;
      userName = '';
    });
  }

  void _dialogToLogOut() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Bạn có muốn đăng xuất không ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  _logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                    (Route<dynamic> route) =>
                        false, // Xóa tất cả các route trước đó
                  );
                },
                child: Text('Đăng xuất', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          toolbarHeight: 80,
          title: Center(
            child: Column(
              children: [
                Text(
                  'Cá nhân',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Divider(height: 0.1),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/05/70/71/06/360_F_570710660_Jana1ujcJyQTiT2rIzvfmyXzXamVcby8.jpg',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (!userIsLoggedIn) {
                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: Text(
                  userIsLoggedIn ? userName : 'Đăng nhập',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            if (userIsLoggedIn) {
              _dialogToLogOut();
            }
          },
          child: Text('Đăng xuất', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
