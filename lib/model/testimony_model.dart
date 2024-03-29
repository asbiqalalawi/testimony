// To parse this JSON data, do
//
//     final testimonyModel = testimonyModelFromJson(jsonString);

import 'dart:convert';

TestimonyModel testimonyModelFromJson(String str) => TestimonyModel.fromJson(json.decode(str));

String testimonyModelToJson(TestimonyModel data) => json.encode(data.toJson());

class TestimonyModel {
  final DateTime createdAt;
  final String name;
  final String avatar;
  final String content;
  final int likes;
  final String id;

  TestimonyModel({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.content,
    required this.likes,
    required this.id,
  });

  factory TestimonyModel.fromJson(Map<String, dynamic> json) => TestimonyModel(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        content: json["content"],
        likes: json["likes"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "avatar": avatar,
        "content": content,
        "likes": likes,
        "id": id,
      };
}
