import 'package:easy_localization/easy_localization.dart' as easy;

class LocalizationService {
  LocalizationService._();

  static String tr(String key) {
    return easy.tr(key);
  }
}