/// menuImageURL : "string"
/// menuType : "string"
/// uploadDate : "2024-02-24T19:30:47.500Z"
/// restaurantId : 0
/// restaurant : null

class AddMenuPostRequest {
  AddMenuPostRequest({
    String? menuImageURL,
    String? menuType,
    String? uploadDate,
    num? restaurantId,
    dynamic restaurant,
  }) {
    _menuImageURL = menuImageURL;
    _menuType = menuType;
    _uploadDate = uploadDate;
    _restaurantId = restaurantId;
    _restaurant = restaurant;
  }

  AddMenuPostRequest.fromJson(dynamic json) {
    _menuImageURL = json['menuImageURL'];
    _menuType = json['menuType'];
    _uploadDate = json['uploadDate'];
    _restaurantId = json['restaurantId'];
    _restaurant = json['restaurant'];
  }

  String? _menuImageURL;
  String? _menuType;
  String? _uploadDate;
  num? _restaurantId;
  dynamic _restaurant;

  AddMenuPostRequest copyWith({
    String? menuImageURL,
    String? menuType,
    String? uploadDate,
    num? restaurantId,
    dynamic restaurant,
  }) =>
      AddMenuPostRequest(
        menuImageURL: menuImageURL ?? _menuImageURL,
        menuType: menuType ?? _menuType,
        uploadDate: uploadDate ?? _uploadDate,
        restaurantId: restaurantId ?? _restaurantId,
        restaurant: restaurant ?? _restaurant,
      );

  String? get menuImageURL => _menuImageURL;

  String? get menuType => _menuType;

  String? get uploadDate => _uploadDate;

  num? get restaurantId => _restaurantId;

  dynamic get restaurant => _restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuImageURL'] = _menuImageURL;
    map['menuType'] = _menuType;
    map['uploadDate'] = _uploadDate;
    map['restaurantId'] = _restaurantId;
    map['restaurant'] = _restaurant;
    return map;
  }
}
