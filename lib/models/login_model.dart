class LoginModel {
  bool? status;
  String? userId;
  String? userName;
  String? password;
  String? profileImage;
  List<NewPerformerdata>? newPerformerdata;
  String? token;

  LoginModel(
      {this.status,
      this.userId,
      this.userName,
      this.password,
      this.profileImage,
      this.newPerformerdata,
      this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    userId = json['UserId'];
    userName = json['UserName'];
    password = json['Password'];
    profileImage = json['ProfileImage'];
    if (json['NewPerformerdata'] != null) {
      newPerformerdata = <NewPerformerdata>[];
      json['NewPerformerdata'].forEach((v) {
        newPerformerdata!.add(new NewPerformerdata.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['ProfileImage'] = this.profileImage;
    if (this.newPerformerdata != null) {
      data['NewPerformerdata'] =
          this.newPerformerdata!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
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
  Null? clientId;
  int? moduleId;
  String? uRLClientPortal;
  int? reportType;
  Null? image;
  bool? active;
  Null? email;
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
      this.email,
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
    email = json['Email'];
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
    data['Email'] = this.email;
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