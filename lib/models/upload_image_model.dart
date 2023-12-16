class UploadImageModel {
  String? message;
  String? image;
  Data? data;

  UploadImageModel({this.message, this.image, this.data});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    image = json['image'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['image'] = this.image;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? auditId;
  String? image;

  Data({this.auditId, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    auditId = json['AuditId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AuditId'] = this.auditId;
    data['image'] = this.image;
    return data;
  }
}
