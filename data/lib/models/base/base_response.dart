class BaseResponse {
  BaseResponse({Error? error}) {
    _error = error;
  }

  BaseResponse.fromJson(dynamic json) {
    _error = json['ResponseStatus'] != 200 ? Error.fromJson(json) : null;
  }

  void setError(Error? value) {
    _error = value;
  }

  Error? _error;

  Error? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_error != null) {
      map['error'] = _error?.toJson();
    }
    return map;
  }
}

class Error {
  Error({
    String? errorCode,
    String? description,
  }) {
    _errorCode = errorCode;
    _description = description;
  }

  Error.fromJson(dynamic json) {
    try {
      final errorCode = json['ResponseStatus'];
      _errorCode = errorCode.toString();
      _description = json['Message'];
    } catch (e) {
      _errorCode = "Server Failure";
      _description = "Something went wrong, please try again later";
    }
  }

  String? _errorCode;
  String? _description;

  String? get errorCode => _errorCode;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCode'] = _errorCode;
    map['description'] = _description;
    return map;
  }
}
