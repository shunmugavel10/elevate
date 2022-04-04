import 'package:hive/hive.dart';
part 'cart_model_hive.g.dart';



@HiveType(typeId: 0)
class Cart extends HiveObject{
  Cart({
    this.id,
    this.quantity,
    this.productId,
    this.updateId
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String quantity;
  @HiveField(2)
  String productId;
  @HiveField(3)
  String updateId;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    quantity: json["quantity"],
    productId: json["productId"],
    updateId: json["updateId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity":quantity,
    "productId": productId,
    "updateId":updateId
  };
}



//
// @HiveType(typeId: 0)
// class Cart extends HiveObject{
//   Cart({
//     this.id,
//     this.cartId,
//     this.quantity,
//     this.productId,
//     this.unitPrice,
//     this.taxRatePercentage,
//     this.discountAbsoluteValue,
//     this.subTotal,
//     this.discountTotal,
//     this.taxTotal,
//     this.total,
//   });
//
//   @HiveField(0)
//   String id;
//   @HiveField(1)
//   String cartId;
//   @HiveField(2)
//   String quantity;
//   @HiveField(3)
//   String productId;
//   @HiveField(4)
//   UnitPrice unitPrice;
//   @HiveField(5)
//   int taxRatePercentage;
//   @HiveField(6)
//   DiscountAbsoluteValue discountAbsoluteValue;
//   @HiveField(7)
//   DiscountAbsoluteValue subTotal;
//   @HiveField(8)
//   DiscountAbsoluteValue discountTotal;
//   @HiveField(9)
//   DiscountAbsoluteValue taxTotal;
//   @HiveField(10)
//   DiscountAbsoluteValue total;
//
//   factory Cart.fromJson(Map<String, dynamic> json) => Cart(
//     id: json["id"],
//     cartId: json["cartId"],
//     quantity: json["quantity"],
//     productId: json["productId"],
//     unitPrice: UnitPrice.fromJson(json["unitPrice"]),
//     taxRatePercentage: json["taxRatePercentage"],
//     discountAbsoluteValue: DiscountAbsoluteValue.fromJson(json["discountAbsoluteValue"]),
//     subTotal: DiscountAbsoluteValue.fromJson(json["subTotal"]),
//     discountTotal: DiscountAbsoluteValue.fromJson(json["discountTotal"]),
//     taxTotal: DiscountAbsoluteValue.fromJson(json["taxTotal"]),
//     total: DiscountAbsoluteValue.fromJson(json["total"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "cartId": cartId,
//     "quantity": quantity,
//     "productId": productId,
//     "unitPrice": unitPrice.toJson(),
//     "taxRatePercentage": taxRatePercentage,
//     "discountAbsoluteValue": discountAbsoluteValue.toJson(),
//     "subTotal": subTotal.toJson(),
//     "discountTotal": discountTotal.toJson(),
//     "taxTotal": taxTotal.toJson(),
//     "total": total.toJson(),
//   };
// }
//
// @HiveType(typeId: 1)
// class DiscountAbsoluteValue extends HiveObject{
//   DiscountAbsoluteValue({
//     this.value,
//     this.currency,
//   });
//
//   @HiveField(1)
//   int value;
//   @HiveField(2)
//   String currency;
//
//   factory DiscountAbsoluteValue.fromJson(Map<String, dynamic> json) => DiscountAbsoluteValue(
//     value: json["value"],
//     currency: json["currency"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "value": value,
//     "currency": currency,
//   };
// }
//
// @HiveType(typeId: 2)
// class UnitPrice extends HiveObject{
//   UnitPrice({
//     this.originalAmount,
//     this.salePrice,
//     this.measurementUnit,
//   });
//
//   @HiveField(1)
//   DiscountAbsoluteValue originalAmount;
//   @HiveField(2)
//   SalePrice salePrice;
//   @HiveField(3)
//   MeasurementUnit measurementUnit;
//
//   factory UnitPrice.fromJson(Map<String, dynamic> json) => UnitPrice(
//     originalAmount: DiscountAbsoluteValue.fromJson(json["originalAmount"]),
//     salePrice: SalePrice.fromJson(json["salePrice"]),
//     measurementUnit: MeasurementUnit.fromJson(json["measurementUnit"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "originalAmount": originalAmount.toJson(),
//     "salePrice": salePrice.toJson(),
//     "measurementUnit": measurementUnit.toJson(),
//   };
// }
//
// @HiveType(typeId: 3)
// class MeasurementUnit extends HiveObject {
//   MeasurementUnit({
//     this.quantity,
//     this.unitCode,
//   });
//
//   @HiveField(1)
//   int quantity;
//   @HiveField(2)
//   String unitCode;
//
//   factory MeasurementUnit.fromJson(Map<String, dynamic> json) => MeasurementUnit(
//     quantity: json["quantity"],
//     unitCode: json["unitCode"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "quantity": quantity,
//     "unitCode": unitCode,
//   };
// }
//
// @HiveType(typeId: 4)
// class SalePrice extends HiveObject{
//   SalePrice({
//     this.amount,
//     this.discountRate,
//     this.description,
//   });
//
//   @HiveField(1)
//   DiscountAbsoluteValue amount;
//   @HiveField(2)
//   int discountRate;
//   @HiveField(3)
//   String description;
//
//   factory SalePrice.fromJson(Map<String, dynamic> json) => SalePrice(
//     amount: DiscountAbsoluteValue.fromJson(json["amount"]),
//     discountRate: json["discountRate"],
//     description: json["description"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "amount": amount.toJson(),
//     "discountRate": discountRate,
//     "description": description,
//   };
// }
