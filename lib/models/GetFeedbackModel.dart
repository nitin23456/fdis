class GetFeedbackModel {
  bool? success;
  int? serverCode;
  String? message;
  List<GetFeed>? data;

  GetFeedbackModel({this.success, this.serverCode, this.message, this.data});

  GetFeedbackModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    serverCode = json['serverCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFeed>[];
      json['data'].forEach((v) {
        data!.add(new GetFeed.fromJson(v));
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

class GetFeed {
  String? elementAuditComment;

  GetFeed({this.elementAuditComment});

  GetFeed.fromJson(Map<String, dynamic> json) {
    elementAuditComment = json['ElementAuditComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ElementAuditComment'] = this.elementAuditComment;
    return data;
  }
}