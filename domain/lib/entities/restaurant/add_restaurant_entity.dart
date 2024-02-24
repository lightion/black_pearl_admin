/// ResponseStatus : "success"
/// Success : true
/// Message : "Restaurant Inserted Successfully"
/// Id : "1002"

class AddRestaurantEntity {
  AddRestaurantEntity({
    String? responseStatus,
    bool? success,
    String? message,
    String? id,
  }) {
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _id = id;
  }

  AddRestaurantEntity.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'];
    _success = json['Success'];
    _message = json['Message'];
    _id = json['Id'];
  }

  String? _responseStatus;
  bool? _success;
  String? _message;
  String? _id;

  AddRestaurantEntity copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    String? id,
  }) =>
      AddRestaurantEntity(
        responseStatus: responseStatus ?? _responseStatus,
        success: success ?? _success,
        message: message ?? _message,
        id: id ?? _id,
      );

  String? get responseStatus => _responseStatus;

  bool? get success => _success;

  String? get message => _message;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseStatus'] = _responseStatus;
    map['Success'] = _success;
    map['Message'] = _message;
    map['Id'] = _id;
    return map;
  }
}
