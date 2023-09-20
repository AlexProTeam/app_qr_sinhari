class ConfirmModel {
  bool? error;
  Data? data;
  String? message;
  bool? success;

  ConfirmModel({this.error, this.data, this.message, this.success});

  ConfirmModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }
}

class Data {
  Result? result;
  String? action;

  Data({this.result, this.action});

  Data.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['action'] = action;
    return data;
  }
}

class Result {
  String? accessToken;
  Token? token;

  Result({this.accessToken, this.token});

  Result.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Token {
  AccessToken? accessToken;
  String? plainTextToken;

  Token({this.accessToken, this.plainTextToken});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'] != null
        ? AccessToken.fromJson(json['accessToken'])
        : null;
    plainTextToken = json['plainTextToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accessToken != null) {
      data['accessToken'] = accessToken!.toJson();
    }
    data['plainTextToken'] = plainTextToken;
    return data;
  }
}

class AccessToken {
  String? name;
  List<String>? abilities;
  dynamic expiresAt;
  int? tokenableId;
  String? tokenableType;
  String? updatedAt;
  String? createdAt;
  int? id;

  AccessToken(
      {this.name,
      this.abilities,
      this.expiresAt,
      this.tokenableId,
      this.tokenableType,
      this.updatedAt,
      this.createdAt,
      this.id});

  AccessToken.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    abilities = json['abilities'].cast<String>();
    expiresAt = json['expires_at'];
    tokenableId = json['tokenable_id'];
    tokenableType = json['tokenable_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['abilities'] = abilities;
    data['expires_at'] = expiresAt;
    data['tokenable_id'] = tokenableId;
    data['tokenable_type'] = tokenableType;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
