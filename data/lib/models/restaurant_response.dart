import 'package:data/models/base/base_response.dart';
import 'package:data/models/rest_response.dart';

/// ResponseStatus : "success"
/// Success : true
/// Message : ""
/// ResponseData : [{"Id":1,"Name":"Test Restaurant","MobileNumber":"9090988000","EmailAddress":"test@restaurant.com","Address":"ABC Surat","RestaurantImageURL":"testimage.com/test.png","Status":false,"RestaurantMenus":null},{"Id":2,"Name":"Veg Restro","MobileNumber":"1000527820","EmailAddress":"test@vegrestro.com","Address":"XYZ Vadodara","RestaurantImageURL":"testimage.com/test.png","Status":false,"RestaurantMenus":null}]
/// Id : ""

class RestaurantResponse extends BaseResponse {
  RestaurantResponse({
    String? id,
    String? responseStatus,
    bool? success,
    String? message,
    List<RestaurantResponseData>? responseData,
  }) {
    _id = id;
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _responseData = responseData;
  }

  RestaurantResponse.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'];
    _success = json['Success'];
    _message = json['Message'];
    if (json['ResponseData'] != null) {
      _responseData = [];
      json['ResponseData'].forEach((v) {
        _responseData?.add(RestaurantResponseData.fromJson(v));
      });
    }
    _id = json['Id'];
  }

  String? _id;
  String? _responseStatus;
  bool? _success;
  String? _message;
  List<RestaurantResponseData>? _responseData;

  RestaurantResponse copyWith({
    String? id,
    String? responseStatus,
    bool? success,
    String? message,
    List<RestaurantResponseData>? responseData,
  }) =>
      RestaurantResponse(
        id: id ?? _id,
        responseStatus: responseStatus ?? _responseStatus,
        success: success ?? _success,
        message: message ?? _message,
        responseData: responseData ?? _responseData,
      );

  String? get id => _id;

  String? get responseStatus => _responseStatus;

  bool? get success => _success;

  String? get message => _message;

  List<RestaurantResponseData>? get responseData => _responseData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseStatus'] = _responseStatus;
    map['Success'] = _success;
    map['Message'] = _message;
    if (_responseData != null) {
      map['ResponseData'] = _responseData?.map((v) => v.toJson()).toList();
    }
    map['Id'] = _id;
    return map;
  }
}
