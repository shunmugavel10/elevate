import 'package:hive/hive.dart';
part 'favourites_model_hive.g.dart';



@HiveType(typeId: 1)
class Favourites extends HiveObject{
  Favourites({
    this.isFavourite,
    this.productId,
    this.updateId,
  });

  @HiveField(0)
  bool isFavourite;
  @HiveField(1)
  String productId;
  @HiveField(2)
  String updateId;

  factory Favourites.fromJson(Map<String, dynamic> json) => Favourites(
    isFavourite: json["is_favourite"],
    productId: json["productId"],
    updateId: json["updateId"]
  );

  Map<String, dynamic> toJson() => {
    "is_favourite":isFavourite,
    "productId": productId,
    "updateId": updateId
  };
}



