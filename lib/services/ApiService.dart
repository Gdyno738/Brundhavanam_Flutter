import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.88.20:8888/api/v1/user/cows";

  /// 🔹 GET ADDRESSES
  static Future<List<dynamic>> getAddresses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/addresses'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load addresses");
    }
  }

  /// 🔹 CREATE BOOKING
  static Future<bool> createBooking(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/book-cow'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    return response.statusCode == 200;
  }
}
