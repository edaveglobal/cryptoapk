import '../auth/sign_up_model/registration_response_model.dart';

class MyInvestmentResponseModel {
  MyInvestmentResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  MyInvestmentResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainData = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _mainData;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _mainData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_mainData != null) {
      map['data'] = _mainData?.toJson();
    }
    return map;
  }

}


class MainData {
  MainData({
      Invests? invests,}){
    _invests = invests;
}

  MainData.fromJson(dynamic json) {
    _invests = json['invests'] != null ? Invests.fromJson(json['invests']) : null;
  }

  Invests? _invests;
  Invests? get invests => _invests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_invests != null) {
      map['invests'] = _invests?.toJson();
    }
    return map;
  }

}

class Invests {
  Invests({
      List<Data>? data, 
      String? nextPage,}){
    _data = data;
    _nextPage = nextPage;
}

  Invests.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPage = json['next_page'];
  }
  List<Data>? _data;
  String? _nextPage;

  List<Data>? get data => _data;
  String? get nextPage => _nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page'] = _nextPage;
    return map;
  }

}

class Data {
  Data({
      int? id,
      String? userId,
      String? planId,
      String? amount, 
      String? interest, 
      String? shouldPay, 
      String? paid, 
      String? period,
      String? hours, 
      String? timeName, 
      String? returnRecTime,
      String? nextTime,
      String? nextTimePercent,
      String? status,
      String? capitalStatus,
      String? walletType, 
      Plan? plan,}){
    _id = id;
    _userId = userId;
    _planId = planId;
    _amount = amount;
    _interest = interest;
    _shouldPay = shouldPay;
    _paid = paid;
    _period = period;
    _hours = hours;
    _timeName = timeName;
    _returnRecTime = returnRecTime;
    _nextTime = nextTime;
    _nextTimePercent = nextTimePercent;
    _status = status;
    _capitalStatus = capitalStatus;
    _walletType = walletType;
    _plan = plan;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _planId = json['plan_id'].toString();
    _amount = json['amount'].toString();
    _interest = json['interest'].toString();
    _shouldPay = json['should_pay'].toString();
    _paid = json['paid'].toString();
    _period = json['period'].toString();
    _hours = json['hours'].toString();
    _timeName = json['time_name'].toString();
    _returnRecTime = json['return_rec_time'].toString();
    _nextTime = json['next_time'].toString();
    _nextTimePercent = json['next_time_percent'] !=null?json['next_time_percent'].toString():'0';
    _status = json['status'].toString();
    _capitalStatus = json['capital_status'].toString();
    _walletType = json['wallet_type'].toString();
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  int? _id;
  String? _userId;
  String? _planId;
  String? _amount;
  String? _interest;
  String? _shouldPay;
  String? _paid;
  String? _period;
  String? _hours;
  String? _timeName;
  String? _returnRecTime;
  String? _nextTime;
  String? _nextTimePercent;
  String? _status;
  String? _capitalStatus;
  String? _walletType;
  Plan? _plan;

  int? get id => _id;
  String? get userId => _userId;
  String? get planId => _planId;
  String? get amount => _amount;
  String? get interest => _interest;
  String? get shouldPay => _shouldPay;
  String? get paid => _paid;
  String? get period => _period;
  String? get hours => _hours;
  String? get timeName => _timeName;
  String? get returnRecTime => _returnRecTime;
  String? get nextTime => _nextTime;
  String? get nextTimePercent => _nextTimePercent;
  String? get status => _status;
  String? get capitalStatus => _capitalStatus;
  String? get walletType => _walletType;
  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['plan_id'] = _planId;
    map['amount'] = _amount;
    map['interest'] = _interest;
    map['should_pay'] = _shouldPay;
    map['paid'] = _paid;
    map['period'] = _period;
    map['hours'] = _hours;
    map['time_name'] = _timeName;
    map['return_rec_time'] = _returnRecTime;
    map['next_time'] = _nextTime;
    map['status'] = _status;
    map['capital_status'] = _capitalStatus;
    map['wallet_type'] = _walletType;
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }

}

class Plan {
  Plan({
      int? id, 
      String? name, 
      String? minimum, 
      String? maximum, 
      String? fixedAmount, 
      String? interest, 
      String? interestType,
      String? time, 
      String? timeName, 
      String? status,
      String? featured,
      String? capitalBack,
      String? lifetime,
      String? repeatTime, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _minimum = minimum;
    _maximum = maximum;
    _fixedAmount = fixedAmount;
    _interest = interest;
    _interestType = interestType;
    _time = time;
    _timeName = timeName;
    _status = status;
    _featured = featured;
    _capitalBack = capitalBack;
    _lifetime = lifetime;
    _repeatTime = repeatTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _minimum = json['minimum'].toString();
    _maximum = json['maximum'].toString();
    _fixedAmount = json['fixed_amount'].toString();
    _interest = json['interest'].toString();
    _interestType = json['interest_type'].toString();
    _time = json['time'].toString();
    _timeName = json['time_name'].toString();
    _status = json['status'].toString();
    _featured = json['featured'].toString();
    _capitalBack = json['capital_back'].toString();
    _lifetime = json['lifetime'].toString();
    _repeatTime = json['repeat_time'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _minimum;
  String? _maximum;
  String? _fixedAmount;
  String? _interest;
  String? _interestType;
  String? _time;
  String? _timeName;
  String? _status;
  String? _featured;
  String? _capitalBack;
  String? _lifetime;
  String? _repeatTime;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get minimum => _minimum;
  String? get maximum => _maximum;
  String? get fixedAmount => _fixedAmount;
  String? get interest => _interest;
  String?  get interestType => _interestType;
  String? get time => _time;
  String? get timeName => _timeName;
  String? get status => _status;
  String? get featured => _featured;
  String? get capitalBack => _capitalBack;
  String? get lifetime => _lifetime;
  String? get repeatTime => _repeatTime;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['minimum'] = _minimum;
    map['maximum'] = _maximum;
    map['fixed_amount'] = _fixedAmount;
    map['interest'] = _interest;
    map['interest_type'] = _interestType;
    map['time'] = _time;
    map['time_name'] = _timeName;
    map['status'] = _status;
    map['featured'] = _featured;
    map['capital_back'] = _capitalBack;
    map['lifetime'] = _lifetime;
    map['repeat_time'] = _repeatTime;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
