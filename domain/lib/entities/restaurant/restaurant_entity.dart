/// $id : "2"
/// Id : 1
/// Name : "Test Restaurant"
/// MobileNumber : "9090988000"
/// EmailAddress : "test@restaurant.com"
/// Address : "ABC Surat"
/// RestaurantImageURL : "testimage.com/test.png"
/// Status : false
/// RestaurantMenus : null

class RestaurantEntity {
  RestaurantEntity({
    int? id,
    String? name,
    String? mobileNumber,
    String? emailAddress,
    String? address,
    String? restaurantImageURL,
    bool? status,
    dynamic restaurantMenus,
  }) {
    _id = id;
    _name = name;
    _mobileNumber = mobileNumber;
    _emailAddress = emailAddress;
    _address = address;
    _restaurantImageURL = restaurantImageURL;
    _status = status;
    _restaurantMenus = restaurantMenus;
  }

  RestaurantEntity.fromJson(dynamic json) {
    _id = json['Id'];
    _name = json['Name'];
    _mobileNumber = json['MobileNumber'];
    _emailAddress = json['EmailAddress'];
    _address = json['Address'];
    _restaurantImageURL = json['RestaurantImageURL'];
    _status = json['Status'];
    _restaurantMenus = json['RestaurantMenus'];
  }

  int? _id;
  String? _name;
  String? _mobileNumber;
  String? _emailAddress;
  String? _address;
  String? _restaurantImageURL;
  bool? _status;
  dynamic _restaurantMenus;

  RestaurantEntity copyWith({
    int? id,
    String? name,
    String? mobileNumber,
    String? emailAddress,
    String? address,
    String? restaurantImageURL,
    bool? status,
    dynamic restaurantMenus,
  }) =>
      RestaurantEntity(
        id: id ?? _id,
        name: name ?? _name,
        mobileNumber: mobileNumber ?? _mobileNumber,
        emailAddress: emailAddress ?? _emailAddress,
        address: address ?? _address,
        restaurantImageURL: restaurantImageURL ?? _restaurantImageURL,
        status: status ?? _status,
        restaurantMenus: restaurantMenus ?? _restaurantMenus,
      );

  int? get id => _id;

  String? get name => _name;

  String? get mobileNumber => _mobileNumber;

  String? get emailAddress => _emailAddress;

  String? get address => _address;

  String? get restaurantImageURL => _restaurantImageURL;

  bool? get status => _status;

  dynamic get restaurantMenus => _restaurantMenus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['Name'] = _name;
    map['MobileNumber'] = _mobileNumber;
    map['EmailAddress'] = _emailAddress;
    map['Address'] = _address;
    map['RestaurantImageURL'] = _restaurantImageURL;
    map['Status'] = _status;
    map['RestaurantMenus'] = _restaurantMenus;
    return map;
  }
}
