import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/model/store_model.dart';

class FavouriteModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  FavouriteModel({this.count, this.value, this.error, this.info});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
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
  List<FavouriteContent> favouriteContent;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  Sort sort;
  int numberOfElements;
  bool first;
  bool empty;

  Value(
      {this.favouriteContent,
        this.pageable,
        this.totalPages,
        this.totalElements,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.numberOfElements,
        this.first,
        this.empty});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      // ignore: deprecated_member_use
      favouriteContent = new List<FavouriteContent>();
      json['content'].forEach((v) {
        favouriteContent.add(new FavouriteContent.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favouriteContent != null) {
      data['content'] = this.favouriteContent.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['empty'] = this.empty;
    return data;
  }
}

class FavouriteContent {
  String id;
  AdminData adminData;
  String userId;
  String itemId;
  String itemType;
  ProductContent product;
  StoreContent store;

  FavouriteContent({this.id, this.adminData, this.userId, this.itemId, this.itemType,this.product,
    this.store});

  FavouriteContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'] != null
        ? new AdminData.fromJson(json['adminData'])
        : null;
    userId = json['userId'];
    itemId = json['itemId'];
    itemType = json['itemType'];
    product =
    json['product'] != null ? new ProductContent.fromJson(json['product']) : null;
    store = json['store'] != null ? new StoreContent.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.adminData != null) {
      data['adminData'] = this.adminData.toJson();
    }
    data['userId'] = this.userId;
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    return data;
  }
}

