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
}
