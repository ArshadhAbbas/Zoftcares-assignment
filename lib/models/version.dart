import 'dart:convert';


class VersionModel {
  bool? status;
  Map<String, dynamic>? data;
  VersionModel({
    this.status,
    this.data,
  });
  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      status: map['status'],
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  factory VersionModel.fromJson(String source) =>
      VersionModel.fromMap(json.decode(source));

  @override
  String toString() => 'VersionModel(status: $status, data: $data)';
}
