import 'package:FdisTesting/models/last_page_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:FdisTesting/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState {
  initial,
  loading,
  success,
  error,
}

class ErrorPageProvider with ChangeNotifier {
  LoginState _loginState = LoginState.initial;
  String loginErrorMessage = "";
  final api = Api();
  LastPageModel lastPageModel = LastPageModel();
  // PostAreaModel postAreaModel = PostAreaModel();
  // LastPageModel lastPageModel = LastPageModel();
//import karo
  LoginState get loginState => _loginState;

  String get errorMessage => loginErrorMessage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void setLoginState(LoginState state) {
    _loginState = state;
    notifyListeners();
  }

  String userId = '';

  getUserId() async {
    userId = await SharedPrefs.getUserId();
    print("UserId ============${userId}");
  }

  getFormId() async {
    var formId = await SharedPrefs.getFormId();
    print(
        "formId=====================================================${formId}");
  }

//update record function
  Future<bool> updateRecodeApi({
    // required String errorElementId,
    required String formId,
    required String errorTypeId,
    required String performerId,
    required String elementId,
    required String logbook,
    required String technicalAspects,
    required String logbookImage,
    required String technicalAspectsImage,
    required String Count,
    // required String date,
  }) async {
    setLoginState(LoginState.loading);
    setLoading(true);
    try {
      await getUserId();
      await getFormId();
      print(
          "formId === ${formId}"); ////////////////formid connect get in audit formation ////
      print("errorTypeId === ${errorTypeId}");
      print(
          "formId=====================================================${formId}");
      print("count ==== ${Count}");
      print("performerId === ${userId}");
      print("elementId === ${elementId}");
      print("logbook === ${logbook}");
      print("technicalAspects === ${technicalAspects}");
      print("logbookImage === ${logbookImage}");
      print("technicalAspectsImage === ${technicalAspectsImage}");

      var _formData = FormData.fromMap({
        "FormId": "E17080D1-42F4-41D0-8013-FFD722C4ED7F",
        "ErrorTypeId": errorTypeId,
        "ElementId": elementId,
        "Performer_Id": userId,
        "Logbook": logbook,
        "TechnicalAspects": technicalAspects,
        "LogbookImages": await MultipartFile.fromFile(logbookImage,
            contentType: MediaType(
                'image', logbookImage.split('/').last.split('.').last)),
        "TechnicalAspectsImages": await MultipartFile.fromFile(
            technicalAspectsImage,
            contentType: MediaType('image',
                technicalAspectsImage.split('/').last.split('.').last)),
        "Count": Count
      });
      final response = await api.postDataWithFile(
          'http://18.159.111.224:4002/api/v1/dashboard/Mob/update/',
          data: _formData,
          isUpdate: true);
      final item = response.data;
      if (response.statusCode == 200) {
        lastPageModel = LastPageModel.fromJson(item);

        print("success");
        SharedPrefs.saveIsLoggedIn(true);
        _loginState = LoginState.success;
        setLoading(false);
        notifyListeners();

        return true;
      } else {
        loginErrorMessage = 'Area failed';
        setLoading(false);
        _loginState = LoginState.error;
        notifyListeners();

        return false;
      }
    } catch (error) {
      loginErrorMessage = error.toString();
      setLoading(false);
      _loginState = LoginState.error;
      debugPrint(error.toString());
      notifyListeners();
      return false;
    }
  }

  Future<bool> pagelastapiProvider({
    // required String errorElementId,
    required String formId,
    required String errorTypeId,
    required String performerId,
    required String elementId,
    required String logbook,
    required String technicalAspects,
    required String logbookImage,
    required String technicalAspectsImage,
    required String Count,
    // required String date,
    required void Function(LoginState state) onLoginStateChanged,
  }) async {
    setLoginState(LoginState.loading);
    setLoading(true);
    try {
      await getUserId();
      await getFormId();
      print(
          "formId === ${formId}"); ////////////////formid connect get in audit formation ////
      print("errorTypeId === ${errorTypeId}");
      print(
          "formId=====================================================${formId}");
      print("count ==== ${Count}");
      print("performerId === ${userId}");
      print("elementId === ${elementId}");
      print("logbook === ${logbook}");
      print("technicalAspects === ${technicalAspects}");
      print("logbookImage === ${logbookImage}");
      print("technicalAspectsImage === ${technicalAspectsImage}");

      var _formData = FormData.fromMap({
        "FormId": "E17080D1-42F4-41D0-8013-FFD722C4ED7F",
        "ErrorTypeId": errorTypeId,
        "ElementId": elementId,
        "Performer_Id": userId,
        "Logbook": logbook,
        "TechnicalAspects": technicalAspects,
        "LogbookImages": await MultipartFile.fromFile(logbookImage,
            contentType: MediaType(
                'image', logbookImage.split('/').last.split('.').last)),
        "TechnicalAspectsImages": await MultipartFile.fromFile(
            technicalAspectsImage,
            contentType: MediaType('image',
                technicalAspectsImage.split('/').last.split('.').last)),
        "Count": Count
      });
      final response = await api.postDataWithFile(
          'http://18.159.111.224:4002/api/v1/dashboard/Mob/upload',
          data: _formData,
          isUpdate: false);
      final item = response.data;
      if (response.statusCode == 200) {
        lastPageModel = LastPageModel.fromJson(item);

        print("success");
        SharedPrefs.saveIsLoggedIn(true);
        _loginState = LoginState.success;
        setLoading(false);
        notifyListeners();
        if (onLoginStateChanged != null) {
          onLoginStateChanged(LoginState.success);
        }

        return true;
      } else {
        loginErrorMessage = 'Area failed';
        setLoading(false);
        _loginState = LoginState.error;
        notifyListeners();

        if (onLoginStateChanged != null) {
          onLoginStateChanged(LoginState.error);
        }

        return false;
      }
    } catch (error) {
      loginErrorMessage = error.toString();
      setLoading(false);
      _loginState = LoginState.error;
      debugPrint(error.toString());
      notifyListeners();
      if (onLoginStateChanged != null) {
        onLoginStateChanged(LoginState.error);
      }
      return false;
    }
  }
}
