import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenRouterAPI {
  final String apiUrl = "https://openrouter.ai/api/v1/chat/completions";
  final String apiKey = "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";

  // Fungsi untuk mengirimkan permintaan POST ke API
  Future<String> callChatModel(String userMessage) async {
    final body = {
      'model': 'meta-llama/llama-3.2-3b-instruct:free',
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
        final data = jsonDecode(response.body); // Pastikan kita melakukan decoding dengan jsonDecode

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
