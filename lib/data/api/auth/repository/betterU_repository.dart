import './global_variabel.dart';

class BetterUApiRepository {
  static String mainUrl = GlobalVariables.baseUrl;
  static String mainUrlAi = GlobalVariables.baseUrlAi;

  // AI & ML API
  static String postPredict = '$mainUrlAi/predict';
  static String postCalculateNutrition = '$mainUrlAi/calculate-nutrition';


  static String getCurrentUser = '$mainUrl/api/users/show-current';
  static String getCurrentTotalNutrition = '$mainUrl/api/daily-activity/show-total-nutrition';
  static String getCurrentCombo = '$mainUrl/api/daily-activity/show-current';

  static String putDailyActivity = '$mainUrl/api/daily-activity/update';

  static String deleteDailyActivity = '$mainUrl/api/daily-activity/delete';

  static String postRegister = '$mainUrl/api/users/register';
  static String postOtpCode = '$mainUrl/api/otp/store';
  static String postOtpCheck = '$mainUrl/api/otp/check';
}
