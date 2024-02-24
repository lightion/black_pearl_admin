import 'package:data/models/rest_response.dart';

/// $id : "1"
/// ResponseStatus : "success"
/// Success : true
/// Message : "Restaurant Inserted Successfully"
/// ResponseData : {"$id":"2","Id":1002,"Name":"New Rest","MobileNumber":"7405219112","EmailAddress":"abc@abc.com","Address":"Makarpura","RestaurantImageURL":"testimage.com/test.png","Status":false,"RestaurantMenus":null}
/// Id : "1002"

class AddRestaurantResponse {
  AddRestaurantResponse({
    String? responseStatus,
    bool? success,
    String? message,
    RestaurantResponseData? responseData,
    String? id,
  }) {
    _id = id;
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _responseData = responseData;
    _id = id;
  }

  AddRestaurantResponse.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'];
    _success = json['Success'];
    _message = json['Message'];
    _responseData = json['ResponseData'] != null
        ? RestaurantResponseData.fromJson(json['ResponseData'])
        : null;
    _id = json['Id'];
  }

  String? _responseStatus;
  bool? _success;
  String? _message;
  RestaurantResponseData? _responseData;
  String? _id;

  AddRestaurantResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    RestaurantResponseData? responseData,
    String? id,
  }) =>
      AddRestaurantResponse(
        responseStatus: responseStatus ?? _responseStatus,
        success: success ?? _success,
        message: message ?? _message,
        responseData: responseData ?? _responseData,
        id: id ?? _id,
      );

  String? get responseStatus => _responseStatus;

  bool? get success => _success;

  String? get message => _message;

  RestaurantResponseData? get responseData => _responseData;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['ResponseStatus'] = _responseStatus;
    map['Success'] = _success;
    map['Message'] = _message;
    if (_responseData != null) {
      map['ResponseData'] = _responseData?.toJson();
    }
    map['Id'] = _id;
    return map;
  }
}
