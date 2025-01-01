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


