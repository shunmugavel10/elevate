// import 'category_model.dart';

// class CouponModel {
//   int count;
//   Value value;
//   dynamic error;
//   dynamic info;

//   CouponModel({this.count, this.value, this.error, this.info});

//   CouponModel.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     value = json['value'] != null ? new Value.fromJson(json['value']) : null;
//     error = json['error'];
//     info = json['info'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     if (this.value != null) {
//       data['value'] = this.value.toJson();
//     }
//     data['error'] = this.error;
//     data['info'] = this.info;
//     return data;
//   }
// }

// class Value {
//   List<CouponContent> content;
//   Pageable pageable;
//   int totalElements;
//   int totalPages;
//   bool last;
//   int size;
//   int number;
//   Sort sort;
//   int numberOfElements;
//   bool first;
//   bool empty;

//   Value(
//       {this.content,
//         this.pageable,
//         this.totalElements,
//         this.totalPages,
//         this.last,
//         this.size,
//         this.number,
//         this.sort,
//         this.numberOfElements,
//         this.first,
//         this.empty});

//   Value.fromJson(Map<String, dynamic> json) {
//     if (json['content'] != null) {
//       content = new List<CouponContent>();
//       json['content'].forEach((v) {
//         content.add(new CouponContent.fromJson(v));
//       });
//     }
//     pageable = json['pageable'] != null
//         ? new Pageable.fromJson(json['pageable'])
//         : null;
//     totalElements = json['totalElements'];
//     totalPages = json['totalPages'];
//     last = json['last'];
//     size = json['size'];
//     number = json['number'];
//     sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
//     numberOfElements = json['numberOfElements'];
//     first = json['first'];
//     empty = json['empty'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.content != null) {
//       data['content'] = this.content.map((v) => v.toJson()).toList();
//     }
//     if (this.pageable != null) {
//       data['pageable'] = this.pageable.toJson();
//     }
//     data['totalElements'] = this.totalElements;
//     data['totalPages'] = this.totalPages;
//     data['last'] = this.last;
//     data['size'] = this.size;
//     data['number'] = this.number;
//     if (this.sort != null) {
//       data['sort'] = this.sort.toJson();
//     }
//     data['numberOfElements'] = this.numberOfElements;
//     data['first'] = this.first;
//     data['empty'] = this.empty;
//     return data;
//   }
// }

// class CouponContent {
//   String id;
//   AdminData adminData;
//   String code;
//   String name;
//   String description;
//   String type;
//   dynamic amount;
//   int maximumRedemptions;
//   dynamic customerId;
//   dynamic productId;
//   dynamic categoryId;
//   dynamic restriction;
//   Store store;
//   String image ;

//   CouponContent(
//       {this.id,
//         this.adminData,
//         this.code,
//         this.name,
//         this.description,
//         this.type,
//         this.amount,
//         this.maximumRedemptions,
//         this.customerId,
//         this.productId,
//         this.categoryId,
//         this.restriction,
//         this.store,
//         this.image});

//   CouponContent.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     adminData = json['adminData'] != null
//         ? new AdminData.fromJson(json['adminData'])
//         : null;
//     code = json['code'];
//     name = json['name'];
//     description = json['description'];
//     type = json['type'];
//     amount = json['amount'];
//     maximumRedemptions = json['maximumRedemptions'];
//     customerId = json['customerId'];
//     productId = json['productId'];
//     categoryId = json['categoryId'];
//     restriction = json['restriction'];
//     store = json['store'] != null ? new Store.fromJson(json['store']) : null;
//     image = json['image'] ;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.adminData != null) {
//       data['adminData'] = this.adminData.toJson();
//     }
//     data['code'] = this.code;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['type'] = this.type;
//     data['amount'] = this.amount;
//     data['maximumRedemptions'] = this.maximumRedemptions;
//     data['customerId'] = this.customerId;
//     data['productId'] = this.productId;
//     data['categoryId'] = this.categoryId;
//     data['restriction'] = this.restriction;
//     if (this.store != null) {
//       data['store'] = this.store.toJson();
//     }
//     data['image'] = this.image;
//     return data;
//   }
// }


// class Store {
//   String id;

//   Store({this.id});

//   Store.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     return data;
//   }
// }


// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) => CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
    CouponModel({
        this.count,
        this.value,
        this.error,
        this.info,
    });

    int count;
    Value value;
    dynamic error;
    dynamic info;

    factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        count: json["count"],
        value: Value.fromJson(json["value"]),
        error: json["error"],
        info: json["info"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "value": value.toJson(),
        "error": error,
        "info": info,
    };
}

class Value {
    Value({
        this.content,
        this.pageable,
        this.totalPages,
        this.totalElements,
        this.last,
        this.number,
        this.sort,
        this.size,
        this.numberOfElements,
        this.first,
        this.empty,
    });

    List<CouponContent> content;
    Pageable pageable;
    int totalPages;
    int totalElements;
    bool last;
    int number;
    Sort sort;
    int size;
    int numberOfElements;
    bool first;
    bool empty;

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        content: List<CouponContent>.from(json["content"].map((x) => CouponContent.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        size: json["size"],
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "last": last,
        "number": number,
        "sort": sort.toJson(),
        "size": size,
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
    };
}

class CouponContent {
    CouponContent({
        this.id,
        this.adminData,
        this.code,
        this.name,
        this.description,
        this.type,
        this.amount,
        this.maximumRedemptions,
        this.customerId,
        this.productId,
        this.categoryId,
        this.restriction,
        this.store,
        this.image,
        this.media,
    });

    String id;
    AdminData adminData;
    String code;
    String name;
    String description;
    String type;
    dynamic amount;
    int maximumRedemptions;
    dynamic customerId;
    dynamic productId;
    dynamic categoryId;
    dynamic restriction;
    Store store;
    String image;
    dynamic media;

    factory CouponContent.fromJson(Map<String, dynamic> json) => CouponContent(
        id: json["id"],
        adminData: AdminData.fromJson(json["adminData"] == null ? null : json["adminData"] ) ,
        code: json["code"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        amount: json["amount"],
        maximumRedemptions: json["maximumRedemptions"] == null ? null : json["maximumRedemptions"],
        customerId: json["customerId"],
        productId: json["productId"],
        categoryId: json["categoryId"],
        restriction: json["restriction"],
        store: Store.fromJson(json["store"]),
        image: json["image"] == null ? null : json["image"],
        media: json["media"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminData": adminData.toJson(),
        "code": code,
        "name": name,
        "description": description,
        "type": type,
        "amount": amount,
        "maximumRedemptions": maximumRedemptions == null ? null : maximumRedemptions,
        "customerId": customerId,
        "productId": productId,
        "categoryId": categoryId,
        "restriction": restriction,
        "store": store.toJson(),
        "image": image == null ? null : image,
        "media": media,
    };
}

class AdminData {
    AdminData({
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
    });

    String createdBy;
    DateTime createdOn;
    String updatedBy;
    DateTime updatedOn;

    factory AdminData.fromJson(Map<String, dynamic> json) => AdminData(
        createdBy: json["createdBy"],
        createdOn: DateTime.parse(json["createdOn"]),
        updatedBy: json["updatedBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
    );

    Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdOn": createdOn.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedOn": updatedOn.toIso8601String(),
    };
}

class Store {
    Store({
        this.id,
        this.adminData,
        this.name,
        this.rating,
        this.ratingCount,
    });

    String id;
    dynamic adminData;
    dynamic name;
    dynamic rating;
    dynamic ratingCount;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        adminData: json["adminData"],
        name: json["name"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminData": adminData,
        "name": name,
        "rating": rating,
        "ratingCount": ratingCount,
    };
}

class Pageable {
    Pageable({
        this.sort,
        this.offset,
        this.pageNumber,
        this.pageSize,
        this.paged,
        this.unpaged,
    });

    Sort sort;
    int offset;
    int pageNumber;
    int pageSize;
    bool paged;
    bool unpaged;

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    Sort({
        this.sorted,
        this.unsorted,
        this.empty,
    });

    bool sorted;
    bool unsorted;
    bool empty;

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        sorted: json["sorted"],
        unsorted: json["unsorted"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "sorted": sorted,
        "unsorted": unsorted,
        "empty": empty,
    };
}


