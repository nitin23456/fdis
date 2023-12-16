class ClientModel {
  bool? success;
  int? serverCode;
  String? message;
  List<Data>? data;

  ClientModel({this.success, this.serverCode, this.message, this.data});

  ClientModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    serverCode = json['serverCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['serverCode'] = this.serverCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? clientId;
  String? companyName;
  String? city;

  Data({this.clientId, this.companyName, this.city});

  Data.fromJson(Map<String, dynamic> json) {
    clientId = json['ClientId'];
    companyName = json['CompanyName'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientId'] = this.clientId;
    data['CompanyName'] = this.companyName;
    data['City'] = this.city;
    return data;
  }
}
