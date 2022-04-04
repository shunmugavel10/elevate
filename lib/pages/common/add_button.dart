import 'package:dio/dio.dart';
import 'package:farm_direct/model/hive/cart_model_hive.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class AddButton extends StatefulWidget {

final ProductContent productData;
  const AddButton({Key key, this.productData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddButton();
  }
}

class _AddButton extends State<AddButton> {
  int count = 0;
  bool button=true;

  Future<void> addCart(ProductContent data,String id, int quantity) async {
    final cartData= Cart(productId: data.id,updateId: id,quantity: quantity.toString());
      final cartbox=Hive.box('cart');
      cartbox.put(data.id, cartData);
  }
  Future<void> patchCart(ProductContent data,String id,int quantity) async {
    final cartData= Cart(productId: data.id,updateId: id,quantity: quantity.toString());
    final cartbox=Hive.box('cart');
    cartbox.delete(data.id);
    cartbox.put(data.id, cartData);
  }

  Future<void> deleteCart(ProductContent data) async {
    final cartbox=Hive.box('cart');
    cartbox.delete(data.id);
  }

  Future<dynamic> postProductToCartNetwork(ProductContent productData,int count) async {
    //var cart_id= await get_cartID();
    print("test");
    print(productData.thumbnail.url);
    print(productData.unitPrices[0].originalAmount.value);
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response = await value.post(url_post_productToCart,
            data:
        {
          "cartId": "7b29417d-b7ef-11eb-8b62-bf16fe781934",
          "quantity": 1,
          "price": {
            "originalAmount": productData.unitPrices[0].originalAmount,
            "measurementUnit": productData.unitPrices[0].measurementUnit,
            "salePrice": productData.unitPrices[0].salePrice
          },
          "product": {
            "id": productData.id,
            "name": "productData.name",
            "thumbnail": productData.thumbnail.url
          }
        });
        if (response.statusCode == 200 ||response.statusCode == 201) {
          dynamic cartData= response.data;
          addProductToLocalDB(true,cartData["id"],count);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print("e");
      showtoast("Failed");
    }
  }
  Future<dynamic> patchProductToCartNetwork(ProductContent productData,String updateId,int count) async {
    //var cart_id= await get_cartID();

    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response = await value.put("$url_post_productToCart/$updateId", data:
            {
              "cartId": "7b29417d-b7ef-11eb-8b62-bf16fe781934",
              "quantity": count,
              "price": {
                "originalAmount": productData.unitPrices[0].originalAmount,
                "measurementUnit": productData.unitPrices[0].measurementUnit,
                "salePrice": productData.unitPrices[0].salePrice
              },
              "product": {
                "id": productData.id,
                "name": "productData.name",
                "thumbnail": productData.thumbnail.url
              }
            });
        if (response.statusCode == 200 ||response.statusCode == 201) {
          dynamic cartData= response.data;
          addProductToLocalDB(true,cartData["id"],count);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print("e");
      showtoast("Failed");
    }
  }

  addProductToLocalDB(bool val,String id,int count){
    val?addCart(widget.productData,id, count) :patchCart(widget.productData,id, count);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    // ..hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          'Item added to cart',),
            duration:Duration(milliseconds:600)));
      button=true;
  }


  Future<dynamic> deleteProductFromCartNetwork(ProductContent productData,String updateId,int count) async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.delete("$url_post_productToCart/$updateId");
        if (response.statusCode == 200) {
          removeProductFromLocalDB(count);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast("Failed");
    }
  }
  removeProductFromLocalDB(int count){
    deleteCart(widget.productData);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item removed from cart'),
            duration:Duration(milliseconds:600)));
      button=true;
  }

  @override
  Widget build(BuildContext context) {

    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w500,color:Color(button?secondary:colorText2));

    // ignore: deprecated_member_use
    return WatchBoxBuilder(box: Hive.box('cart'),
        builder: (context, cartBox) {
          final Cart cartItem = cartBox.get(widget.productData.id);
          if (cartItem != null) {
            count = int.parse(cartItem.quantity);
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Color(0xfff5f5f5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      if(button==true) {
                          button=false;
                        count--;
                        count == 0 ? deleteProductFromCartNetwork(widget.productData, cartItem.updateId, count) :
                        patchProductToCartNetwork(widget.productData, cartItem.updateId, count);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 8, 8, 8),
                      child: Icon(
                        FeatherIcons.minus,
                        size: ResponsiveFlutter.of(context).scale(10),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: Text(cartItem.quantity ?? "",
                        style: _styleBody2),
                  ),
                  InkWell(
                    onTap: () {
                      if(button==true) {
                          button=false;
                        count++;
                          patchProductToCartNetwork(widget.productData,cartItem.updateId,count);
                    }},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 6, 8),
                      child: Icon(
                        FeatherIcons.plus,
                        size: ResponsiveFlutter.of(context).scale(10),
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          else return InkWell(
                onTap: () {
                  if(button==true) {
                      button=false;
                    count++;
                  postProductToCartNetwork(widget.productData,count);
                }},
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Color(0xfff5f5f5))),
                  child: Text(
                      "ADD",
                      style: _styleBody2),
                ));
        });
  }
}
