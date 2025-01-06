import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../auth/repository/betterU_repository.dart';
import '../dio_instance.dart';


class SportServices {
  final DioInstance _dioInstance = DioInstance();


  /// GET ///

  Future<Response> showAllSportCategory() async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getAllSportCategory,
        isAuthorize: false,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showAllSportByGoals({required String goals}) async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getAllSport,
        queryParameters: {
          'goals': goals,
        },
        isAuthorize: false,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showAllSportByCategory({required String category}) async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getAllSport,
        queryParameters: {
          'category': category,
        },
        isAuthorize: false,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showAllSportBySearch({required String search}) async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getAllSport,
        queryParameters: {
          'search': search,
        },
        isAuthorize: false,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

}


