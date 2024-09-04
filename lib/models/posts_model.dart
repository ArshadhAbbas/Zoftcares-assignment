import 'dart:convert';

class PostsModel {
  bool? status;
  String? message;
  List<Datum>? data;
  int? currentPage;
  int? pageSize;
  int? totalItems;
  int? totalPages;
  int? nextPage;
  dynamic previousPage;
  bool? hasMore;
  PostsModel({
    this.status,
    this.message,
    this.data,
    this.currentPage,
    this.pageSize,
    this.totalItems,
    this.totalPages,
    this.nextPage,
    required this.previousPage,
    this.hasMore,
  });

  factory PostsModel.fromMap(Map<String, dynamic> map) {
    return PostsModel(
      status: map['status'],
      message: map["message"],
      data: map['data'] != null
          ? List<Datum>.from(map['data']?.map((x) => Datum.fromMap(x)))
          : null,
      currentPage: map['currentPage']?.toInt(),
      pageSize: map['pageSize']?.toInt(),
      totalItems: map['totalItems']?.toInt(),
      totalPages: map['totalPages']?.toInt(),
      nextPage: map['nextPage']?.toInt(),
      previousPage: map['previousPage'],
      hasMore: map['hasMore'],
    );
  }

  factory PostsModel.fromJson(String source) =>
      PostsModel.fromMap(json.decode(source));
}

class Datum {
  int? id;
  String? title;
  String? body;
  String? image;
  Datum({
    this.id,
    this.title,
    this.body,
    this.image,
  });

  factory Datum.fromMap(Map<String, dynamic> map) {
    return Datum(
      id: map['id']?.toInt(),
      title: map['title'],
      body: map['body'],
      image: map['image'],
    );
  }

  factory Datum.fromJson(String source) => Datum.fromMap(json.decode(source));
}
