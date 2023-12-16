class PostAreaModel {
  bool? success;
  int? serverCode;
  String? message;
  Data? data;

  PostAreaModel({this.success, this.serverCode, this.message, this.data});

  PostAreaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    serverCode = json['serverCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
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

  Data(
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
        this.areaDescModuleId});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}