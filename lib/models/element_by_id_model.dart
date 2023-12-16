class ElementByIdModel {
  bool? success;
  int? serverCode;
  String? message;
  Data? data;

  ElementByIdModel({this.success, this.serverCode, this.message, this.data});

  ElementByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? elementTypeId;
  String? elementTypeValue;
  int? sortOrder;
  List<AreaDescription>? areaDescription;

  Rows(
      {this.elementTypeId,
      this.elementTypeValue,
      this.sortOrder,
      this.areaDescription});

  Rows.fromJson(Map<String, dynamic> json) {
    elementTypeId = json['ElementTypeId'];
    elementTypeValue = json['ElementTypeValue'];
    sortOrder = json['SortOrder'];
    if (json['AreaDescription'] != null) {
      areaDescription = <AreaDescription>[];
      json['AreaDescription'].forEach((v) {
        areaDescription!.add(new AreaDescription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ElementTypeId'] = this.elementTypeId;
    data['ElementTypeValue'] = this.elementTypeValue;
    data['SortOrder'] = this.sortOrder;
    if (this.areaDescription != null) {
      data['AreaDescription'] =
          this.areaDescription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaDescription {
  int? id;
  int? moduleId;
  String? name;
  String? abbreviation;
  bool? active;
  AreaDescriptionElementType? areaDescriptionElementType;

  AreaDescription(
      {this.id,
      this.moduleId,
      this.name,
      this.abbreviation,
      this.active,
      this.areaDescriptionElementType});

  AreaDescription.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    moduleId = json['ModuleId'];
    name = json['Name'];
    abbreviation = json['Abbreviation'];
    active = json['Active'];
    areaDescriptionElementType = json['AreaDescription_ElementType'] != null
        ? new AreaDescriptionElementType.fromJson(
            json['AreaDescription_ElementType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ModuleId'] = this.moduleId;
    data['Name'] = this.name;
    data['Abbreviation'] = this.abbreviation;
    data['Active'] = this.active;
    if (this.areaDescriptionElementType != null) {
      data['AreaDescription_ElementType'] =
          this.areaDescriptionElementType!.toJson();
    }
    return data;
  }
}

class AreaDescriptionElementType {
  int? areaDescModuleId;
  int? areaDescId;
  String? elementTypeId;

  AreaDescriptionElementType(
      {this.areaDescModuleId, this.areaDescId, this.elementTypeId});

  AreaDescriptionElementType.fromJson(Map<String, dynamic> json) {
    areaDescModuleId = json['AreaDescModuleId'];
    areaDescId = json['AreaDescId'];
    elementTypeId = json['ElementTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AreaDescModuleId'] = this.areaDescModuleId;
    data['AreaDescId'] = this.areaDescId;
    data['ElementTypeId'] = this.elementTypeId;
    return data;
  }
}
