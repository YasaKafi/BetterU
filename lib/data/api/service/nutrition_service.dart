import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../auth/repository/betterU_repository.dart';
import '../dio_instance.dart';


class NutritionServices {
  final DioInstance _dioInstance = DioInstance();


  /// GET ///

  Future<Response> showCurrentTotalNutrition() async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getCurrentTotalNutrition,
        queryParameters: {
          'date': formattedDate,
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showHistoryTotalNutrition({String? filterDate}) async {
    try {

      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getHistoryTotalNutrition,
        queryParameters: {
          'days': filterDate,
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showCurrentCombo() async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getCurrentCombo,
        queryParameters: {
          'date': formattedDate,
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  /// PUT ///

  Future<Response> putDailyActivity({
    required String category,
    required String name,
    required String kalori,
    required String lemak,
    required String protein,
    required String karbohidrat,
    required int dailyActivityID,
  }) async {
    try {
      final response = await _dioInstance.putRequest(
        endpoint: '${BetterUApiRepository.putDailyActivity}/$dailyActivityID',
        data: {
          'category': category,
          'name': name,
          'kalori': kalori,
          if (lemak.isNotEmpty) "lemak": lemak,
          if (protein.isNotEmpty) "protein": protein,
          if (karbohidrat.isNotEmpty) "karbohidrat": karbohidrat,
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  /// POST ///

  Future<Response> postDailyActivity({
    required String category,
    required String name,
    required String kalori,
    required String lemak,
    required String protein,
    required String karbohidrat,
    required String note,
  }) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postDailyActivity,
        data: {
          'category': category,
          'name': name,
          'kalori': kalori,
          "lemak": lemak,
          "protein": protein,
          "karbohidrat": karbohidrat,
          "note": note,
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Response> postPredict({
    required File file,
  }) async {
    try {
      // Buat FormData dengan file dan data lainnya
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      // Kirim request POST dengan FormData
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postPredictFood,
        data: formData,
        isAuthorize: true,
        isMultipart: true,
      );

      return response;
    } catch (e) {
      print("Error posting file: $e");
      throw Exception(e);
    }
  }


  Future<Response> postImageToUrl({
    required File file,
  }) async {
    try {
      // Buat FormData dengan file dan data lainnya
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      // Kirim request POST dengan FormData
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postImageToUrl,
        data: formData,
        isAuthorize: true,
        isMultipart: true,
      );

      return response;
    } catch (e) {
      print("Error posting file: $e");
      throw Exception(e);
    }
  }



  /// DELETE ///


  Future<Response> deleteDailyActivity(int dailyActivityID) async {
    try {
      final response = await _dioInstance.deleteRequest(
        endpoint: '${BetterUApiRepository.deleteDailyActivity}/$dailyActivityID',
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}


