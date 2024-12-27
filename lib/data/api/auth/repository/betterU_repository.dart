import './global_variabel.dart';

class BetterUApiRepository {
  static String mainUrl = GlobalVariables.baseUrl;

  static String postRegister = '$mainUrl/api/users/register';
  static String postOtpCode = '$mainUrl/api/otp/store';
  static String postOtpCheck = '$mainUrl/api/otp/check';
}
