class ErrorDeleteModel {
  String? message;
  Data? data;

  ErrorDeleteModel({this.message, this.data});

  ErrorDeleteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? errorElementId;
  String? formId;
  String? errorTypeId;
  String? performerId;
  String? elementId;
  String? logbook;
  String? technicalAspects;
  String? logbookImage;
  String? technicalAspectsImage;
  int? count;
  Null? date;

  Data(
      {this.errorElementId,
      this.formId,
      this.errorTypeId,
      this.performerId,
      this.elementId,
      this.logbook,
      this.technicalAspects,
      this.logbookImage,
      this.technicalAspectsImage,
      this.count,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    errorElementId = json['ErrorElementId'];
    formId = json['FormId'];
    errorTypeId = json['ErrorTypeId'];
    performerId = json['Performer_Id'];
    elementId = json['ElementId'];
    logbook = json['Logbook'];
    technicalAspects = json['TechnicalAspects'];
    logbookImage = json['LogbookImage'];
    technicalAspectsImage = json['TechnicalAspectsImage'];
    count = json['Count'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorElementId'] = this.errorElementId;
    data['FormId'] = this.formId;
    data['ErrorTypeId'] = this.errorTypeId;
    data['Performer_Id'] = this.performerId;
    data['ElementId'] = this.elementId;
    data['Logbook'] = this.logbook;
    data['TechnicalAspects'] = this.technicalAspects;
    data['LogbookImage'] = this.logbookImage;
    data['TechnicalAspectsImage'] = this.technicalAspectsImage;
    data['Count'] = this.count;
    data['Date'] = this.date;
    return data;
  }
}
