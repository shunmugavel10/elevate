import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/product_model.dart';

class DocumentModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  DocumentModel({this.count, this.value, this.error, this.info});

  DocumentModel.fromJson(Map<String, dynamic> json) {
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
  List<DocumentContent> content;
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
      content = new List<DocumentContent>();
      json['content'].forEach((v) {
        content.add(new DocumentContent.fromJson(v));
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

class DocumentContent {
  String id;
  AdminData adminData;
  String fileName;
  String title;
  String contentType;
  dynamic mimeType;
  int size;
  String location;
  dynamic uploader;
  String itemId;
  String itemType;
  int retentionPeriod;
  String category;
  dynamic status;

  DocumentContent(
      {this.id,
        this.adminData,
        this.fileName,
        this.title,
        this.contentType,
        this.mimeType,
        this.size,
        this.location,
        this.uploader,
        this.itemId,
        this.itemType,
        this.retentionPeriod,
        this.category,
        this.status});

  DocumentContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'] != null
        ? new AdminData.fromJson(json['adminData'])
        : null;
    fileName = json['fileName'];
    title = json['title'];
    contentType = json['contentType'];
    mimeType = json['mimeType'];
    size = json['size'];
    location = json['location'];
    uploader = json['uploader'];
    itemId = json['itemId'];
    itemType = json['itemType'];
    retentionPeriod = json['retentionPeriod'];
    category = json['category'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.adminData != null) {
      data['adminData'] = this.adminData.toJson();
    }
    data['fileName'] = this.fileName;
    data['title'] = this.title;
    data['contentType'] = this.contentType;
    data['mimeType'] = this.mimeType;
    data['size'] = this.size;
    data['location'] = this.location;
    data['uploader'] = this.uploader;
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['retentionPeriod'] = this.retentionPeriod;
    data['category'] = this.category;
    data['status'] = this.status;
    return data;
  }
}
