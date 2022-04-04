import 'package:farm_direct/model/cart_model.dart';

class ProductModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  ProductModel({this.count, this.value, this.error, this.info});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  List<ProductContent> content;
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

  Value(
      {this.content,
        this.pageable,
        this.totalElements,
        this.totalPages,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.numberOfElements,
        this.first,
        this.empty});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<ProductContent>();
      json['content'].forEach((v) {
        content.add(new ProductContent.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
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
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
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

class ProductContent {
  String id;
  AdminData adminData;
  String categoryId;
  Name name;
  Name details;
  List<UnitPrices> unitPrices;
  bool inStock;
  String sku;
  Thumbnail thumbnail;
  String status;
  bool published;
  bool bestSeller;
  bool spotLight;
  bool onSale;
  Store store;

  ProductContent(
      {this.id,
        this.adminData,
        this.categoryId,
        this.name,
        this.details,
        this.unitPrices,
        this.inStock,
        this.sku,
        this.thumbnail,
        this.status,
        this.published,
        this.bestSeller,
        this.spotLight,
        this.onSale,
        this.store});

  ProductContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'] != null
        ? new AdminData.fromJson(json['adminData'])
        : null;
    categoryId = json['categoryId'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    details =
    json['details'] != null ? new Name.fromJson(json['details']) : null;
    if (json['unitPrices'] != null) {
      unitPrices = new List<UnitPrices>();
      json['unitPrices'].forEach((v) {
        unitPrices.add(new UnitPrices.fromJson(v));
      });
    }
    inStock = json['inStock'];
    sku = json['sku'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    status = json['status'];
    published = json['published'];
    bestSeller = json['bestSeller'];
    spotLight = json['spotLight'];
    onSale = json['onSale'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.adminData != null) {
      data['adminData'] = this.adminData.toJson();
    }
    data['categoryId'] = this.categoryId;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    if (this.unitPrices != null) {
      data['unitPrices'] = this.unitPrices.map((v) => v.toJson()).toList();
    }
    data['inStock'] = this.inStock;
    data['sku'] = this.sku;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    data['status'] = this.status;
    data['published'] = this.published;
    data['bestSeller'] = this.bestSeller;
    data['spotLight'] = this.spotLight;
    data['onSale'] = this.onSale;
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    return data;
  }
}

class Name {
  String english;

  Name({this.english});

  Name.fromJson(Map<String, dynamic> json) {
    english = json['english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english'] = this.english;
    return data;
  }
}

class UnitPrices {
  Amount originalAmount;
  String productId;
  MeasurementUnit measurementUnit;
  SalePrice salePrice;

  UnitPrices(
      {this.originalAmount,
        this.productId,
        this.measurementUnit,
        this.salePrice});

  UnitPrices.fromJson(Map<String, dynamic> json) {
    originalAmount = json['originalAmount'] != null
        ? new Amount.fromJson(json['originalAmount'])
        : null;
    productId = json['productId'];
    measurementUnit = json['measurementUnit'] != null
        ? new MeasurementUnit.fromJson(json['measurementUnit'])
        : null;
    salePrice = json['salePrice'] != null
        ? new SalePrice.fromJson(json['salePrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.originalAmount != null) {
      data['originalAmount'] = this.originalAmount.toJson();
    }
    data['productId'] = this.productId;
    if (this.measurementUnit != null) {
      data['measurementUnit'] = this.measurementUnit.toJson();
    }
    if (this.salePrice != null) {
      data['salePrice'] = this.salePrice.toJson();
    }
    return data;
  }
}

class Amount {
  int value;
  String currency;

  Amount({this.value, this.currency});

  Amount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['currency'] = this.currency;
    return data;
  }
}

class MeasurementUnit {
  double quantity;
  String unitCode;

  MeasurementUnit({this.quantity, this.unitCode});

  MeasurementUnit.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    unitCode = json['unitCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['unitCode'] = this.unitCode;
    return data;
  }
}

class SalePrice {
  Amount amount;

  SalePrice({this.amount});

  SalePrice.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] != null
        ? new Amount.fromJson(json['amount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['amount'] = this.amount.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String name;
  String url;
  dynamic contentType;
  List<String> images;
  dynamic videos;

  Thumbnail({this.name, this.url, this.contentType, this.images, this.videos});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    contentType = json['contentType'];
    images = json['images'].cast<String>();
    videos = json['videos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['contentType'] = this.contentType;
    data['images'] = this.images;
    data['videos'] = this.videos;
    return data;
  }
}

class Store {
  String id;
  Name name;
  String storeType;

  Store({this.id, this.name, this.storeType});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    storeType = json['storeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['storeType'] = this.storeType;
    return data;
  }
}

class Pageable {
  Sort sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool unpaged;

  Pageable(
      {this.sort,
        this.offset,
        this.pageNumber,
        this.pageSize,
        this.paged,
        this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['offset'] = this.offset;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool sorted;
  bool unsorted;
  bool empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}
