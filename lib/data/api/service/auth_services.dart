import 'package:dio/dio.dart';

import '../auth/repository/betterU_repository.dart';
import '../dio_instance.dart';


class AuthServices {
  final DioInstance _dioInstance = DioInstance();

  Future<Response> postRegister({
    required String name,
    required String email,
    required String password,
    required String dateOfBirth,
    required String goals,
    required String gender,
    required String activityLevel,
    required String weight,
    required String height,
  }) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postRegister,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'date_of_birth': dateOfBirth,
          'goals': goals,
          'gender': gender,
          'activity_level': activityLevel,
          'weight': weight,
          'height': height,
        },
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Response> postOtpCode({
    required String email,
  }) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postOtpCode,
        data: {
          'email': email,
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> postOtpCheck({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postOtpCheck,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


}