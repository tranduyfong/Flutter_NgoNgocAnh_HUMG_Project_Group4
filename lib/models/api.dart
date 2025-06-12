import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static final String baseUrl = 'http://192.168.61.104:3000';

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

  Future<Map<String, dynamic>> deleteArticleFavouriteAfterDeleteArtical(
    int idBao,
  ) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/articleFavourite/$idBao'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<Map<String, dynamic>> editArticle(
    String tieuDe,
    String gioiThieu,
    String linkBaiBao,
    String noiDungBaiBao,
    int tacGia,
    int danhMuc,
    int idBao,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/article/$idBao'),
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

  Future<List<dynamic>> getFavouritesList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final response = await http.get(
      Uri.parse('$baseUrl/get/list/favourites'),
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

  Future<List<dynamic>> findArticle(String titleFinding) async {
    final response = await http.post(
      Uri.parse('$baseUrl/get/list/find'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"noiDung": titleFinding}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<Map<String, dynamic>> upViewArticle(int idBao) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/view/$idBao'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getArticleManyReads() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/articleManyReads'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getHotCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/hot'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getNewCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/new'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getVietNamFootballCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/vietnamfootball'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getInternationalFootballCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/international'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getDocLaCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/docvala'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getLovedCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/loved'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getEntertaimentCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/entertaiment'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getWorldCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/world'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getLawCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/law'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getDataVideoReels() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/video'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<bool> checkLikedVideo(int idVideo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    if (token == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/checkLikedVideo/$idVideo'),
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

  // API to remove video in database
  static Future<Map<String, dynamic>> deleteVideoFavourite(int idVideo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final response = await http.delete(
      Uri.parse('$baseUrl/video/favourite/$idVideo/delete'),
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

  // API to add new video in database
  static Future<Map<String, dynamic>> addVideoFavourite(int idVideo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');
    if (token == null || token.isEmpty) {
      throw Exception('can not find token');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/video/favourite/$idVideo/like'),
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

  Future<Map<String, dynamic>> addNewVideo(
    String tieuDe,
    String linkVideo,
    int tacGia,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create/video'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tieuDe': tieuDe,
        'video_path': linkVideo,
        'tacGia': tacGia,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<Map<String, dynamic>> deleteVideo(int idVideo) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/video/$idVideo'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<Map<String, dynamic>> deleteVideoFavouriteAfterDeleteVideo(
    int idVideo,
  ) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/videoFavourite/$idVideo'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  // API to get data some article
  Future<List<dynamic>> getDataSomeVideo(int idVideo) async {
    final response = await http.get(Uri.parse('$baseUrl/getVideo/$idVideo'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<Map<String, dynamic>> editVideo(
    String tieuDe,
    String linkVideo,
    int tacGia,
    int idVideo,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/video/$idVideo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'TieuDe': tieuDe,
        'video_path': linkVideo,
        'idTacGia': tacGia,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Loi van de');
    }
  }

  Future<List<dynamic>> getVideoFavouritesList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');

    final response = await http.get(
      Uri.parse('$baseUrl/get/list/favourites/video'),
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
}
