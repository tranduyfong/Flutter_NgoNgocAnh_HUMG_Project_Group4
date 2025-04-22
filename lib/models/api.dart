import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl =
      'http://172.20.10.3:3000'; // Dùng 'localhost' nếu test trên web, hoặc IP máy nếu là thiết bị thật

  Future<List<dynamic>> getAllData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }
}
