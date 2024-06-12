import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthHttpServices {
  final String _apiKey = "AIzaSyC7Y7uWlHvBpUslcrC0zF-jfFFLEjD7D9E";

  Future<Map<String, dynamic>> _authenticate(
      String email, String password, String nima) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    return await _authenticate(email, password, "signUp");
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _authenticate(email, password, "signInWithPassword");
  }
}
