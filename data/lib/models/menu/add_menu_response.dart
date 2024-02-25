import 'package:data/models/base/base_response.dart';

/// ResponseStatus : "success"
/// Success : true
/// Message : "Restaurant Inserted Successfully"
/// ResponseData : {"Id":1002,"MenuImageURL":"string","UploadDate":"2024-02-24T08:52:25.9561795+00:00","RestaurantId":2,"Restaurant":null}
/// Id : "1002"

class AddMenuResponse extends BaseResponse {
  AddMenuResponse({
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

  AddMenuResponse.fromJson(dynamic json) {
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

  AddMenuResponse copyWith({
    String? responseStatus,
    bool? success,
    String? message,
    ResponseData? responseData,
    String? id,
  }) =>
      AddMenuResponse(
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

/// Id : 1002
/// MenuImageURL : "string"
/// UploadDate : "2024-02-24T08:52:25.9561795+00:00"
/// RestaurantId : 2
/// Restaurant : null

class ResponseData {
  ResponseData({
    num? id,
    String? menuImageURL,
    String? uploadDate,
    num? restaurantId,
    dynamic restaurant,
  }) {
    _id = id;
    _menuImageURL = menuImageURL;
    _uploadDate = uploadDate;
    _restaurantId = restaurantId;
    _restaurant = restaurant;
  }

  ResponseData.fromJson(dynamic json) {
    _id = json['Id'];
    _menuImageURL = json['MenuImageURL'];
    _uploadDate = json['UploadDate'];
    _restaurantId = json['RestaurantId'];
    _restaurant = json['Restaurant'];
  }

  num? _id;
  String? _menuImageURL;
  String? _uploadDate;
  num? _restaurantId;
  dynamic _restaurant;

  ResponseData copyWith({
    num? id,
    String? menuImageURL,
    String? uploadDate,
    num? restaurantId,
    dynamic restaurant,
  }) =>
      ResponseData(
        id: id ?? _id,
        menuImageURL: menuImageURL ?? _menuImageURL,
        uploadDate: uploadDate ?? _uploadDate,
        restaurantId: restaurantId ?? _restaurantId,
        restaurant: restaurant ?? _restaurant,
      );

  num? get id => _id;

  String? get menuImageURL => _menuImageURL;

  String? get uploadDate => _uploadDate;

  num? get restaurantId => _restaurantId;

  dynamic get restaurant => _restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['MenuImageURL'] = _menuImageURL;
    map['UploadDate'] = _uploadDate;
    map['RestaurantId'] = _restaurantId;
    map['Restaurant'] = _restaurant;
    return map;
  }
}
