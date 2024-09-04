import 'dart:convert';

class AuthenticatedUser {
  bool? status;
  Data? data;
  AuthenticatedUser({
    this.status,
    this.data,
  });
  factory AuthenticatedUser.fromMap(Map<String, dynamic> map) {
    return AuthenticatedUser(
      status: map['status'],
      data: map['data'] != null ? Data.fromMap(map['data']) : null,
    );
  }
  factory AuthenticatedUser.fromJson(String source) =>
      AuthenticatedUser.fromMap(json.decode(source));

  @override
  String toString() => 'AuthenticatedUser(status: $status, data: $data)';
}

class Data {
  User? user;
  String? accessToken;
  double? validity;
  Data({
    this.user,
    this.accessToken,
    this.validity,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      accessToken: map['accessToken'],
      validity: map['validity']?.toDouble(),
    );
  }

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() =>
      'Data(user: $user, accessToken: $accessToken, validity: $validity)';
}

class User {
  String? firstName;
  String? lastName;
  User({
    this.firstName,
    this.lastName,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
