import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenRouterAPI {
  final String apiUrl = dotenv.env['MODEL_AI_URL'] ?? 'default_value';
  final String apiKey = dotenv.env['APIKEY_META'] ?? 'default_value';

  // Fungsi untuk mengirimkan permintaan POST ke API
  Future<String> callChatModel(String userMessage) async {
    final body = {
      'model': dotenv.env['MODEL_AI'] ?? 'default_value',
      'messages': [
        {
          'role': 'user',
          'content': userMessage,
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode(body), // Ubah body ke format JSON
      );

      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'];
        } else {
          return "Tidak ada pilihan yang tersedia dalam respons.";
        }
      } else {
        return "Request gagal dengan status code: ${response.statusCode}";
      }
    } catch (e, stackTrace) {
      print("Terjadi error: $e");
      print("Stack trace: $stackTrace");
      return "Terjadi error: $e";
    }
  }
}
