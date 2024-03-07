/// ResponseData : "theblackpearl.in/WebApi/resources/images/menu/c7d08197-7ce9-4dfe-a714-05b1376a9b6c.png"

class AddImageEntity {
  AddImageEntity({
    String? imageUrl,
  }) {
    _responseData = imageUrl;
  }

  AddImageEntity.fromJson(dynamic json) {
    _responseData = json['ResponseData'];
  }

  String? _responseData;

  AddImageEntity copyWith({
    String? responseData,
  }) =>
      AddImageEntity(
        imageUrl: responseData ?? _responseData,
      );

  String? get imageUrl => _responseData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseData'] = _responseData;
    return map;
  }
}
