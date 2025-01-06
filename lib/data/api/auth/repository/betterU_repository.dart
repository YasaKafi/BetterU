import './global_variabel.dart';

class BetterUApiRepository {
  static String mainUrl = GlobalVariables.baseUrl;
  static String mainUrlAi = GlobalVariables.baseUrlAi;
  static String urlMetaAi = "https://api-inference.huggingface.co/models/meta-llama/Llama-3.2-11B-Vision-Instruct/v1/chat/completions";

  // AI & ML API
  static String postPredict = '$mainUrlAi/predict';
  static String postCalculateNutrition = '$mainUrlAi/calculate-nutrition';
  static String postPredictFood = '$mainUrlAi/predict';


  static String getCurrentUser = '$mainUrl/api/users/show-current';
  static String getCurrentTotalNutrition = '$mainUrl/api/daily-activity/show-total-nutrition';
  static String getCurrentCombo = '$mainUrl/api/daily-activity/show-current';
  static String getHistoryTotalNutrition = '$mainUrl/api/daily-activity/show-history-total-nutrition';

  static String putDailyActivity = '$mainUrl/api/daily-activity/update';
  static String putEditUser = '$mainUrl/api/users/update';

  static String deleteDailyActivity = '$mainUrl/api/daily-activity/delete';
  static String deleteTokenUser = '$mainUrl/api/users/logout';

  static String postImageToUrl = '$mainUrl/api/images/store';

  static String postRegister = '$mainUrl/api/users/register';
  static String postLogin = '$mainUrl/api/users/login';
  static String postOtpCode = '$mainUrl/api/otp/store';
  static String postOtpCheck = '$mainUrl/api/otp/check';
  static String postDailyActivity = '$mainUrl/api/daily-activity/store';

}
