import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl =
      'http://192.168.1.21:3000'; // Dùng 'localhost' nếu test trên web, hoặc IP máy nếu là thiết bị thật

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

  Future<List<dynamic>> addArticleFavourite(int idBao) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favourite/$idBao/like'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content_Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }
}
