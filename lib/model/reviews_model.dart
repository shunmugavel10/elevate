import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/product_model.dart';

class ReviewsModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  ReviewsModel({this.count, this.value, this.error, this.info});

  ReviewsModel.fromJson(Map<String, dynamic> json) {
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
  List<ReviewContent> content;
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
      content = new List<ReviewContent>();
      json['content'].forEach((v) {
        content.add(new ReviewContent.fromJson(v));
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

class ReviewContent {
  String id;
  AdminData adminData;
  String itemId;
  String itemType;
  Reviewer reviewer;
  Reviewer requestor;
  String rating;
  int ratingZeroToFive;
  String feedback;
  String reviewStatus;

  ReviewContent(
      {this.id,
        this.adminData,
        this.itemId,
        this.itemType,
        this.reviewer,
        this.requestor,
        this.rating,
        this.ratingZeroToFive,
        this.feedback,
        this.reviewStatus});

  ReviewContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'] != null
        ? new AdminData.fromJson(json['adminData'])
        : null;
    itemId = json['itemId'];
    itemType = json['itemType'];
    reviewer = json['reviewer'] != null
        ? new Reviewer.fromJson(json['reviewer'])
        : null;
    requestor = json['requestor'] != null
        ? new Reviewer.fromJson(json['requestor'])
        : null;
    rating = json['rating'];
    ratingZeroToFive = json['ratingZeroToFive'];
    feedback = json['feedback'];
    reviewStatus = json['reviewStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.adminData != null) {
      data['adminData'] = this.adminData.toJson();
    }
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    if (this.reviewer != null) {
      data['reviewer'] = this.reviewer.toJson();
    }
    if (this.requestor != null) {
      data['requestor'] = this.requestor.toJson();
    }
    data['rating'] = this.rating;
    data['ratingZeroToFive'] = this.ratingZeroToFive;
    data['feedback'] = this.feedback;
    data['reviewStatus'] = this.reviewStatus;
    return data;
  }
}

class Reviewer {
  String userId;
  String profileUrl;
  String userName;
  String createdAt;

  Reviewer({this.userId, this.profileUrl, this.userName, this.createdAt});

  Reviewer.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileUrl = json['profileUrl'];
    userName = json['userName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['profileUrl'] = this.profileUrl;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

