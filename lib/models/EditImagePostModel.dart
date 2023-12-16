class EditImagePostModel {
  bool? success;
  int? serverCode;
  String? message;
  String? data;

  EditImagePostModel({this.success, this.serverCode, this.message, this.data});

  EditImagePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    serverCode = json['serverCode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['serverCode'] = this.serverCode;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}