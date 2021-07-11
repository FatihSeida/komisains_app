import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpRepository {
  Future<String> signup(Map<String, String> profile) async {
    try {
      final response = await http
          .post(Uri.parse('https://api.komdakkomcakaba.my.id/api/register'),
              body: json.encode(
                {
                  'name': profile['name'],
                  'email': profile['email'],
                  'password': profile['password'],
                  'password_confirmation': profile['password_confirmation'],
                  'nohp': profile['nohp'],
                  'department': profile['department'],
                  'sex': profile['sex'],
                  'angkatan_kuliah': profile['angkatan_kuliah'],
                },
              ),
              headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          });
      final responseData = json.decode(response.body);
      return responseData['message'];
    } catch (error) {
      throw error;
    }
  }
}
