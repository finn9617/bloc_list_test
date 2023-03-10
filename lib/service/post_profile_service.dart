import 'dart:convert';

import 'package:http/http.dart';

class PostProfileSevice {

  static const FETCH_LIMIT = 10;
  final baseUrl = "https://reqres.in/api/users?page=";

  Future getPost(int page) async {
    try {
      final response = await get(Uri.parse(baseUrl + "$page&limit=10"));
      return jsonDecode(response.body);
    } catch (e) {
      return "";
    }
  }

}