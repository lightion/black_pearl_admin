import 'package:data/models/rest_response.dart';

/// $id : "1"
/// ResponseStatus : "success"
/// Success : true
/// Message : "Restaurant Updated Successfully"
/// ResponseData : {"$id":"2","Id":1002,"Name":"New Rest","MobileNumber":"7405219111","EmailAddress":"abc@abc.com","Address":"Makarpura","RestaurantImageURL":"testimage.com/test.png","Status":true,"RestaurantMenus":null}
/// Id : "1002"

class MobileRestaurantResponse {
  MobileRestaurantResponse({
    String? responseStatus,
    bool? success,
    String? message,
    RestaurantResponseData? responseData,
    String? id,
  }) {
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _responseData = responseData;
    _id = id;
  }

  MobileRestaurantResponse.fromJson(dynamic json) {
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

  MobileRestaurantResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    RestaurantResponseData? responseData,
    String? id,
  }) =>
      MobileRestaurantResponse(
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
