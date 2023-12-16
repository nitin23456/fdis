class LogoutModel {
 // bool? success;
  int? serverCode;
  String? message;
  //List<ProfileData>? data;

  LogoutModel({this.serverCode, this.message});

  LogoutModel.fromJson(Map<String, dynamic> json) {

    serverCode = json['code'];
    message = json['Message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['code'] = serverCode;
    data['Message'] = message;

    return data;
  }
}


