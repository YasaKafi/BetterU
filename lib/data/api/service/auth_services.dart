import 'package:dio/dio.dart';

import '../auth/repository/betterU_repository.dart';
import '../dio_instance.dart';


class AuthServices {
  final DioInstance _dioInstance = DioInstance();

  Future<Response> showCurrentUser() async {
    try {
      final response = await _dioInstance.getRequest(
          endpoint: BetterUApiRepository.getCurrentUser,
          isAuthorize: true
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> deleteTokenUser() async {
    try {
      final response = await _dioInstance.deleteRequest(
          endpoint: BetterUApiRepository.deleteTokenUser,
          isAuthorize: true
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> postLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postLogin,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

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

  Future<Response> putEditUser({
    required String userID,
    required String dateOfBirth,
    required String goals,
    required String activityLevel,
    required String weight,
    required String height,
    required String name,
    required String gender,
  }) async {
    try {
      final response = await _dioInstance.putRequest(
        isAuthorize: true,
        endpoint: '${BetterUApiRepository.putEditUser}/$userID',
        data: {
          'name': name,
          'gender': gender,
          'date_of_birth': dateOfBirth,
          'goals': goals,
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