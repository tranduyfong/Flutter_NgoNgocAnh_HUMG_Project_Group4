import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static final String baseUrl = 'http://192.168.110.68:3000';

  Future<List<dynamic>> getAllData() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<List<dynamic>> getDataSomeNews(int idBao) async {
    final response = await http.get(Uri.parse('$baseUrl/getNews/$idBao'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

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

  static Future<Map<String, dynamic>> addArticleFavourite(int idBao) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

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
      throw Exception('Không thể tải dữ liệu');
    }
  }

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
}
