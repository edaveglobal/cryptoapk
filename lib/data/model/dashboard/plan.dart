
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
  int?     _id;
  String?  _name;
  String?  _minimum;
  String?  _maximum;
  String?  _fixedAmount;
  String?  _interest;
  String?  _interestType;
  String?  _time;
  String?  _timeName;
  String?  _status;
  String?  _featured;
  String?  _capitalBack;
  String?  _lifetime;
  String?  _repeatTime;
  String?  _createdAt;
  String?  _updatedAt;

  int?    get id => _id;
  String? get name => _name;
  String? get minimum => _minimum;
  String? get maximum => _maximum;
  String? get fixedAmount => _fixedAmount;
  String? get interest => _interest;
  String? get interestType => _interestType;
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