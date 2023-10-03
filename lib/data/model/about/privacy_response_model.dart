import '../auth/sign_up_model/registration_response_model.dart';

class PrivacyResponseModel {
  PrivacyResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  PrivacyResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status']!=null? json['status'].toString():'error';
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    List<AllPolicy>? allPolicy,}){
    _allPolicy = allPolicy;
  }

  Data.fromJson(dynamic json) {
    if (json['policy'] != null) {
      _allPolicy = [];
      json['policy'].forEach((v) {
        _allPolicy?.add(AllPolicy.fromJson(v));
      });
    }
  }
  List<AllPolicy>? _allPolicy;

  List<AllPolicy>? get allPolicy => _allPolicy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allPolicy != null) {
      map['policy'] = _allPolicy?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AllPolicy {
  AllPolicy({
    int? id,
    String? dataKeys,
    DataValues? dataValues,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _dataKeys = dataKeys;
    _dataValues = dataValues;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AllPolicy.fromJson(dynamic json) {
    _id = json['id'];
    _dataKeys = json['data_keys'];
    _dataValues = json['data_values'] != null ? DataValues.fromJson(json['data_values']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _dataKeys;
  DataValues? _dataValues;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get dataKeys => _dataKeys;
  DataValues? get dataValues => _dataValues;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['data_keys'] = _dataKeys;
    if (_dataValues != null) {
      map['data_values'] = _dataValues?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class DataValues {
  DataValues({
    String? title,
    String? details,}){
    _title = title;
    _details = details;
  }

  DataValues.fromJson(dynamic json) {
    _title = json['title'];
    _details = json['details'];
  }
  String? _title;
  String? _details;

  String? get title => _title;
  String? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['details'] = _details;
    return map;
  }

}