import 'package:better_u/data/api/auth/model/current_user_model.dart';
import 'package:better_u/data/api/auth/model/food_model.dart';
import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/food_service.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {

  RxBool isLoadingRecommendationFood = false.obs;
  late AuthServices userService;
  late FoodServices foodServices;
  late ShowCurrentUserResponse userResponse;
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  Rx<Food> foodRecommendation = Rx<Food>(Food());

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi initialize() yang menampung inisialisasi
    initialize();
  }

  // Fungsi inisialisasi untuk fetch data dan proses lainnya
  Future<void> initialize() async {
    userService = AuthServices();
    foodServices = FoodServices();

    // Memanggil getCurrentUser untuk mendapatkan data user
    await getCurrentUser();

    // Jika sudah mendapatkan data user, maka lakukan perhitungan dan ambil data terkait
    if (dataUser.value != null) {
      await getAllFoodByGoals();

    }
  }

  // Fetch current user and trigger postCalculateNutrition after 1 second
  Future<void> getCurrentUser() async {
    try {
      isLoadingRecommendationFood(true);
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

  Future<void> getAllFoodByGoals() async {
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

        print("CHECK FOOD RESPONSE");
        print(response.data);

        if (response.data != null) {
          final foodData = Food.fromJson(response.data);
          foodRecommendation.value = foodData;
        } else {
          print("Response data is null");
        }
      } else {
        print("User data is not available for food recommendation");
      }
    } catch (e) {
      print('Error fetching food data: $e');
    } finally {
      isLoadingRecommendationFood(false);
    }
  }

}