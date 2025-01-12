import 'package:dio/dio.dart';

import '../dio_instance.dart';
import '../repository/betterU_repository.dart';


class AiServices {
  final DioInstance _dioInstance = DioInstance();

  Future<Response> postCalculateNutrition({
    required String dateOfBirth,
    required String goals,
    required String gender,
    required String activityLevel,
    required String weight,
    required String height,
  }) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postCalculateNutrition,
        data: {
          'gender': gender,
          'age': calculateAge(dateOfBirth),
          'weight': weight,
          'height': height,
          'activity_level': activityLevel,
          'goal': goals,
        },
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> postRecommendationFood({String? imageUrl}) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.urlMetaAi,
        isAuthorize: true,
        isMetaToken: true,
        data: {
          "model": "meta-llama/Llama-3.2-11B-Vision-Instruct",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": "Berikan informasi tentang 4 makanan yang similar dengan: \"nasi goreng\". Formatkan respons Anda dalam JSON dengan struktur berikut:\n{\n\"makanan_one\": \"\",\n\"makanan_two\": \"\",\n\"makanan_three\": \"\",\n\"makanan_four\": \"\",\n}\nPastikan untuk hanya memberikan data dalam format JSON tanpa penjelasan tambahan."
                },
                {
                  "type": "image_url",
                  "image_url": {
                    "url": imageUrl
                  }
                }
              ]
            }
          ],
          "max_tokens": 500,
          "stream": false
        }
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  int calculateAge(String dateOfBirth) {
    final birthDate = DateTime.parse(dateOfBirth); 
    final currentDate = DateTime.now();
    
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }


}