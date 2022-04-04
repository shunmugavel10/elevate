import 'package:farm_direct/model/product_model.dart';

class StoreModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  StoreModel({this.count, this.value, this.error, this.info});

  StoreModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    error = json['error'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    data['error'] = this.error;
    data['info'] = this.info;
    return data;
  }
}

class Value {
  Value({
    this.storeContent,
    this.pageable,
    this.totalElements,
    this.totalPages,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  List<StoreContent> storeContent;
  Pageable pageable;
  int totalElements;
  int totalPages;
  bool last;
  int size;
  int number;
  Sort sort;
  int numberOfElements;
  bool first;
  bool empty;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    storeContent: List<StoreContent>.from(json["content"].map((x) => StoreContent.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    totalElements: json["totalElements"],
    totalPages: json["totalPages"],
    last: json["last"],
    size: json["size"],
    number: json["number"],
    sort: Sort.fromJson(json["sort"]),
    numberOfElements: json["numberOfElements"],
    first: json["first"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(storeContent.map((x) => x.toJson())),
    "pageable": pageable.toJson(),
    "totalElements": totalElements,
    "totalPages": totalPages,
    "last": last,
    "size": size,
    "number": number,
    "sort": sort.toJson(),
    "numberOfElements": numberOfElements,
    "first": first,
    "empty": empty,
  };
}

class StoreContent {
  StoreContent({
    this.id,
    this.name,
    this.description,
    this.contacts,
    this.imageUrl,
    this.storeType,
  });

  String id;
  String name;
  String description;
  List<Contact> contacts;
  String imageUrl;
  String storeType;

  factory StoreContent.fromJson(Map<String, dynamic> json) => StoreContent(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
    imageUrl: json["imageUrl"],
    storeType: json["storeType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
    "imageUrl":imageUrl,
    "storeType": storeType,
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

