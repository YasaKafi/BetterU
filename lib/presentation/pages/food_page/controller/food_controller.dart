import 'package:better_u/data/api/auth/model/current_user_model.dart';
import 'package:better_u/data/api/auth/model/food_list_model.dart';
import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/food_service.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {

  RxBool isLoadingFoodRecommendation = false.obs;
  RxBool isLoadingFoodPopular = false.obs;
  late AuthServices userService;
  late FoodServices foodServices;
  late ShowCurrentUserResponse userResponse;
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  Rx<FoodListModel> foodRecommendation = Rx<FoodListModel>(FoodListModel());
  Rx<FoodListModel> foodPopular = Rx<FoodListModel>(FoodListModel());

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    userService = AuthServices();
    foodServices = FoodServices();

    await getCurrentUser();
    await getAllFoodPopular();

    if (dataUser.value != null) {
      await getAllFoodRecommendation();
    }
  }

  void refresh() {
    initialize();
  }

  Future<void> getCurrentUser() async {
    try {
      isLoadingFoodRecommendation(true);
      isLoadingFoodPopular(true);

      final response = await userService.showCurrentUser();
      print("CHECK CURRENT RESPONSE");
      print(response.data);

      if (response.data != null) {
        userResponse = ShowCurrentUserResponse.fromJson(response.data);
        if (userResponse.data!.name != null) {
          dataUser = userResponse.data!.obs;
          print("User data fetched: ${userResponse.data!.name}");
        } else {
          print("User data is null");
        }
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> getAllFoodRecommendation() async {
    try {
      if (dataUser.value != null) {
        final currentUser = dataUser.value!;

        // determine goals
        String goals = '';
        if (currentUser.goals == "Menaikkan Berat Badan" || currentUser.goals == "Menaikkan Berat Badan Ekstrim") {
          goals = "Menaikkan Berat Badan";
        }
        else if (currentUser.goals == "Menurunkan Berat Badan" || currentUser.goals == "Menurunkan Berat Badan Ekstrim") {
          goals = "Menurunkan Berat Badan";
        }

        final response = await foodServices.showAllFoodByGoals(
          goals: goals,
        );

        print("CHECK FOOD RECOMMENDATION RESPONSE");
        print(response.data);

        if (response.data != null) {
          final foodData = FoodListModel.fromJson(response.data);
          foodRecommendation.value = foodData;
        } else {
          print("Response data is null");
        }
      } else {
        print("User data is not available for food recommendation");
      }
    } catch (e) {
      print('Error fetching food recommendation data: $e');
    } finally {
      isLoadingFoodRecommendation(false);
    }
  }

  Future<void> getAllFoodPopular() async {
    try {
      final response = await foodServices.showAllFoodByClickCountDesc();

      print("CHECK FOOD POPULAR RESPONSE");
      print(response.data);

      if (response.data != null) {
        final foodData = FoodListModel.fromJson(response.data);
        foodPopular.value = foodData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching food popular data: $e');
    } finally {
      isLoadingFoodPopular(false);
    }
  }
}