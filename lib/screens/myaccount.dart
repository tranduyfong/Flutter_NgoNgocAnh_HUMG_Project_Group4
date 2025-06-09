import 'package:flutter/material.dart';
import 'package:flutter_project_group4/main.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/screens/favourites.dart';
import 'package:flutter_project_group4/screens/listtitle.dart';
import 'package:flutter_project_group4/screens/listvideo.dart';
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
  int isAdmin = 0; // User khi = 0 và Admin khi = 1

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Hàm kiểm tra xem đã đăng nhập hay chưa
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

  // Hàm lấy tên người dùng
  Future<void> _getDataUserName() async {
    final data = await dataService.getUserData();
    setState(() {
      userName = data[0]['TenNguoiDung'];
      isAdmin = data[0]['PhanLoaiTaiKhoan'];
    });
  }

  // Hàm để đăng xuất tài khoản
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

  // Hàm trả về widget cho user hay admin
  Widget isForAdminWidget() {
    if (isAdmin == 1) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListTitleScreens(),
                      ),
                    );
                  },
                  icon: Icon(Icons.list, size: 30, color: Colors.blue),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListTitleScreens(),
                      ),
                    );
                  },
                  child: Text(
                    'Danh sách bài báo',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListTitleScreens(),
                      ),
                    );
                  },
                  icon: Icon(Icons.list, size: 30, color: Colors.blue),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListVideoScreens(),
                      ),
                    );
                  },
                  child: Text(
                    'Danh sách video reels',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavouritesScreen(),
                  ),
                );
              },
              icon: Icon(Icons.favorite, size: 30, color: Colors.red),
            ),
            TextButton(
              onPressed: () {
                if (userIsLoggedIn == false) {
                  showDialogToRequestLogin();
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavouritesScreen(),
                    ),
                  );
                }
              },
              child: Text('Đã thích', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
  }

  // Hàm hiện dialog để xác nhận đăng xuất
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

  // Hàm yêu cầu người dùng đăng nhập
  void showDialogToRequestLogin() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Bạn chưa đăng nhập',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('Hãy đăng nhập để xem danh sách yêu thích bài báo'),
            actions: [
              TextButton(
                onPressed: () {
                  // Đóng dialog khi nhấn nút Hủy
                  Navigator.of(context).pop();
                },
                child: Text('Hủy', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Điều hướng đến màn hình đăng nhập
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Đăng nhập'),
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
          backgroundColor: Colors.blue,
          toolbarHeight: 80,
          title: Center(
            child: Column(
              children: [
                Text(
                  'Cá nhân',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Divider(height: 0.1, color: Colors.white),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SizedBox(
                  height: 50,
                  width: 50,
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        isForAdminWidget(),
        Container(height: 3, color: const Color.fromARGB(255, 227, 222, 222)),
        if (userIsLoggedIn) // Only show if userIsLoggedIn is true
          TextButton(
            onPressed: () {
              _dialogToLogOut();
            },
            child: Text(
              'Đăng xuất',
              style: TextStyle(color: Colors.redAccent, fontSize: 18),
            ),
          ),
      ],
    );
  }
}
