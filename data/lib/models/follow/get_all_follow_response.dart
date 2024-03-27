import 'package:data/models/base/base_response.dart';

/// ResponseStatus : "success"
/// Success : true
/// Message : ""
/// ResponseData : [{"UserId":3,"FCMToken":"dVoUxGVkRnWrzIsvH3cBG3:APA91bFErTxPApNr0ut2ynY4rBe5UU6b3BB6NB3cOP9RPVDGvHJd8gCnZcEzhG2FcHIyriGquvKDOHvWSke5ZXYINjS2zmrGHL_pKPogWMBekeWmTmVdzf9K2pF6OER8-oeQVrPAWBzg","RestaurantId":1002,"UserMobileNumber":"7405219112"},{"UserId":4,"FCMToken":"","RestaurantId":1002,"UserMobileNumber":"9106656796"},{"UserId":6,"FCMToken":"","RestaurantId":1002,"UserMobileNumber":"8655437186"}]

class GetAllFollowResponse extends BaseResponse {
  GetAllFollowResponse({
    String? responseStatus,
    bool? success,
    String? message,
    List<ResponseData>? responseData,
  }) {
    _responseStatus = responseStatus;
    _success = success;
    _message = message;
    _responseData = responseData;
  }

  GetAllFollowResponse.fromJson(dynamic json) {
    _responseStatus = json['ResponseStatus'];
    _success = json['Success'];
    _message = json['Message'];
    if (json['ResponseData'] != null) {
      _responseData = [];
      json['ResponseData'].forEach((v) {
        _responseData?.add(ResponseData.fromJson(v));
      });
    }
  }

  String? _responseStatus;
  bool? _success;
  String? _message;
  List<ResponseData>? _responseData;

  GetAllFollowResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    List<ResponseData>? responseData,
  }) =>
      GetAllFollowResponse(
        responseStatus: responseStatus ?? _responseStatus,
        success: success ?? _success,
        message: message ?? _message,
        responseData: responseData ?? _responseData,
      );

  String? get responseStatus => _responseStatus;

  bool? get success => _success;

  String? get message => _message;

  List<ResponseData>? get responseData => _responseData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseStatus'] = _responseStatus;
    map['Success'] = _success;
    map['Message'] = _message;
    if (_responseData != null) {
      map['ResponseData'] = _responseData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// UserId : 3
/// FCMToken : "dVoUxGVkRnWrzIsvH3cBG3:APA91bFErTxPApNr0ut2ynY4rBe5UU6b3BB6NB3cOP9RPVDGvHJd8gCnZcEzhG2FcHIyriGquvKDOHvWSke5ZXYINjS2zmrGHL_pKPogWMBekeWmTmVdzf9K2pF6OER8-oeQVrPAWBzg"
/// RestaurantId : 1002
/// UserMobileNumber : "7405219112"

class ResponseData {
  ResponseData({
    num? userId,
    String? fCMToken,
    num? restaurantId,
    String? userMobileNumber,
  }) {
    _userId = userId;
    _fCMToken = fCMToken;
    _restaurantId = restaurantId;
    _userMobileNumber = userMobileNumber;
  }

  ResponseData.fromJson(dynamic json) {
    _userId = json['UserId'];
    _fCMToken = json['FCMToken'];
    _restaurantId = json['RestaurantId'];
    _userMobileNumber = json['UserMobileNumber'];
  }

  num? _userId;
  String? _fCMToken;
  num? _restaurantId;
  String? _userMobileNumber;

  ResponseData copyWith({
    num? userId,
    String? fCMToken,
    num? restaurantId,
    String? userMobileNumber,
  }) =>
      ResponseData(
        userId: userId ?? _userId,
        fCMToken: fCMToken ?? _fCMToken,
        restaurantId: restaurantId ?? _restaurantId,
        userMobileNumber: userMobileNumber ?? _userMobileNumber,
      );

  num? get userId => _userId;

  String? get fCMToken => _fCMToken;

  num? get restaurantId => _restaurantId;

  String? get userMobileNumber => _userMobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserId'] = _userId;
    map['FCMToken'] = _fCMToken;
    map['RestaurantId'] = _restaurantId;
    map['UserMobileNumber'] = _userMobileNumber;
    return map;
  }
}
