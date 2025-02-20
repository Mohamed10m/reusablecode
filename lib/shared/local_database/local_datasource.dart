import 'package:shared_preferences/shared_preferences.dart';
class AppPreferences {
  static late SharedPreferences cacheHelper;

  static init() async {
    cacheHelper = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(String key, value) async {
    if (value is bool) {
      return await cacheHelper.setBool(key, value);
    }
    if (value is String) {
      return await cacheHelper.setString(key, value);
    }
    if (value is int) {
      return await cacheHelper.setInt(key, value);
    }
    return null;
  }

  static  getData(String? key) {
    return  cacheHelper.get(key!);
  }


  static Future<bool> removeData(String? key) {
    return cacheHelper.remove(key!);
  }
}