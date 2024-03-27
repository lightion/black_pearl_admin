/// UserId : 3
/// FCMToken : "dVoUxGVkRnWrzIsvH3cBG3:APA91bFErTxPApNr0ut2ynY4rBe5UU6b3BB6NB3cOP9RPVDGvHJd8gCnZcEzhG2FcHIyriGquvKDOHvWSke5ZXYINjS2zmrGHL_pKPogWMBekeWmTmVdzf9K2pF6OER8-oeQVrPAWBzg"
/// UserMobileNumber : "7405219112"

class FollowerEntity {
  FollowerEntity({
    num? userId,
    String? fCMToken,
    String? userMobileNumber,
  }) {
    _userId = userId;
    _fCMToken = fCMToken;
    _userMobileNumber = userMobileNumber;
  }

  FollowerEntity.fromJson(dynamic json) {
    _userId = json['UserId'];
    _fCMToken = json['FCMToken'];
    _userMobileNumber = json['UserMobileNumber'];
  }

  num? _userId;
  String? _fCMToken;
  String? _userMobileNumber;

  FollowerEntity copyWith({
    num? userId,
    String? fCMToken,
    String? userMobileNumber,
  }) =>
      FollowerEntity(
        userId: userId ?? _userId,
        fCMToken: fCMToken ?? _fCMToken,
        userMobileNumber: userMobileNumber ?? _userMobileNumber,
      );

  num? get userId => _userId;

  String? get fCMToken => _fCMToken;

  String? get userMobileNumber => _userMobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserId'] = _userId;
    map['FCMToken'] = _fCMToken;
    map['UserMobileNumber'] = _userMobileNumber;
    return map;
  }
}
