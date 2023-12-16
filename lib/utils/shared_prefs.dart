import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _tokenKey = "token";
  static const String _userName = "userName";
  static const String _userId = "userId";
  static const String _userImage = "userImage";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _isElement = "_isElement";
  static const String _isListShoort = "_isListShoort";
  static const String _isAAntal = "_isAAntal";
  static const String _isLogboek = "_isLogboek";
  static const String _isTechnische = "_isTechnische";

  static Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? "";
  }

  static Future<bool> saveUserName(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userName, username);
  }

  static Future<bool> saveIsLoggedIn(bool loggedInStatus) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_isLoggedIn, loggedInStatus);
  }

  static Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedIn) ?? false;
  }

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userName) ?? "";
  }

  static Future<bool> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userId, userId);
  }

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userId) ?? "";
  }

  static Future<bool> saveUserImage(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userImage, userId);
  }

  static Future<String> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userImage) ?? "";
  }

  static Future<bool> saveElement(String element) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_isElement, element);
  }

  static Future<String> getElement() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_isElement) ?? "";
  }

  static Future<bool> saveListShoort(String listshoort) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_isListShoort, listshoort);
  }

  static Future<String> getListShoort() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_isListShoort) ?? "";
  }

  static Future<bool> saveIsAnntal(String isantal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_isAAntal, isantal);
  }

  static Future<String> getIsAnntal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_isAAntal) ?? "";
  }

  static Future<bool> saveIsLogBoek(String isLogboek) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_isLogboek, isLogboek);
  }

  static Future<String> getIsLogBoek() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_isLogboek) ?? "";
  }

  static Future<bool> saveIsTechnische(String isTechnische) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_isTechnische, isTechnische);
  }

  static Future<String> getIsTechnische() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_isTechnische) ?? "";
  }

  static getauditId() {}

  static getFormId() {}
}
