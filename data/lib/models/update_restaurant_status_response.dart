import 'package:data/models/base/base_response.dart';

/// ResponseStatus : "success"
/// Success : true
/// Message : "Status Updated Successfully"
/// ResponseData : true
/// Id : ""

class UpdateRestaurantStatusResponse extends BaseResponse {
  UpdateRestaurantStatusResponse({
    String? responseStatus,
    bool? success,
    String? message,
    bool? responseData,
    String? id,
  }) {
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _responseData = responseData;
    _id = id;
  }

  UpdateRestaurantStatusResponse.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'];
    _success = json['Success'];
    _message = json['Message'];
    _responseData = json['ResponseData'];
    _id = json['Id'];
  }

  String? _responseStatus;
  bool? _success;
  String? _message;
  bool? _responseData;
  String? _id;

  UpdateRestaurantStatusResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    bool? responseData,
    String? id,
  }) =>
      UpdateRestaurantStatusResponse(
        responseStatus: responseStatus ?? _responseStatus,
        success: success ?? _success,
        message: message ?? _message,
        responseData: responseData ?? _responseData,
        id: id ?? _id,
      );

  String? get responseStatus => _responseStatus;

  bool? get success => _success;

  String? get message => _message;

  bool? get responseData => _responseData;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseStatus'] = _responseStatus;
    map['Success'] = _success;
    map['Message'] = _message;
    map['ResponseData'] = _responseData;
    map['Id'] = _id;
    return map;
  }
}
