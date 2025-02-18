import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../dio_instance.dart';
import '../repository/betterU_repository.dart';

class NutritionServices {
  final DioInstance _dioInstance = DioInstance();

  /// GET ///

  Future<Response> showCurrentTotalNutrition(
      {bool? isHistory = false, String? date}) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getCurrentTotalNutrition,
        queryParameters: {
          'date': isHistory == false ? formattedDate : date,
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
          'days': filterDate ?? '',
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showCurrentCombo(
      {bool? isHistory = false, String? date}) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getCurrentCombo,
        queryParameters: {
          'date': isHistory == false ? formattedDate : date,
        },
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showCurrentDailyWater() async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getCurrentDailyWater,
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

  Future<Response> showCurrentDailyWaterByDate({required String date}) async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getCurrentDailyWater,
        queryParameters: {
          'date': date,
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

  Future<Response> putDailyWater({
    required String amount,
  }) async {
    try {
      final response = await _dioInstance.putRequest(
        endpoint: BetterUApiRepository.putEditDailyWater,
        data: {
          'amount': amount,
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

  Future<Response> postDailyWaterIncrease() async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postDailyWaterIncrease,
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> postDailyWaterDecrease() async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: BetterUApiRepository.postDailyWaterDecrease,
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// DELETE ///

  Future<Response> deleteDailyActivity(int dailyActivityID) async {
    try {
      final response = await _dioInstance.deleteRequest(
        endpoint:
            '${BetterUApiRepository.deleteDailyActivity}/$dailyActivityID',
        isAuthorize: true,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
