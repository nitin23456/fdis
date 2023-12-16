class SignatureUploadModel {
  String? auditCode;
  String? date;
  bool? isActive;
  bool? isDone;
  String? id;
  String? type;
  String? nameClientId;
  String? locationClientId;
  Null? branchId;
  String? presentClient;
  Null? attn;
  Null? week;
  String? lastControlDate;
  bool? activate;
  Null? locationManagerSignImage;
  Null? auditHash;

  SignatureUploadModel(
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
      this.locationManagerSignImage,
      this.auditHash});

  SignatureUploadModel.fromJson(Map<String, dynamic> json) {
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
    auditHash = json['AuditHash'];
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
    data['AuditHash'] = this.auditHash;
    return data;
  }
}
