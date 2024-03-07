/// menuImageURL : "theblackpearl.in/WebApi/resources/images/menu/1f9cc05d-358d-49f3-a9f5-5de90391dc24.png"
/// menuType : "lunch"
/// restaurantId : 1009

class AddMenuPostRequest {
  AddMenuPostRequest({
    String? menuImageURL,
    String? menuType,
    num? restaurantId,
  }) {
    _menuImageURL = menuImageURL;
    _menuType = menuType;
    _restaurantId = restaurantId;
  }

  AddMenuPostRequest.fromJson(dynamic json) {
    _menuImageURL = json['menuImageURL'];
    _menuType = json['menuType'];
    _restaurantId = json['restaurantId'];
  }

  String? _menuImageURL;
  String? _menuType;
  num? _restaurantId;

  AddMenuPostRequest copyWith({
    String? menuImageURL,
    String? menuType,
    num? restaurantId,
  }) =>
      AddMenuPostRequest(
        menuImageURL: menuImageURL ?? _menuImageURL,
        menuType: menuType ?? _menuType,
        restaurantId: restaurantId ?? _restaurantId,
      );

  String? get menuImageURL => _menuImageURL;

  String? get menuType => _menuType;

  num? get restaurantId => _restaurantId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuImageURL'] = _menuImageURL;
    map['menuType'] = _menuType;
    map['restaurantId'] = _restaurantId;
    return map;
  }
}
