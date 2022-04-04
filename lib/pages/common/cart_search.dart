import 'package:badges/badges.dart';
import 'package:farm_direct/pages/invoice/cart_page.dart';
import 'package:farm_direct/pages/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'shared_preference.dart';

Widget search (BuildContext context){

  return Center(
    child: IconButton(
        icon: Icon(FeatherIcons.search),
        onPressed: (){
          showSearch(context: context, delegate: SearchProduct());
        }),
  );
}

Widget cart(BuildContext context) {

  // ignore: deprecated_member_use
  return WatchBoxBuilder(
      box: Hive.box('cart'),
      builder: (context, cartBox) {
        final cartLength=cartBox.values.length;
        return Badge(
          position: BadgePosition.topEnd(top: 3,end: 3),
          animationDuration: Duration(milliseconds: 300),
          animationType: BadgeAnimationType.slide,
          badgeContent: Text(cartLength.toString(),
            style: TextStyle(color: Colors.white,),
          ),
          child: Padding(
            padding:  EdgeInsets.only(right:cartLength.toString().length==1?0:9),
            child: IconButton(icon: Icon(FeatherIcons.shoppingCart),
                onPressed: () async {
              String userId=await getStoreId();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  CartPage(cartId: "7b29417d-b7ef-11eb-8b62-bf16fe781934",userId: userId,)));
            }),
          ),
        );
      });
}

showSnackbar(BuildContext context,String content){
  ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(content)));
}