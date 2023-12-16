class getDataModel {
  bool? success;
  int? serverCode;
  String? message;
  DataModel? data;

  getDataModel({this.success, this.serverCode, this.message, this.data});

  getDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    serverCode = json['serverCode'];
    message = json['message'];
    data = json['data'] != null ? new DataModel.fromJson(json['data']) : null;
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

class DataModel {
  int? count;
  List<Rowsdatadata>? rows;

  DataModel({this.count, this.rows});

  DataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rowsdatadata>[];
      json['rows'].forEach((v) {
        rows!.add(new Rowsdatadata.fromJson(v));
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

class Rowsdatadata {
  String? errorElementId;
  String? formId;
  String? errorTypeId;
  String? elementId;
  String? logbook;
  String? technicalAspects;
  String? logbookImage;
  String? technicalAspectsImage;
  int? count;
  Element? element;
  ErrorType? errorType;
  Forms? forms;

  Rowsdatadata(
      {this.errorElementId,
        this.formId,
        this.errorTypeId,
        this.elementId,
        this.logbook,
        this.technicalAspects,
        this.logbookImage,
        this.technicalAspectsImage,
        this.count,
        this.element,
        this.errorType,
        this.forms});

  Rowsdatadata.fromJson(Map<String, dynamic> json) {
    errorElementId = json['ErrorElementId'];
    formId = json['FormId'];
    errorTypeId = json['ErrorTypeId'];
    elementId = json['ElementId'];
    logbook = json['Logbook'];
    technicalAspects = json['TechnicalAspects'];
    logbookImage = json['LogbookImage'];
    technicalAspectsImage = json['TechnicalAspectsImage'];
    count = json['Count'];
    element =
    json['Element'] != null ? new Element.fromJson(json['Element']) : null;
    errorType = json['ErrorType'] != null
        ? new ErrorType.fromJson(json['ErrorType'])
        : null;
    forms = json['Forms'] != null ? new Forms.fromJson(json['Forms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorElementId'] = this.errorElementId;
    data['FormId'] = this.formId;
    data['ErrorTypeId'] = this.errorTypeId;
    data['ElementId'] = this.elementId;
    data['Logbook'] = this.logbook;
    data['TechnicalAspects'] = this.technicalAspects;
    data['LogbookImage'] = this.logbookImage;
    data['TechnicalAspectsImage'] = this.technicalAspectsImage;
    data['Count'] = this.count;
    if (this.element != null) {
      data['Element'] = this.element!.toJson();
    }
    if (this.errorType != null) {
      data['ErrorType'] = this.errorType!.toJson();
    }
    if (this.forms != null) {
      data['Forms'] = this.forms!.toJson();
    }
    return data;
  }
}

class Element {
  String? id;
  String? elementLabel;
  bool? elementStatus;

  Element({this.id, this.elementLabel, this.elementStatus});

  Element.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    elementLabel = json['ElementLabel'];
    elementStatus = json['ElementStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ElementLabel'] = this.elementLabel;
    data['ElementStatus'] = this.elementStatus;
    return data;
  }
}

class ErrorType {
  String? errorTypeId;
  String? errorTypeValue;
  int? errorCategoryId;
  int? errorKindId;
  int? sortOrder;

  ErrorType(
      {this.errorTypeId,
        this.errorTypeValue,
        this.errorCategoryId,
        this.errorKindId,
        this.sortOrder});

  ErrorType.fromJson(Map<String, dynamic> json) {
    errorTypeId = json['ErrorTypeId'];
    errorTypeValue = json['ErrorTypeValue'];
    errorCategoryId = json['ErrorCategoryId'];
    errorKindId = json['ErrorKindId'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorTypeId'] = this.errorTypeId;
    data['ErrorTypeValue'] = this.errorTypeValue;
    data['ErrorCategoryId'] = this.errorCategoryId;
    data['ErrorKindId'] = this.errorKindId;
    data['SortOrder'] = this.sortOrder;
    return data;
  }
}

class Forms {
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

  Forms(
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

  Forms.fromJson(Map<String, dynamic> json) {
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