import 'package:dio/dio.dart';

import '../auth/repository/betterU_repository.dart';
import '../dio_instance.dart';


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