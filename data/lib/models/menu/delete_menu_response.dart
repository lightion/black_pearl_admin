import 'package:data/models/base/base_response.dart';

/// ResponseStatus : "success"
/// Success : true
/// Message : "Restaurant menu deleted successfully"
/// ResponseData : {"StatusCode":200}
/// Id : ""

class DeleteMenuResponse extends BaseResponse {
  DeleteMenuResponse({
    String? responseStatus,
    bool? success,
    String? message,
    ResponseData? responseData,
    String? id,
  }) {
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _responseData = responseData;
    _id = id;
  }

  DeleteMenuResponse.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'];
    _success = json['Success'];
    _message = json['Message'];
    _responseData = json['ResponseData'] != null
        ? ResponseData.fromJson(json['ResponseData'])
        : null;
    _id = json['Id'];
  }

  String? _responseStatus;
  bool? _success;
  String? _message;
  ResponseData? _responseData;
  String? _id;

  DeleteMenuResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    ResponseData? responseData,
    String? id,
  }) =>
      DeleteMenuResponse(
        responseStatus: responseStatus ?? _responseStatus,
        success: success ?? _success,
        message: message ?? _message,
        responseData: responseData ?? _responseData,
        id: id ?? _id,
      );

  String? get responseStatus => _responseStatus;

  bool? get success => _success;

  String? get message => _message;

  ResponseData? get responseData => _responseData;

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

/// StatusCode : 200

class ResponseData {
  ResponseData({
    num? statusCode,
  }) {
    _statusCode = statusCode;
  }

  ResponseData.fromJson(dynamic json) {
    _statusCode = json['StatusCode'];
  }

  num? _statusCode;

  ResponseData copyWith({
    num? statusCode,
  }) =>
      ResponseData(
        statusCode: statusCode ?? _statusCode,
      );

  num? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusCode'] = _statusCode;
    return map;
  }
}
