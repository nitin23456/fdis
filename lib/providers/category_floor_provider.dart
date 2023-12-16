import 'dart:async';
import 'dart:math';

import 'package:FdisTesting/database_helper/database_helper.dart';
import 'package:FdisTesting/models/area_by_category_model.dart';
import 'package:FdisTesting/models/category_by_id_model.dart';
import 'package:FdisTesting/models/floor_model.dart';
import 'package:FdisTesting/models/store_data_model.dart';
import 'package:FdisTesting/utils/api.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/getArea_Model.dart';
import '../models/get_Data_Model.dart';

class CategoryFloorProvider with ChangeNotifier {
  final api = Api();
  CategoryByAreaIdModel categoryByAreaIdModel = CategoryByAreaIdModel();
  AreaByCategoryModel areaByCategoryModel = AreaByCategoryModel();
  FloorModel floorModel = FloorModel();

  getAreaModel getareaModel = getAreaModel();
  getDataModel getdatamodel = getDataModel();

  List<AreaData> areaDataList = [];
  String dropdownValue = 'KPI Element you can choose the value';
  bool isLoading = false;
  CategoryData? selectedCategoryValue;
  FloorData? selectedFloorValue;
  Rowsdata? selectedareaValue;
  AreaData? selectedAreaData;
  TextEditingController mistakesController = TextEditingController();
  static const String columnCategoryId = 'category_id';
  static const String columnFloor = 'floor';
  static const String columnAuditId = 'audit_id';
  static const String columnArea = 'area';
  List<EntryData> entries = [];
  DBHelper dbHelper = DBHelper();
  List<EntryData> dataList = [];

  Future<List<CategoryData>> getCategoryById() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var header = {
      "x-access-token": token,
      "Authorization": "Bearer $token",
    };
    //http://3.71.4.186:4002/api/v1/dashboard/Mob/categorybyID/D144E397-020A-4C40-9C00-0241F67A8277
    final response = await api.get(
        'http://18.159.111.224:4002/api/v1/dashboard/Mob/categorybyID/D144E397-020A-4C40-9C00-0241F67A8277');
    // 'api/v1/dashboard/Mob/categorybyID/81296AEE-4D87-454B-9C31-074851C628E0');
    final item = response.data;
    List<CategoryData> list = [];
    if (response.statusCode == 200) {
      categoryByAreaIdModel = CategoryByAreaIdModel.fromJson(item);
      list.addAll(categoryByAreaIdModel.data ?? []);
    }
    notifyListeners();
    return list;
  }

  Future<List<FloorData>> getFloorList() async {
    final response = await api.get('api/v1/dashboard/floor');
    final item = response.data;
    List<FloorData> list = [];
    if (response.statusCode == 200) {
      floorModel = FloorModel.fromJson(item);
      list.addAll(floorModel.data?.rows ?? []);
    }
    notifyListeners();
    return list;
  }

  Future<List<Rowsdata>> getArea() async {
    final response = await api.get('api/v1/dashboard/area');
    final item = response.data;
    List<Rowsdata> list = [];
    if (response.statusCode == 200) {
      getareaModel = getAreaModel.fromJson(item);
      list.addAll(getareaModel.data?.rows ?? []);
    }
    notifyListeners();
    return list;
  }

  Future<List<Rowsdatadata>> getData() async {
    final response = await api.get('api/v1/dashboard/Mob/getdata');
    final item = response.data;
    List<Rowsdatadata> list = [];
    if (response.statusCode == 200) {
      getdatamodel = getDataModel.fromJson(item);
      list.addAll(getdatamodel.data?.rows ?? []);
    }
    notifyListeners();
    return list;
  }

  void getFloorByCategoryId({required String categoryId}) async {
    areaDataList.clear();
    selectedAreaData = null;
    final response =
        await api.get('api/v1/dashboard/mob/AreaDescId/$categoryId');
    final item = response.data;
    if (response.statusCode == 200) {
      areaByCategoryModel = AreaByCategoryModel.fromJson(item);
      areaDataList.addAll(areaByCategoryModel.data ?? []);
    }
    notifyListeners();
  }

  void changeDropdownValue(String newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateErrorValue(value) {
    final pageCounts = value.map((book) => int.tryParse(book.aantal)).toList();
    int totalPageCount = pageCounts.reduce((a, b) => a + b);
    // int allErrorCount = value.fold(
    //     0, (previousValue, data) => previousValue + int.tryParse(data.errorCount));
    mistakesController.text = totalPageCount.toString();
    dataList = value;
    notifyListeners();
  }

  String generateRandomString() {
    const chars =
        'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        16, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void saveAuditData() {
    dbHelper.insertEntry(dataList);
  }

  Future<void> getLocalData(
      {required String categoryId,
      required String floorId,
      required String areaId,
      required String areaNumber}) async {
    dataList = await dbHelper.getEntries(
        getCategoryId: categoryId,
        getFloorId: floorId,
        getAreaId: areaId,
        getAreaNumber: areaNumber);
    notifyListeners();
  }
}
