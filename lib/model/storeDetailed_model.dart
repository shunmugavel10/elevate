import 'dart:convert';
import 'package:farm_direct/model/product_model.dart';

StoreDetailedContent storeDetailedContentFromJson(String str) => StoreDetailedContent.fromJson(json.decode(str));

String storeDetailedContentToJson(StoreDetailedContent data) => json.encode(data.toJson());

class StoreDetailedContent {
  StoreDetailedContent({
    this.id,
    this.name,
    this.description,
    this.contacts,
    this.storeType,
    this.storeData,
  });

  String id;
  String name;
  String description;
  List<Contact> contacts;
  String storeType;
  StoreData storeData;

  factory StoreDetailedContent.fromJson(Map<String, dynamic> json) => StoreDetailedContent(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
    storeType: json["storeType"],
    storeData: StoreData.fromJson(json["storeData"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
    "storeType": storeType,
    "storeData": storeData.toJson(),
  };
}

class Contact {
  Contact({
    this.ownerId,
    this.name,
    this.firstName,
    this.phone,
  });

  String ownerId;
  String name;
  String firstName;
  String phone;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    ownerId: json["ownerId"],
    name: json["name"],
    firstName: json["firstName"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "ownerId": ownerId,
    "name": name,
    "firstName": firstName,
    "phone": phone,
  };
}

class StoreData {
  StoreData({
    this.promotions,
    this.faqLocation,
    this.categories,
  });

  dynamic promotions;
  dynamic faqLocation;
  List<Category> categories;

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
    promotions: json["promotions"],
    faqLocation: json["faqLocation"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "promotions": promotions,
    "faqLocation": faqLocation,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.name,
    this.description,
    this.products,
  });

  String name;
  String description;
  List<ProductContent> products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    description: json["description"],
    products: json["products"] == null ? null : List<ProductContent>.from(json["products"].map((x) => ProductContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

