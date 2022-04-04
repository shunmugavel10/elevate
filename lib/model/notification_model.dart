import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/product_model.dart';

class NotificationModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  NotificationModel({this.count, this.value, this.error, this.info});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<NotificationContent> content;
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
      {this.content,
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
      content = new List<NotificationContent>();
      json['content'].forEach((v) {
        content.add(new NotificationContent.fromJson(v));
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
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
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

class NotificationContent {
  String id;
  AdminData adminData;
  String recipientId;
  String recipientType;
  String originatorType;
  dynamic originatorId;
  String title;
  String description;
  String visibilityType;

  NotificationContent(
      {this.id,
        this.adminData,
        this.recipientId,
        this.recipientType,
        this.originatorType,
        this.originatorId,
        this.title,
        this.description,
        this.visibilityType});

  NotificationContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'] != null
        ? new AdminData.fromJson(json['adminData'])
        : null;
    recipientId = json['recipientId'];
    recipientType = json['recipientType'];
    originatorType = json['originatorType'];
    originatorId = json['originatorId'];
    title = json['title'];
    description = json['description'];
    visibilityType = json['visibilityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.adminData != null) {
      data['adminData'] = this.adminData.toJson();
    }
    data['recipientId'] = this.recipientId;
    data['recipientType'] = this.recipientType;
    data['originatorType'] = this.originatorType;
    data['originatorId'] = this.originatorId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['visibilityType'] = this.visibilityType;
    return data;
  }
}
