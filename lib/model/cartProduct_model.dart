// import 'dart:convert';
// import 'package:farm_direct/model_classes/product_model.dart';
//
// //
// // class CartProductModel {
// //   CartProductModel({
// //     this.cartId,
// //     this.quantity,
// //     this.price,
// //     this.product,
// //   });
// //
// //   String cartId;
// //   int quantity;
// //   Price price;
// //   Product product;
// //
// //   factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
// //     cartId: json["cartId"],
// //     quantity: json["quantity"],
// //     price: Price.fromJson(json["price"]),
// //     product: Product.fromJson(json["product"]),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "cartId": cartId,
// //     "quantity": quantity,
// //     "price": price.toJson(),
// //     "product": product.toJson(),
// //   };
// // }
//
// class Price {
//   Price({
//     this.originalAmount,
//     this.measurementUnit,
//     this.salePrice,
//   });
//
//   Amount originalAmount;
//   MeasurementUnit measurementUnit;
//   SalePrice salePrice;
//
//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//     originalAmount: Amount.fromJson(json["originalAmount"]),
//     measurementUnit: MeasurementUnit.fromJson(json["measurementUnit"]),
//     salePrice: SalePrice.fromJson(json["salePrice"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "originalAmount": originalAmount.toJson(),
//     "measurementUnit": measurementUnit.toJson(),
//     "salePrice": salePrice.toJson(),
//   };
// }
//
// class Product {
//   Product({
//     this.id,
//     this.name,
//     this.thumbnail,
//   });
//
//   String id;
//   String name;
//   String thumbnail;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     thumbnail: json["thumbnail"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "thumbnail": thumbnail,
//   };
// }
