/// Id : 1009
/// MenuImageURL : "https://theblackpearl.in/WebApi/resources/images/menu/29d79191-dc8d-45fb-8947-91ffb2111fba.png"

class GetMenuEntity {
  GetMenuEntity({
    num? id,
    String? menuImageURL,
  }) {
    _id = id;
    _menuImageURL = menuImageURL;
  }

  GetMenuEntity.fromJson(dynamic json) {
    _id = json['Id'];
    _menuImageURL = json['MenuImageURL'];
  }

  num? _id;
  String? _menuImageURL;

  GetMenuEntity copyWith({
    num? id,
    String? menuImageURL,
  }) =>
      GetMenuEntity(
        id: id ?? _id,
        menuImageURL: menuImageURL ?? _menuImageURL,
      );

  num? get id => _id;

  String? get menuImageURL => _menuImageURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['MenuImageURL'] = _menuImageURL;
    return map;
  }
}
