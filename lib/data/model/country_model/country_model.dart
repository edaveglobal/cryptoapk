
import '../auth/sign_up_model/registration_response_model.dart';

class CountryModel {
  CountryModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  CountryModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
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
    List<Countries>? countries,}){
    _countries = countries;
  }

  Data.fromJson(dynamic json) {
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Countries>? _countries;

  List<Countries>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Countries {

  Countries({
    String? country,
    String? dialCode,
    String? countryCode,}){
    _country = country;
    _dialCode = dialCode;
    _countryCode = countryCode;
  }

  Countries.fromJson(dynamic json) {
    _country = json['country'];
    _dialCode = json['dial_code'].toString();
    _countryCode = json['country_code'].toString();
  }

  String? _country;
  String? _dialCode;
  String? _countryCode;

  String? get country => _country;
  String? get dialCode => _dialCode;
  String? get countryCode => _countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['dial_code'] = _dialCode;
    map['country_code'] = _countryCode;
    return map;
  }

}