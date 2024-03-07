import 'package:data/models/base/base_response.dart';

/// ResponseStatus : "success"
/// Success : true
/// Message : ""
/// ResponseData : "theblackpearl.in/WebApi/resources/images/menu/c7d08197-7ce9-4dfe-a714-05b1376a9b6c.png"
/// Id : ""

class AddImageResponse extends BaseResponse {
  AddImageResponse({
    bool? success,
    String? message,
    String? responseData,
    String? id,
  }) {
    _success = success;
    _message = message;
    _responseData = responseData;
    _id = id;
  }

  AddImageResponse.fromJson(dynamic json) {
    _success = json['Success'];
    _message = json['Message'];
    _responseData = json['ResponseData'];
    _id = json['Id'];
  }

  bool? _success;
  String? _message;
  String? _responseData;
  String? _id;

  AddImageResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    String? responseData,
    String? id,
  }) =>
      AddImageResponse(
        success: success ?? _success,
        message: message ?? _message,
        responseData: responseData ?? _responseData,
        id: id ?? _id,
      );

  bool? get success => _success;

  String? get message => _message;

  String? get responseData => _responseData;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Success'] = _success;
    map['Message'] = _message;
    map['ResponseData'] = _responseData;
    map['Id'] = _id;
    return map;
  }
}
