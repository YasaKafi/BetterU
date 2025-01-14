import 'package:flutter_dotenv/flutter_dotenv.dart';

class GlobalVariables {
  static final baseUrl = dotenv.env['BASE_URL'] ?? 'default_value';
  static final baseUrlAi = dotenv.env['BASE_URL_ML'] ?? 'default_value';

}