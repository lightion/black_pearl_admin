/// name : "New Rest"
/// mobileNumber : "7405219112"
/// emailAddress : "abc@abc.com"
/// address : "Makarpura"
/// restaurantImageURL : "testimage.com/test.png"
/// status : true

class AddRestaurantPostRequest {
  AddRestaurantPostRequest({
    String? name,
    String? mobileNumber,
    String? emailAddress,
    String? address,
    String? restaurantImageURL,
    bool? status,
  }) {
    _name = name;
    _mobileNumber = mobileNumber;
    _emailAddress = emailAddress;
    _address = address;
    _restaurantImageURL = restaurantImageURL;
    _status = status;
  }

  AddRestaurantPostRequest.fromJson(dynamic json) {
    _name = json['name'];
    _mobileNumber = json['mobileNumber'];
    _emailAddress = json['emailAddress'];
    _address = json['address'];
    _restaurantImageURL = json['restaurantImageURL'];
    _status = json['status'];
  }

  String? _name;
  String? _mobileNumber;
  String? _emailAddress;
  String? _address;
  String? _restaurantImageURL;
  bool? _status;

  AddRestaurantPostRequest copyWith({
    String? name,
    String? mobileNumber,
    String? emailAddress,
    String? address,
    String? restaurantImageURL,
    bool? status,
  }) =>
      AddRestaurantPostRequest(
        name: name ?? _name,
        mobileNumber: mobileNumber ?? _mobileNumber,
        emailAddress: emailAddress ?? _emailAddress,
        address: address ?? _address,
        restaurantImageURL: restaurantImageURL ?? _restaurantImageURL,
        status: status ?? _status,
      );

  String? get name => _name;

  String? get mobileNumber => _mobileNumber;

  String? get emailAddress => _emailAddress;

  String? get address => _address;

  String? get restaurantImageURL => _restaurantImageURL;

  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['mobileNumber'] = _mobileNumber;
    map['emailAddress'] = _emailAddress;
    map['address'] = _address;
    map['restaurantImageURL'] = _restaurantImageURL;
    map['status'] = _status;
    return map;
  }
}
