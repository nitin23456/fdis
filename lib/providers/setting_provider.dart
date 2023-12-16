import 'package:FdisTesting/models/profile_model.dart';
import 'package:FdisTesting/models/setting_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:FdisTesting/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LogoutModel.dart';

class SettingProvider with ChangeNotifier {
  final api = Api();
  SettingModel settingModel = SettingModel();
  UserProfileModel userProfileModel = UserProfileModel();
  LogoutModel userProfileModeldata = LogoutModel();
  String userName = "";
  SettingModel auditModel = SettingModel();
  //getAreaModel getareaModel = getAreaModel();

  Future<List<Rows>> fetchSettingData() async {
    List<Rows> list = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var header = {
      "x-access-token": token,
      "Authorization": "Bearer $token",
    };
    //   print("client id Rahul===$clientId");

    final response = await api.get(
        //http://3.71.4.186:4002/api/v1/dashboard/audit?ucId=
        //'http://3.71.4.186:4002/api/v1/dashboard/audit?ucId=$clientId');
        'http://18.159.111.224:4002/api/v1/dashboard/newPerformer'); //?ucId=$clientId
    final item = response.data;
    if (response.statusCode == 200) {
      auditModel = SettingModel.fromJson(item);
      list.addAll(auditModel.data?.rows ?? []);
    }
    notifyListeners();
    return list;
  }

  void getProfileData() async {
    String userId = await SharedPrefs.getUserId();
    final response = await api.get(
        //'http://34.245.60.213:4002/api/v1/dashboard/mob/userprofile/$userId');
        'http://18.159.111.224:4002/api/v1/dashboard/mob/userprofile/$userId');
    //'http://3.71.4.186:4002/api/v1/dashboard/mob/userprofile/$userId');
    final item = response.data;
    if (response.statusCode == 200) {
      userProfileModel = UserProfileModel.fromJson(item);
    }
    notifyListeners();
  }

  getLogoutApi() async {
    String userId = await SharedPrefs.getUserId();
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    var headers = {
      "x-access-token": token,
      "Authorization": "Bearer $token",
    };

    // print("client token === $token");

    try {
      final response = await api.postData(
        endpoint:
            'http://18.159.111.224:4002/api/v1/dashboard/newPerformer/logout',
        //endpoint: 'http://3.71.4.186:4002/api/v1/dashboard/Mob/logout',
        headers: headers, // Set the headers here
        body: {'x-access-token': token},
      );
      final item = response.data;
      if (response.statusCode == 200) {
        //Navigator.pop(context, true);
        userProfileModeldata = LogoutModel.fromJson(item);
        print("Logout successful ${userProfileModeldata.message}");

        await prefs.setString('token', "");
      } else {
        print("Logout failed");
      }
    } catch (error) {
      print("Error during logout: $error");
    }

    notifyListeners();
  }
}
