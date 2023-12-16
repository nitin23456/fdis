class AuditListModel {
  bool? success;
  int? serverCode;
  String? message;
  Data? data;

  AuditListModel({this.success, this.serverCode, this.message, this.data});

  AuditListModel.fromJson(Map<String, dynamic> json) {
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
  String? auditCode;
  String? date;
  bool? isActive;
  bool? isDone;
  String? id;
  String? type;
  String? nameClientId;
  String? locationClientId;
  String? branchId;
  String? presentClient;
  String? attn;
  String? week;
  String? lastControlDate;
  bool? activate;
  String? locationManagerSignImage;
  List<NewPerformers>? newPerformers;
  UsersClient? usersClient;
  Location? location;
  String? newPerformer;

  Rows(
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
      this.newPerformers,
      this.usersClient,
      this.location,
      this.newPerformer});

  Rows.fromJson(Map<String, dynamic> json) {
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
    if (json['NewPerformers'] != null) {
      newPerformers = <NewPerformers>[];
      json['NewPerformers'].forEach((v) {
        newPerformers!.add(new NewPerformers.fromJson(v));
      });
    }
    usersClient = json['Users_Client'] != null
        ? new UsersClient.fromJson(json['Users_Client'])
        : null;
    location = json['Location'] != null
        ? new Location.fromJson(json['Location'])
        : null;
    newPerformer = json['NewPerformer'];
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
    if (this.newPerformers != null) {
      data['NewPerformers'] =
          this.newPerformers!.map((v) => v.toJson()).toList();
    }
    if (this.usersClient != null) {
      data['Users_Client'] = this.usersClient!.toJson();
    }
    if (this.location != null) {
      data['Location'] = this.location!.toJson();
    }
    data['NewPerformer'] = this.newPerformer;
    return data;
  }
}

class NewPerformers {
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
  AuditPerformer? auditPerformer;

  NewPerformers(
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
      this.auditPerformer});

  NewPerformers.fromJson(Map<String, dynamic> json) {
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
    auditPerformer = json['Audit_Performer'] != null
        ? new AuditPerformer.fromJson(json['Audit_Performer'])
        : null;
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
    if (this.auditPerformer != null) {
      data['Audit_Performer'] = this.auditPerformer!.toJson();
    }
    return data;
  }
}

class AuditPerformer {
  bool? auditPerformerStatus;
  String? idAudit;
  String? idPerformer;

  AuditPerformer({this.auditPerformerStatus, this.idAudit, this.idPerformer});

  AuditPerformer.fromJson(Map<String, dynamic> json) {
    auditPerformerStatus = json['Audit_PerformerStatus'];
    idAudit = json['IdAudit'];
    idPerformer = json['IdPerformer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Audit_PerformerStatus'] = this.auditPerformerStatus;
    data['IdAudit'] = this.idAudit;
    data['IdPerformer'] = this.idPerformer;
    return data;
  }
}

class UsersClient {
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
  Country? country;
  Branch? branch;
  User? user;

  UsersClient(
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
      this.country,
      this.branch,
      this.user});

  UsersClient.fromJson(Map<String, dynamic> json) {
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
    country =
        json['Country'] != null ? new Country.fromJson(json['Country']) : null;
    branch =
        json['Branch'] != null ? new Branch.fromJson(json['Branch']) : null;
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
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
    if (this.country != null) {
      data['Country'] = this.country!.toJson();
    }
    if (this.branch != null) {
      data['Branch'] = this.branch!.toJson();
    }
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    return data;
  }
}

class Country {
  String? id;
  String? countryName;
  String? countryCode;

  Country({this.id, this.countryName, this.countryCode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    countryName = json['CountryName'];
    countryCode = json['CountryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CountryName'] = this.countryName;
    data['CountryCode'] = this.countryCode;
    return data;
  }
}

class Branch {
  String? id;
  String? branchName;

  Branch({this.id, this.branchName});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    branchName = json['BranchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['BranchName'] = this.branchName;
    return data;
  }
}

class User {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? profileImage;

  User(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userName = json['UserName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    profileImage = json['ProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserName'] = this.userName;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['ProfileImage'] = this.profileImage;
    return data;
  }
}

class Location {
  String? id;
  String? name;
  int? size;
  String? clientId;
  String? region;
  String? city;
  String? address;
  String? contactPerson;
  bool? activate;
  String? email;

  Location(
      {this.id,
      this.name,
      this.size,
      this.clientId,
      this.region,
      this.city,
      this.address,
      this.contactPerson,
      this.activate,
      this.email});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    size = json['Size'];
    clientId = json['ClientId'];
    region = json['Region'];
    city = json['City'];
    address = json['Address'];
    contactPerson = json['ContactPerson'];
    activate = json['Activate'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Size'] = this.size;
    data['ClientId'] = this.clientId;
    data['Region'] = this.region;
    data['City'] = this.city;
    data['Address'] = this.address;
    data['ContactPerson'] = this.contactPerson;
    data['Activate'] = this.activate;
    data['Email'] = this.email;
    return data;
  }
}
