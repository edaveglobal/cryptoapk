import '../auth/sign_up_model/registration_response_model.dart';

class PricingPlanModel {
  PricingPlanModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  PricingPlanModel.fromJson(dynamic json) {
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
    List<Plans>? plans,}){
    _plans = plans;
  }

  Data.fromJson(dynamic json) {
    if (json['plans'] != null) {
      _plans = [];
      json['plans'].forEach((v) {
        _plans?.add(Plans.fromJson(v));
      });
    }
  }
  List<Plans>? _plans;
  List<Plans>? get plans => _plans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_plans != null) {
      map['plans'] = _plans?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Plans {
  Plans({
    int? id,
    String? name,
    String? minimum,
    String? maximum,
    String? fixedAmount,
    String? return_,
    String? interestDuration,
    String? repeatTime,
    String? totalReturn,
    String? interestValidity,}){
    _id = id;
    _name = name;
    _minimum = minimum;
    _maximum = maximum;
    _fixedAmount = fixedAmount;
    _return = return_;
    _interestDuration = interestDuration;
    _repeatTime = repeatTime;
    _totalReturn = totalReturn;
    _interestValidity = interestValidity;
  }

  Plans.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _minimum = json['minimum'].toString();
    _maximum = json['maximum'].toString();
    _fixedAmount = json['fixed_amount'].toString();
    _return = json['return'].toString();
    _interestDuration = json['interest_duration'].toString();
    _repeatTime = json['repeat_time'].toString();
    _totalReturn = json['total_return'].toString();
    _interestValidity = json['interest_validity'].toString();
  }
  int? _id;
  String? _name;
  String? _minimum;
  String? _maximum;
  String? _fixedAmount;
  String? _return;
  String? _interestDuration;
  String? _repeatTime;
  String? _totalReturn;
  String? _interestValidity;

  int? get id => _id;
  String? get name => _name;
  String? get minimum => _minimum;
  String? get maximum => _maximum;
  String? get fixedAmount => _fixedAmount;
  String? get return_ => _return;
  String? get interestDuration => _interestDuration;
  String? get repeatTime => _repeatTime;
  String? get totalReturn => _totalReturn;
  String? get interestValidity => _interestValidity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['minimum'] = _minimum;
    map['maximum'] = _maximum;
    map['fixed_amount'] = _fixedAmount;
    map['return'] = _return;
    map['interest_duration'] = _interestDuration;
    map['repeat_time'] = _repeatTime;
    map['total_return'] = _totalReturn;
    map['interest_validity'] = _interestValidity;
    return map;
  }

}