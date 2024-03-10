// To parse this JSON data, do
//
//     final albumList = albumListFromJson(jsonString);

import 'dart:convert';

List<AlbumList> albumListFromJson(String str) =>
    List<AlbumList>.from(json.decode(str).map((x) => AlbumList.fromJson(x)));

String albumListToJson(List<AlbumList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumList {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  AlbumList({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory AlbumList.fromJson(Map<String, dynamic> json) => AlbumList(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
