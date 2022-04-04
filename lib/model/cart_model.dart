
import 'package:farm_direct/model/product_model.dart';


class CartModel {
  CartModel({
    this.id,
    this.adminData,
    this.customerId,
    this.creatorType,
    this.orderLevelDiscount,
    this.items,
    this.subTotal,
    this.totalTax,
    this.total,
  });

  String id;
  AdminData adminData;
  String customerId;
  String creatorType;
  dynamic orderLevelDiscount;
  List<Item> items;
  SubTotal subTotal;
  SubTotal totalTax;
  SubTotal total;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    adminData: AdminData.fromJson(json["adminData"]),
    customerId: json["customerId"],
    creatorType: json["creatorType"],
    orderLevelDiscount: json["orderLevelDiscount"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    subTotal: SubTotal.fromJson(json["subTotal"]),
    totalTax: SubTotal.fromJson(json["totalTax"]),
    total: SubTotal.fromJson(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adminData": adminData.toJson(),
    "customerId": customerId,
    "creatorType": creatorType,
    "orderLevelDiscount": orderLevelDiscount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "subTotal": subTotal.toJson(),
    "totalTax": totalTax.toJson(),
    "total": total.toJson(),
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

class Item {
  Item({
    this.id,
    this.adminData,
    this.cartId,
    this.quantity,
    this.price,
    this.product,
    this.taxRatePercentage,
    this.discountAbsoluteValue,
    this.subTotal,
    this.total,
  });

  String id;
  AdminData adminData;
  String cartId;
  dynamic quantity;
  Price price;
  Product product;
  dynamic taxRatePercentage;
  dynamic discountAbsoluteValue;
  SubTotal subTotal;
  SubTotal total;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    adminData: AdminData.fromJson(json["adminData"]),
    cartId: json["cartId"],
    quantity: json["quantity"],
    price: Price.fromJson(json["price"]),
    product: Product.fromJson(json["product"]),
    taxRatePercentage: json["taxRatePercentage"],
    discountAbsoluteValue: json["discountAbsoluteValue"],
    subTotal: SubTotal.fromJson(json["subTotal"]),
    total: SubTotal.fromJson(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adminData": adminData.toJson(),
    "cartId": cartId,
    "quantity": quantity,
    "price": price.toJson(),
    "product": product.toJson(),
    "taxRatePercentage": taxRatePercentage,
    "discountAbsoluteValue": discountAbsoluteValue,
    "subTotal": subTotal.toJson(),
    "total": total.toJson(),
  };
}

class Price {
  Amount amount;
  MeasurementUnit measurementUnit;
  SalePrice salePrice;

  Price({this.amount, this.measurementUnit, this.salePrice});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['originalAmount'] != null
        ? new Amount.fromJson(json['originalAmount'])
        : null;
    measurementUnit = json['measurementUnit'] != null
        ? new MeasurementUnit.fromJson(json['measurementUnit'])
        : null;
    salePrice = json['salePrice'] != null
        ? new SalePrice.fromJson(json['salePrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['originalAmount'] = this.amount.toJson();
    }
    if (this.measurementUnit != null) {
      data['measurementUnit'] = this.measurementUnit.toJson();
    }
    if (this.salePrice != null) {
      data['salePrice'] = this.salePrice.toJson();
    }
    return data;
  }
}

class SubTotal {
  SubTotal({
    this.value,
    this.currency,
  });

  dynamic value;
  String currency;

  factory SubTotal.fromJson(Map<String, dynamic> json) => SubTotal(
    value: json["value"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "currency": currency,
  };
}


class Product {
  Product({
    this.id,
    this.name,
    this.thumbnail,
  });

  String id;
  String name;
  String thumbnail;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
  };
}
