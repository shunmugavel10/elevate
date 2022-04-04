import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  BannerModel({
    this.name,
    this.code,
    this.description,
    this.imageUrl,
  });

  String name;
  String code;
  String description;
  String imageUrl;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    name: json["name"],
    code: json["code"],
    description: json["description"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "description": description,
    "imageUrl": imageUrl,
  };
}
