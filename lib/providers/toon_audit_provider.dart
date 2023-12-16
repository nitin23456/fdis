import 'dart:async';
import 'dart:developer';

import 'package:FdisTesting/models/GetFeedbackModel.dart';
import 'package:FdisTesting/models/feedback_model.dart';
import 'package:FdisTesting/models/toon_audit_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

class ToonAuditProvider with ChangeNotifier {
  final api = Api();
  ToonAuditModel toonAuditModel = ToonAuditModel();
  GetFeedbackModel getFeedbackModel = GetFeedbackModel();
  String dropdownValue = 'KPI Element you can choose the value';
  CustomDropdown? selectedDropdownValue;
  FeedbackModel feedbackModel = FeedbackModel();
  bool isLoading = false;
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.blue,
    exportBackgroundColor: Colors.blue,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  List<CustomDropdown> dropdown = [
    CustomDropdown(name: "V", id: "9ED2B54C-9918-4543-8A3B-65A68EDBFC99"),
    CustomDropdown(name: "O", id: "F690CEEB-0657-43C2-8F5B-5EA957B65840"),
    CustomDropdown(name: "N", id: "6F1978C1-A7CB-48FB-BEBF-BE860A03E6E2"),
    CustomDropdown(name: "G", id: "798288A4-F08D-40A5-8BAE-C19518E20431")
  ];

  Future<List<CategoryList>> fetchToonAuditList(
      String auditid, String clientid) async {
    print("auditid======    ${auditid}");
    print("auditid======clientid  ${clientid}");
    List<CategoryList> list = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var header = {
      "x-access-token": token,
      "Authorization": "Bearer $token",
    };

    final response = await api.get(
        //'http://34.245.60.213:4002/api/v1/dashboard/Mob/companyDetail?AuditId=$auditid&clientId=$clientid');
        'http://18.159.111.224:4002/api/v1/dashboard/Mob/companyDetail?AuditId=$auditid&clientId=$clientid');
    final item = response.data;
    if (response.statusCode == 200) {
      toonAuditModel = ToonAuditModel.fromJson(item);
      list.addAll(toonAuditModel.data ?? []);
    }
    notifyListeners();
    return list;
  }

  Future<List<GetFeed>> getFeebackModel() async {
    List<GetFeed> list = [];
    final response = await api
        .get('http://18.159.111.224:4002/api/v1/dashboard/Mob/getfeedback');
    final item = response.data;
    if (response.statusCode == 200) {
      getFeedbackModel = GetFeedbackModel.fromJson(item);
      list.addAll(getFeedbackModel.data ?? []);
      print("Ram===== ${getFeedbackModel.data}");
    }
    notifyListeners();
    return list;
  }

  void changeDropdownValue(String newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<FeedbackModel> feedbackAPI(
      {required String feedback, required String auditId}) async {
    setLoading(true);
    print(auditId);
    print("auditId");
    try {
      final response = await api.post(
        endpoint: 'http://18.159.111.224:4002/api/v1/dashboard/Module/feedback',
        // endpoint: 'http://34.245.60.213:4002/api/v1/dashboard/Module/feedback',
        body: {
          "IdElement": "5D015C02-FC5D-4CEB-9A9E-2C0AFADBCABD",
          "IdAudit": auditId,
          "ElementAuditComment": feedback,
          "ElementAuditStatus": "F690CEEB-0657-43C2-8F5B-5EA957B65840"
        },
      );
      final item = response.data;
      if (response.statusCode == 200) {
        print('object fedd bacek ');
        feedbackModel = FeedbackModel.fromJson(item);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        notifyListeners();
      }
    } catch (error) {
      setLoading(false);
      debugPrint(error.toString());
      notifyListeners();
    }
    return feedbackModel;
  }
}

class CustomDropdown {
  String name;
  String id;

  CustomDropdown({required this.name, required this.id});
}
