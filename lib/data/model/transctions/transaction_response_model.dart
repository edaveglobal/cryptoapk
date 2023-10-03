import '../auth/sign_up_model/registration_response_model.dart';

class TransactionResponseModel {
  TransactionResponseModel({
      String? remark, 
      String? status, 
      Message? message,
      MainData? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  TransactionResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _data;

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

class MainData {
  MainData({
      Transactions? transactions, 
      List<Remarks>? remarks,}){
    _transactions = transactions;
    _remarks = remarks;
}

  MainData.fromJson(dynamic json) {
    _transactions = json['transactions'] != null ? Transactions.fromJson(json['transactions']) : null;
    if (json['remarks'] != null) {
      _remarks = [];
      json['remarks'].forEach((v) {
        _remarks?.add(Remarks.fromJson(v));
      });
    }
  }
  Transactions? _transactions;
  List<Remarks>? _remarks;

  Transactions? get transactions => _transactions;
  List<Remarks>? get remarks => _remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactions != null) {
      map['transactions'] = _transactions?.toJson();
    }
    if (_remarks != null) {
      map['remarks'] = _remarks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Remarks {
  Remarks({
      String? remark,}){
    _remark = remark;
}

  Remarks.fromJson(dynamic json) {
    _remark = json['remark'].toString();
  }
  String? _remark;

  String? get remark => _remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    return map;
  }

}

class Transactions {
  Transactions({
      int? currentPage, 
      List<Data>? data,
      String? path,
      String? nextPageUrl
    }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  Transactions.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<Data>? _data;
  String? _nextPageUrl;
  String? _path;

  List<Data>? get data => _data;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    return map;
  }

}
class Data {
  Data({
      int? id,
      String? amount, 
      String? commissionPercent, 
      String? charge, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _amount = amount;
    _commissionPercent = commissionPercent;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'].toString();
    _commissionPercent = json['commission_percent'].toString();
    _charge = json['charge'].toString();
    _postBalance = json['post_balance'].toString();
    _trxType = json['trx_type'].toString();
    _trx = json['trx'].toString();
    _details = json['details'].toString();
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _userId;
  String? _amount;
  String? _commissionPercent;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get userId => _userId;
  String? get amount => _amount;
  String? get commissionPercent => _commissionPercent;
  String? get charge => _charge;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['commission_percent'] = _commissionPercent;
    map['charge'] = _charge;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}