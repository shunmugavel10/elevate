import 'package:dio/dio.dart';
import 'package:farm_direct/model/hive/favourites_model_hive.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'shared_preference.dart';
import 'toast_msg.dart';


Future<void> addFavourite({String productId, updateId}) async {
  final Favourites favouriteData= Favourites(productId:productId,
      updateId: updateId, isFavourite: true);
  final favouritebox=Hive.box('favourites');
  favouritebox.put(productId, favouriteData);
}
Future<void> removeFavourite({String productId}) async {
  final favouritebox=Hive.box('favourites');
  favouritebox.delete(productId);
}

class FavouriteButton extends StatefulWidget {
  final String productId,itemType;

  const FavouriteButton({Key key, this.productId, this.itemType}) : super(key: key);
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  Favourites data;

  postFavouritesNetwork({String productId}) async {
    Response response;
    bool liked=true;
    try {
      String userId= await getStoreId();
      final _dio = apiClient();
      liked = await _dio.then((value) async {
        response =await value.post(url_get_post_favouriteProduct,data:
        {
          "userId": userId,
          "itemId": productId,
          "itemType": widget.itemType
        }
        );
        if (response.statusCode == 201) {
          print("hii");
          var data =response.data["id"];
          addFavourite(productId: productId,updateId: data);
          return true;
        } else {
          showtoast("Failed");
          return false;
        }
      });
      return liked;
    } catch (e) {
      showtoast("Failed");
    }
  }

  removeFavouritesNetwork({String productId, updateId}) async {
    Response response;
    bool liked=false;
    try {
      final _dio = apiClient();
      liked = await _dio.then((value) async {
        response =await value.delete("$url_get_post_favouriteProduct/$updateId");
        if (response.statusCode == 200) {
          print("hii2");
          removeFavourite(productId: productId);
          return true;
        } else {
          showtoast("Failed");
          return false;
        }
      });
      return liked;
    } catch (e) {
      showtoast("Failed");
    }
  }


  @override
  Widget build(BuildContext context){
    bool isLike=false;
    // ignore: deprecated_member_use
    return WatchBoxBuilder(box: Hive.box('favourites'),
        builder: (context, favouriteBox) {
          isLike =favouriteBox.containsKey(widget.productId)?true:false;
          if(favouriteBox.containsKey(widget.productId)){
            data=favouriteBox.get(widget.productId);
          }
          return Container(
            height: ResponsiveFlutter.of(context).scale(25),
            width: ResponsiveFlutter.of(context).scale(25),
            child: LikeButton(
              onTap: onLikeButtonTapped,
              isLiked: isLike,
              animationDuration: Duration(milliseconds: 600),
              likeBuilder: (bool isLiked) {
                return isLiked ? Icon(Icons.favorite, color: Colors.red,) :
                Icon(Icons.favorite_border_outlined, color: Color(0xffD9D9D9),);
              },
              size: ResponsiveFlutter.of(context).scale(16),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          );
        }
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    isLiked ?removeFavouritesNetwork(productId: widget.productId, updateId:data.updateId)
    : postFavouritesNetwork(productId: widget.productId);
    return !isLiked;
  }
}
