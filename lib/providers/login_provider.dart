import 'dart:async';

import 'package:FdisTesting/models/last_page_model.dart';
import 'package:FdisTesting/models/login_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:FdisTesting/utils/shared_prefs.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_areamodel.dart';

enum LoginState {
  initial,
  loading,
  success,
  error,
}

class LoginProvider with ChangeNotifier {
  LoginState _loginState = LoginState.initial;
  String loginErrorMessage = "";
  final api = Api();
  LoginModel loginModel = LoginModel();
  PostAreaModel postAreaModel = PostAreaModel();
  LastPageModel lastPageModel = LastPageModel();
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

  Future<bool> login({
    required String username,
    required String password,
    required String userId,
    required void Function(LoginState state) onLoginStateChanged,
  }) async {
    setLoginState(LoginState.loading);
    setLoading(true);
    try {
      final response = await api.post(
        endpoint:
            'http://18.159.111.224:4002/api/v1/dashboard/newPerformer/login',
        body: {
          'UserName': username.trim(),
          'Password': password.trim(),
          'UserId': userId,
        },
      );
      final item = response.data;
      // print(item);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(item);
        SharedPrefs.saveToken(loginModel.token ?? "");
        SharedPrefs.saveUserName(loginModel.userName ?? "");
        SharedPrefs.saveUserId(loginModel.userId ?? "");
        SharedPrefs.saveUserImage(loginModel.profileImage ?? "");

        //ho gaya ab sab ha me run karke dekhata hu error ho gyi solve
        SharedPrefs.saveIsLoggedIn(true);
        _loginState = LoginState.success;
        setLoading(false);
        notifyListeners();
// Sir mene login ka model change kiya tab ye
        if (onLoginStateChanged != null) {
          onLoginStateChanged(LoginState.success);
        }

        return true;
      } else {
        loginErrorMessage = 'Login failed';
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

  Future<bool> areapostapi({
    required String id,
    required String counterElement,
    required String date,
    required String presentclient,
    required String approvlimit,
    required String areacodes,
    required String faults,
    required String comments,
    required String auditid,
    required String categoryid,
    required String floorid,
    required String auditby_id,
    // required String Uploaded,
    required String remark,
    required String areadescription,
    required String areaDescModuleId,
    required void Function(LoginState state) onLoginStateChanged,
  }) async {
    setLoginState(LoginState.loading);
    setLoading(true);
    try {
      //  print("floorid === ${floorid}");
      // print("auditby_id === ${auditby_id}");
      // print("id === ${id}");
      // // print("counterElement === ${counterElement}");
      // // print("date === ${date}");
      // print("presentclient === ${presentclient}");
      // // print("approvlimit === ${approvlimit}");
      // print("areacodes === ${areacodes}");
      // print("faults === ${faults}");
      // print("comments === ${comments}");
      // print("auditid === ${auditid}");
      // print("categoryid === ${categoryid}");
      // print("floorid === ${floorid}");
      // print("auditby_id === ${auditby_id}");
      // // print("Uploaded === ${Uploaded}");
      // print("remark === ${remark}");
      // print("areadescription === ${areadescription}");
      // print("areaDescModuleId === ${areaDescModuleId}");
      final response = await api.post(
        endpoint: 'http://18.159.111.224:4002/api/v1/dashboard/area',
        body: {
          "Id": "${id}",
          "PresentClient": auditby_id,
          "AreaCode": areacodes,
          "Faults": faults,
          "AuditId": "${auditid}",
          "CategoryId": "${categoryid}",
          "FloorId": "${floorid}",
          "AuditBy_Id": null,
          "Uploaded": true,
          "Remarks": "${remark}",
          "AreaDescId": "${areadescription}",
          "AreaDescModuleId": areaDescModuleId,
        },
      );
      final item = response.data;
      // print("formId=====================================================${item.Id}");
      print(
          "formId=====================================================${item['data']['Id']}");
      print("id =====================================${item}");
      if (response.statusCode == 200) {
        postAreaModel = PostAreaModel.fromJson(item);
        /* SharedPrefs.saveToken(postAreaModel.token ?? "");
        SharedPrefs.saveUserId(postAreaModel.userName ?? "");
        SharedPrefs.saveUserImage(postAreaModel.profileImage ?? "");*/
        // print("success ho gay he");
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
