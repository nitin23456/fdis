import 'dart:async';

import 'package:FdisTesting/models/audit_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuditProvider with ChangeNotifier {
  final api = Api();
  AuditListModel auditModel = AuditListModel();

  Future<List<Rows>> fetchAuditList(String clientId) async {
    List<Rows> list = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var header = {
      "x-access-token": token,
      "Authorization": "Bearer $token",
    };
    // print("client id Rahul===$clientId");

    final response = await api.get(
        //http://3.71.4.186:4002/api/v1/dashboard/audit?ucId=
        //'http://3.71.4.186:4002/api/v1/dashboard/audit?ucId=$clientId');
        'http://18.159.111.224:4002/api/v1/dashboard/audit/AuditSearch'); //?ucId=$clientId
    final item = response.data;
    if (response.statusCode == 200) {
      auditModel = AuditListModel.fromJson(item);
      list.addAll(auditModel.data?.rows ?? []);
    }
    notifyListeners();
    return list;
  }
}
