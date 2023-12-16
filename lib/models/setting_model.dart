class SettingModel {
  bool? success;
  int? serverCode;
  String? message;
  Data? data;

  SettingModel({this.success, this.serverCode, this.message, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
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
  int? count;
  List<Rows>? rows;

  Data({this.count, this.rows});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
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

class Rows {
  String? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? loweredEmail;
  String? mobile;
  String? phone;
  bool? isAnonymous;
  bool? isApproved;
  bool? isLockedOut;
  int? count;
  int? ordinal;
  int? reportType;
  String? password;
  String? passwordSalt;
  String? createDate;
  String? companyName;
  String? clientId;
  String? applicationId;
  String? adminId;
  String? profileImage;
  String? performerTypesId;
  List<NewPerformerdata>? newPerformerdata;

  Rows(
      {this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.loweredEmail,
      this.mobile,
      this.phone,
      this.isAnonymous,
      this.isApproved,
      this.isLockedOut,
      this.count,
      this.ordinal,
      this.reportType,
      this.password,
      this.passwordSalt,
      this.createDate,
      this.companyName,
      this.clientId,
      this.applicationId,
      this.adminId,
      this.profileImage,
      this.performerTypesId,
      this.newPerformerdata});

  Rows.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    userName = json['UserName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    loweredEmail = json['LoweredEmail'];
    mobile = json['Mobile'];
    phone = json['Phone'];
    isAnonymous = json['IsAnonymous'];
    isApproved = json['IsApproved'];
    isLockedOut = json['IsLockedOut'];
    count = json['Count'];
    ordinal = json['Ordinal'];
    reportType = json['ReportType'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    createDate = json['CreateDate'];
    companyName = json['CompanyName'];
    clientId = json['ClientId'];
    applicationId = json['ApplicationId'];
    adminId = json['AdminId'];
    profileImage = json['ProfileImage'];
    performerTypesId = json['PerformerTypes_Id'];
    if (json['NewPerformerdata'] != null) {
      newPerformerdata = <NewPerformerdata>[];
      json['NewPerformerdata'].forEach((v) {
        newPerformerdata!.add(new NewPerformerdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['LoweredEmail'] = this.loweredEmail;
    data['Mobile'] = this.mobile;
    data['Phone'] = this.phone;
    data['IsAnonymous'] = this.isAnonymous;
    data['IsApproved'] = this.isApproved;
    data['IsLockedOut'] = this.isLockedOut;
    data['Count'] = this.count;
    data['Ordinal'] = this.ordinal;
    data['ReportType'] = this.reportType;
    data['Password'] = this.password;
    data['PasswordSalt'] = this.passwordSalt;
    data['CreateDate'] = this.createDate;
    data['CompanyName'] = this.companyName;
    data['ClientId'] = this.clientId;
    data['ApplicationId'] = this.applicationId;
    data['AdminId'] = this.adminId;
    data['ProfileImage'] = this.profileImage;
    data['PerformerTypes_Id'] = this.performerTypesId;
    if (this.newPerformerdata != null) {
      data['NewPerformerdata'] =
          this.newPerformerdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewPerformerdata {
  String? id;
  String? companyName;
  String? contactPerson;
  String? phone;
  String? mobile;
  String? fax;
  String? streetName;
  String? zipCode;
  String? city;
  String? password;
  String? state;
  String? countryId;
  String? branchId;
  String? userId;
  String? clientId;
  int? moduleId;
  String? uRLClientPortal;
  int? reportType;
  String? image;
  bool? active;
  PerformerClientLink? performerClientLink;

  NewPerformerdata(
      {this.id,
      this.companyName,
      this.contactPerson,
      this.phone,
      this.mobile,
      this.fax,
      this.streetName,
      this.zipCode,
      this.city,
      this.password,
      this.state,
      this.countryId,
      this.branchId,
      this.userId,
      this.clientId,
      this.moduleId,
      this.uRLClientPortal,
      this.reportType,
      this.image,
      this.active,
      this.performerClientLink});

  NewPerformerdata.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    companyName = json['CompanyName'];
    contactPerson = json['ContactPerson'];
    phone = json['Phone'];
    mobile = json['Mobile'];
    fax = json['Fax'];
    streetName = json['StreetName'];
    zipCode = json['ZipCode'];
    city = json['City'];
    password = json['Password'];
    state = json['State'];
    countryId = json['CountryId'];
    branchId = json['Branch_Id'];
    userId = json['User_Id'];
    clientId = json['ClientId'];
    moduleId = json['Module_Id'];
    uRLClientPortal = json['URLClientPortal'];
    reportType = json['ReportType'];
    image = json['image'];
    active = json['Active'];
    performerClientLink = json['PerformerClientLink'] != null
        ? new PerformerClientLink.fromJson(json['PerformerClientLink'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CompanyName'] = this.companyName;
    data['ContactPerson'] = this.contactPerson;
    data['Phone'] = this.phone;
    data['Mobile'] = this.mobile;
    data['Fax'] = this.fax;
    data['StreetName'] = this.streetName;
    data['ZipCode'] = this.zipCode;
    data['City'] = this.city;
    data['Password'] = this.password;
    data['State'] = this.state;
    data['CountryId'] = this.countryId;
    data['Branch_Id'] = this.branchId;
    data['User_Id'] = this.userId;
    data['ClientId'] = this.clientId;
    data['Module_Id'] = this.moduleId;
    data['URLClientPortal'] = this.uRLClientPortal;
    data['ReportType'] = this.reportType;
    data['image'] = this.image;
    data['Active'] = this.active;
    if (this.performerClientLink != null) {
      data['PerformerClientLink'] = this.performerClientLink!.toJson();
    }
    return data;
  }
}

class PerformerClientLink {
  bool? performerClientStatus;
  String? idPerformer;
  String? idPerformerClient;

  PerformerClientLink(
      {this.performerClientStatus, this.idPerformer, this.idPerformerClient});

  PerformerClientLink.fromJson(Map<String, dynamic> json) {
    performerClientStatus = json['PerformerClientStatus'];
    idPerformer = json['IdPerformer'];
    idPerformerClient = json['IdPerformerClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PerformerClientStatus'] = this.performerClientStatus;
    data['IdPerformer'] = this.idPerformer;
    data['IdPerformerClient'] = this.idPerformerClient;
    return data;
  }
}
