import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/product_model.dart';

class OrderModel {
  int count;
  Value value;
  dynamic error;
  dynamic info;

  OrderModel({this.count, this.value, this.error, this.info});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  List<OrderContent> orderContent;
  Pageable pageable;
  bool last;
  int totalPages;
  int totalElements;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

  Value(
      {this.orderContent,
        this.pageable,
        this.last,
        this.totalPages,
        this.totalElements,
        this.size,
        this.number,
        this.sort,
        this.first,
        this.numberOfElements,
        this.empty});

  Value.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      // ignore: deprecated_member_use
      orderContent = new List<OrderContent>();
      json['content'].forEach((v) {
        orderContent.add(new OrderContent.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderContent != null) {
      data['content'] = this.orderContent.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable.toJson();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort.toJson();
    }
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}

class OrderContent {
  String id;
  AdminData adminData;
  String customerId;
  String type;
  String creatorType;
  String paymentType;
  List<Items> items;
  double orderLevelDiscount;
  dynamic shippingCost;
  dynamic orderDate;
  dynamic shipmentDate;
  dynamic deliveryMethod;
  dynamic notes;
  dynamic termsAndConditions;
  Amount subTotal;
  Amount totalTax;
  Amount total;
  String status;
  BillingAddress billingAddress;
  BillingAddress shippingAddress;
  Payment payment;
  dynamic shipments;
  dynamic vendorId;
  dynamic salesUserId;

  OrderContent(
      {this.id,
        this.adminData,
        this.customerId,
        this.type,
        this.creatorType,
        this.paymentType,
        this.items,
        this.orderLevelDiscount,
        this.shippingCost,
        this.orderDate,
        this.shipmentDate,
        this.deliveryMethod,
        this.notes,
        this.termsAndConditions,
        this.subTotal,
        this.totalTax,
        this.total,
        this.status,
        this.billingAddress,
        this.shippingAddress,
        this.payment,
        this.shipments,
        this.vendorId,
        this.salesUserId});

  OrderContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminData = json['adminData'] != null
        ? new AdminData.fromJson(json['adminData'])
        : null;
    customerId = json['customerId'];
    type = json['type'];
    creatorType = json['creatorType'];
    paymentType = json['paymentType'];
    if (json['items'] != null) {
      // ignore: deprecated_member_use
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    orderLevelDiscount = json['orderLevelDiscount'];
    shippingCost = json['shippingCost'];
    orderDate = json['orderDate'];
    shipmentDate = json['shipmentDate'];
    deliveryMethod = json['deliveryMethod'];
    notes = json['notes'];
    termsAndConditions = json['termsAndConditions'];
    subTotal = json['subTotal'] != null
        ? new Amount.fromJson(json['subTotal'])
        : null;
    totalTax = json['totalTax'] != null
        ? new Amount.fromJson(json['totalTax'])
        : null;
    total = json['total'] != null
        ? new Amount.fromJson(json['total'])
        : null;
    status = json['status'];
    billingAddress = json['billingAddress'] != null
        ? new BillingAddress.fromJson(json['billingAddress'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? new BillingAddress.fromJson(json['shippingAddress'])
        : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    shipments = json['shipments'];
    vendorId = json['vendorId'];
    salesUserId = json['salesUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.adminData != null) {
      data['adminData'] = this.adminData.toJson();
    }
    data['customerId'] = this.customerId;
    data['type'] = this.type;
    data['creatorType'] = this.creatorType;
    data['paymentType'] = this.paymentType;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['orderLevelDiscount'] = this.orderLevelDiscount;
    data['shippingCost'] = this.shippingCost;
    data['orderDate'] = this.orderDate;
    data['shipmentDate'] = this.shipmentDate;
    data['deliveryMethod'] = this.deliveryMethod;
    data['notes'] = this.notes;
    data['termsAndConditions'] = this.termsAndConditions;
    if (this.subTotal != null) {
      data['subTotal'] = this.subTotal.toJson();
    }
    if (this.totalTax != null) {
      data['totalTax'] = this.totalTax.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    data['status'] = this.status;
    if (this.billingAddress != null) {
      data['billingAddress'] = this.billingAddress.toJson();
    }
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    data['shipments'] = this.shipments;
    data['vendorId'] = this.vendorId;
    data['salesUserId'] = this.salesUserId;
    return data;
  }
}

class Items {
  int quantity;
  Price price;
  Product product;
  double taxRatePercentage;
  double discountAbsoluteValue;
  dynamic taxCode;
  dynamic itemTaxValues;
  Amount subTotal;
  dynamic discountTotal;
  dynamic taxTotal;
  Amount total;

  Items(
      {this.quantity,
        this.price,
        this.product,
        this.taxRatePercentage,
        this.discountAbsoluteValue,
        this.taxCode,
        this.itemTaxValues,
        this.subTotal,
        this.discountTotal,
        this.taxTotal,
        this.total});

  Items.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    taxRatePercentage = json['taxRatePercentage'];
    discountAbsoluteValue = json['discountAbsoluteValue'];
    taxCode = json['taxCode'];
    itemTaxValues = json['itemTaxValues'];
    subTotal = json['subTotal'] != null
        ? new Amount.fromJson(json['subTotal'])
        : null;
    discountTotal = json['discountTotal'];
    taxTotal = json['taxTotal'];
    total = json['total'] != null
        ? new Amount.fromJson(json['total'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['taxRatePercentage'] = this.taxRatePercentage;
    data['discountAbsoluteValue'] = this.discountAbsoluteValue;
    data['taxCode'] = this.taxCode;
    data['itemTaxValues'] = this.itemTaxValues;
    if (this.subTotal != null) {
      data['subTotal'] = this.subTotal.toJson();
    }
    data['discountTotal'] = this.discountTotal;
    data['taxTotal'] = this.taxTotal;
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    return data;
  }
}



class BillingAddress {
  String street;
  String city;
  String state;
  String country;
  String pincode;
  dynamic notes;
  dynamic village;
  dynamic mandal;
  dynamic district;
  dynamic latitude;
  dynamic longitude;
  String type;
  dynamic title;

  BillingAddress(
      {this.street,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.notes,
        this.village,
        this.mandal,
        this.district,
        this.latitude,
        this.longitude,
        this.type,
        this.title});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    notes = json['notes'];
    village = json['village'];
    mandal = json['mandal'];
    district = json['district'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['notes'] = this.notes;
    data['village'] = this.village;
    data['mandal'] = this.mandal;
    data['district'] = this.district;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    data['title'] = this.title;
    return data;
  }
}

class Payment {
  String paymentId;
  String status;
  String method;
  String paymentResponse;
  Amount paidAmount;
  dynamic remainingAmount;

  Payment(
      {this.paymentId,
        this.status,
        this.method,
        this.paymentResponse,
        this.paidAmount,
        this.remainingAmount});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    status = json['status'];
    method = json['method'];
    paymentResponse = json['paymentResponse'];
    paidAmount = json['paidAmount'] != null
        ? new Amount.fromJson(json['paidAmount'])
        : null;
    remainingAmount = json['remainingAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['method'] = this.method;
    data['paymentResponse'] = this.paymentResponse;
    if (this.paidAmount != null) {
      data['paidAmount'] = this.paidAmount.toJson();
    }
    data['remainingAmount'] = this.remainingAmount;
    return data;
  }
}

