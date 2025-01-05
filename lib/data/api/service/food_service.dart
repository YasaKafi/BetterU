import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../auth/repository/betterU_repository.dart';
import '../dio_instance.dart';


class FoodServices {
  final DioInstance _dioInstance = DioInstance();


  /// GET ///

  Future<Response> showAllFoodByGoals({required String goals}) async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getAllFood,
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

  Future<Response> showAllFoodByClickCountDesc() async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: BetterUApiRepository.getAllFood,
        queryParameters: {
          'sort_click_count': 'desc',
        },
        isAuthorize: false,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> showFoodById({required String id}) async {
    try {
      final response = await _dioInstance.getRequest(
        endpoint: '${BetterUApiRepository.getFoodById}/$id',
        isAuthorize: false,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

}


