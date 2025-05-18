import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static final String baseUrl = 'http://192.168.61.102:3000';

  // API to get all data of new
  Future<List<dynamic>> getAllData() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  // API to get data some article
  Future<List<dynamic>> getDataSomeNews(int idBao) async {
    final response = await http.get(Uri.parse('$baseUrl/getNews/$idBao'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  // API to remove article in database
  static Future<Map<String, dynamic>> deleteArticleFavourite(int idBao) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final response = await http.delete(
      Uri.parse('$baseUrl/favourite/$idBao/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  // API to add new article in database
  static Future<Map<String, dynamic>> addArticleFavourite(int idBao) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');
    if (token == null || token.isEmpty) {
      throw Exception('can not find token');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/favourite/$idBao/like'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error...');
    }
  }

  // API to get token JWT
  static Future<String?> getTokenLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      return null;
    }
  }

  // API to check the user is liked the article
  Future<List<dynamic>> checkLikedArticle(int idBao) async {
    final response = await http.get(
      Uri.parse('$baseUrl/checkLikedArticle/$idBao'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  // The function to check liked article
  Future<bool> checkLiked(int idBao) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    if (token == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/checkLikedArticle/$idBao'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // The function to get data user
  Future<List<dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final response = await http.get(
      Uri.parse('$baseUrl/user/data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<Map<String, dynamic>> addNewUser(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<bool> checkExistAccount(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/checkExistAccount/$email'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> addNewArticle(
    String tieuDe,
    String gioiThieu,
    String linkBaiBao,
    String noiDungBaiBao,
    int tacGia,
    int danhMuc,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create/article'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tieuDe': tieuDe,
        'gioiThieu': gioiThieu,
        'noiDung': noiDungBaiBao,
        'img_path': linkBaiBao,
        'tacGia': tacGia,
        'danhMuc': danhMuc,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<Map<String, dynamic>> deleteArticle(int idBao) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/article/$idBao'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }
}
