import 'package:dio/dio.dart';
import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/hive/cart_model_hive.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class CartAddButton extends StatefulWidget {
  final Item cartData;

  const CartAddButton({Key key, this.cartData}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AddButton();
  }
}

class _AddButton extends State<CartAddButton> {
  int count = 0;
  Future<void> patchCart(String data,String updateId, int quantity)  {
    final cartData= Cart(productId: data,updateId:updateId,quantity: quantity.toString());
    final cartbox=Hive.box('cart');
    cartbox.delete(data);
    cartbox.put(data, cartData);
  }
  Future<void> deleteCart(String data,) async {
    final cartbox=Hive.box('cart');
    cartbox.delete(data);

  }

  Future<Item> postProductToCartNetwork(Item productData,String updateId,int count,bool added) async {
    //var cart_id= await get_cartID();
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response = await value.put("$url_post_productToCart/$updateId", data:
        {
          "cartId": productData.cartId,
          "quantity": count,
          "price": {
            "originalAmount": productData.price.amount,
            "measurementUnit": productData.price.measurementUnit,
            "salePrice": productData.price.salePrice
          },
          "product": {
            "id": productData.id,
            "name": productData.product.name,
            "thumbnail": productData.product.thumbnail
          }
        });
        if (response.statusCode == 200 ||response.statusCode == 201) {
          addProductToLocalDB(updateId,count,added);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }
  addProductToLocalDB(String updateId,int count,bool added){
    patchCart(widget.cartData.product.id,updateId, count);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    // ..hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          added?'Item added to cart':'Item removed from cart',),
            duration:Duration(milliseconds:600)));
  }

  Future<Item> deleteProductFromCartNetwork(Item productData,String updateId,) async {
    //var cart_id= await get_cartID();
    Response response;
    try {
      final _dio = apiClient();
      await _dio.then((value) async {
        response = await value.delete("$url_post_productToCart/$updateId");
        if (response.statusCode == 200 ||response.statusCode == 201) {
          removeProductFromLocalDB(updateId);
        } else {
          showtoast("Failed");
        }
      });
    } catch (e) {
      showtoast("Failed");
    }
  }
  removeProductFromLocalDB(String updateId){
    count <1
        ? deleteCart(widget.cartData.product.id,)
        : patchCart(widget.cartData.product.id,updateId, count);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item removed from cart'),
            duration:Duration(milliseconds:600)));
  }

  @override
  Widget build(BuildContext context) {

    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(secondary));

    // ignore: deprecated_member_use
    return WatchBoxBuilder(box: Hive.box('cart'),
        builder: (context, cartBox) {
          final Cart cartItem = cartBox.get(widget.cartData.product.id);
          count=int.parse(cartItem.quantity);
          if (widget.cartData.quantity>0) {
            return Container(
              width: ResponsiveFlutter.of(context).scale(70),
              height: ResponsiveFlutter.of(context).verticalScale(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Color(0xfff5f5f5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                        count--;
                      count<1?deleteProductFromCartNetwork(widget.cartData,cartItem.updateId):
                      postProductToCartNetwork(widget.cartData,cartItem.updateId,count,false);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 8, 8, 8),
                      child: Icon(
                        FeatherIcons.minus,
                        size: ResponsiveFlutter.of(context).scale(12),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: Text(count.toString() ?? "",
                        style: _styleBody2),
                  ),
                  InkWell(
                    onTap: () {
                        count++;
                      postProductToCartNetwork(widget.cartData,cartItem.updateId,count,true);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 6, 8),
                      child: Icon(
                        FeatherIcons.plus,
                        size: ResponsiveFlutter.of(context).scale(12),
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          else return SizedBox(width: 2,height: 2,);
        });
  }
}
