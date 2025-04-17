import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper{
  static late SharedPreferences sharedPreferences;

  static init () async {
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static Future<bool> putData({required String key, required dynamic value,}) async{
    if(value is String){
      return await sharedPreferences.setString(
          key, value,
      );
    }
    else if(value is int){
      return await sharedPreferences.setInt(key, value);
    }
    else if(value is double){
      return await sharedPreferences.setDouble(key, value);
    }
    else if(value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    }
    else {
      return await sharedPreferences.setBool(key, value);
    }
  }

  static dynamic getData({required String key,}) {

      return sharedPreferences.get(key);

  }

  static Future<bool> removeData(String key) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    return await sharedPreferences.remove(key);
  }
}