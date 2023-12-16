class getAreaModel {
  bool? success;
  int? serverCode;
  String? message;
  DataArea? data;

  getAreaModel({this.success, this.serverCode, this.message, this.data});

  getAreaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    serverCode = json['serverCode'];
    message = json['message'];
    data = json['data'] != null ? new DataArea.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['serverCode'] = this.serverCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataArea {
  int? count;
  List<Rowsdata>? rows;

  DataArea({this.count, this.rows});

  DataArea.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rowsdata>[];
      json['rows'].forEach((v) {
        rows!.add(new Rowsdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rowsdata {
  String? id;
  int? counterElement;
  String? date;
  String? presentClient;
  int? approvedLimits;
  String? areaCode;
  int? faults;
  String? comments;
  String? auditId;
  String? categoryId;
  String? floorId;
  Null? auditById;
  bool? uploaded;
  String? remarks;
  int? areaDescId;
  int? areaDescModuleId;
  Auditdata? auditdata;
  Categories? categories;
  Floors? floors;
  AreaDescriptions? areaDescriptions;

  Rowsdata(
      {this.id,
        this.counterElement,
        this.date,
        this.presentClient,
        this.approvedLimits,
        this.areaCode,
        this.faults,
        this.comments,
        this.auditId,
        this.categoryId,
        this.floorId,
        this.auditById,
        this.uploaded,
        this.remarks,
        this.areaDescId,
        this.areaDescModuleId,
        this.auditdata,
        this.categories,
        this.floors,
        this.areaDescriptions});

  Rowsdata.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    counterElement = json['CounterElement'];
    date = json['Date'];
    presentClient = json['PresentClient'];
    approvedLimits = json['ApprovedLimits'];
    areaCode = json['AreaCode'];
    faults = json['Faults'];
    comments = json['Comments'];
    auditId = json['AuditId'];
    categoryId = json['CategoryId'];
    floorId = json['FloorId'];
    auditById = json['AuditBy_Id'];
    uploaded = json['Uploaded'];
    remarks = json['Remarks'];
    areaDescId = json['AreaDescId'];
    areaDescModuleId = json['AreaDescModuleId'];
    auditdata = json['Auditdata'] != null
        ? new Auditdata.fromJson(json['Auditdata'])
        : null;
    categories = json['Categories'] != null
        ? new Categories.fromJson(json['Categories'])
        : null;
    floors =
    json['Floors'] != null ? new Floors.fromJson(json['Floors']) : null;
    areaDescriptions = json['AreaDescriptions'] != null
        ? new AreaDescriptions.fromJson(json['AreaDescriptions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CounterElement'] = this.counterElement;
    data['Date'] = this.date;
    data['PresentClient'] = this.presentClient;
    data['ApprovedLimits'] = this.approvedLimits;
    data['AreaCode'] = this.areaCode;
    data['Faults'] = this.faults;
    data['Comments'] = this.comments;
    data['AuditId'] = this.auditId;
    data['CategoryId'] = this.categoryId;
    data['FloorId'] = this.floorId;
    data['AuditBy_Id'] = this.auditById;
    data['Uploaded'] = this.uploaded;
    data['Remarks'] = this.remarks;
    data['AreaDescId'] = this.areaDescId;
    data['AreaDescModuleId'] = this.areaDescModuleId;
    if (this.auditdata != null) {
      data['Auditdata'] = this.auditdata!.toJson();
    }
    if (this.categories != null) {
      data['Categories'] = this.categories!.toJson();
    }
    if (this.floors != null) {
      data['Floors'] = this.floors!.toJson();
    }
    if (this.areaDescriptions != null) {
      data['AreaDescriptions'] = this.areaDescriptions!.toJson();
    }
    return data;
  }
}

class Auditdata {
  String? auditCode;
  String? date;
  bool? isActive;
  bool? isDone;
  String? id;
  String? type;
  String? nameClientId;
  String? locationClientId;
  Null? branchId;
  Null? presentClient;
  Null? attn;
  Null? week;
  String? lastControlDate;
  bool? activate;
  Null? locationManagerSignImage;

  Auditdata(
      {this.auditCode,
        this.date,
        this.isActive,
        this.isDone,
        this.id,
        this.type,
        this.nameClientId,
        this.locationClientId,
        this.branchId,
        this.presentClient,
        this.attn,
        this.week,
        this.lastControlDate,
        this.activate,
        this.locationManagerSignImage});

  Auditdata.fromJson(Map<String, dynamic> json) {
    auditCode = json['AuditCode'];
    date = json['Date'];
    isActive = json['IsActive'];
    isDone = json['IsDone'];
    id = json['Id'];
    type = json['Type'];
    nameClientId = json['NameClient_Id'];
    locationClientId = json['LocationClient_Id'];
    branchId = json['Branch_Id'];
    presentClient = json['PresentClient'];
    attn = json['Attn'];
    week = json['week'];
    lastControlDate = json['LastControlDate'];
    activate = json['Activate'];
    locationManagerSignImage = json['LocationManagerSignImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AuditCode'] = this.auditCode;
    data['Date'] = this.date;
    data['IsActive'] = this.isActive;
    data['IsDone'] = this.isDone;
    data['Id'] = this.id;
    data['Type'] = this.type;
    data['NameClient_Id'] = this.nameClientId;
    data['LocationClient_Id'] = this.locationClientId;
    data['Branch_Id'] = this.branchId;
    data['PresentClient'] = this.presentClient;
    data['Attn'] = this.attn;
    data['week'] = this.week;
    data['LastControlDate'] = this.lastControlDate;
    data['Activate'] = this.activate;
    data['LocationManagerSignImage'] = this.locationManagerSignImage;
    return data;
  }
}

class Categories {
  String? iD;
  String? categoryNameAbv;
  bool? isFixed;
  String? categoryName;
  int? sortOrder;

  Categories(
      {this.iD,
        this.categoryNameAbv,
        this.isFixed,
        this.categoryName,
        this.sortOrder});

  Categories.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    categoryNameAbv = json['CategoryNameAbv'];
    isFixed = json['IsFixed'];
    categoryName = json['CategoryName'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CategoryNameAbv'] = this.categoryNameAbv;
    data['IsFixed'] = this.isFixed;
    data['CategoryName'] = this.categoryName;
    data['SortOrder'] = this.sortOrder;
    return data;
  }
}

class Floors {
  String? id;
  String? floorName;
  String? floorNameAbv;
  int? sortOrder;

  Floors({this.id, this.floorName, this.floorNameAbv, this.sortOrder});

  Floors.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    floorName = json['FloorName'];
    floorNameAbv = json['FloorNameAbv'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FloorName'] = this.floorName;
    data['FloorNameAbv'] = this.floorNameAbv;
    data['SortOrder'] = this.sortOrder;
    return data;
  }
}

class AreaDescriptions {
  int? id;
  int? moduleId;
  String? name;
  String? abbreviation;
  bool? active;

  AreaDescriptions(
      {this.id, this.moduleId, this.name, this.abbreviation, this.active});

  AreaDescriptions.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    moduleId = json['ModuleId'];
    name = json['Name'];
    abbreviation = json['Abbreviation'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ModuleId'] = this.moduleId;
    data['Name'] = this.name;
    data['Abbreviation'] = this.abbreviation;
    data['Active'] = this.active;
    return data;
  }
}