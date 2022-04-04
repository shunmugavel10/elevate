import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProducts extends StatefulWidget {
  final ProductContent productData;

  const EditProducts({Key key, this.productData}) : super(key: key);
  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {

  TextEditingController nameController=TextEditingController();
  TextEditingController detailsController=TextEditingController();
  TextEditingController originalPriceController=TextEditingController();
  TextEditingController salePriceController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  bool loading=false;

  fill(){
    setState(() {
      nameController.text=widget.productData.name.english;
      detailsController.text=widget.productData.details.english;
      quantityController.text=widget.productData.unitPrices.first.measurementUnit.quantity.toString();
      originalPriceController.text=widget.productData.unitPrices.first.originalAmount.value.toString();
      salePriceController.text=widget.productData.unitPrices.first.salePrice.amount.value.toString();
    });
  }
  Future<bool> editProductData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.put(url_get_products+"/"+widget.productData.id,data:{
          "id": widget.productData.id,
          "adminData": widget.productData.adminData,
          "categoryId": widget.productData.categoryId,
          "name": {
            "english": nameController.text
          },
          "details": {
            "english": detailsController.text
          },
          "unitPrices": [
            {
              "originalAmount": {
                "value": originalPriceController.text,
                "currency": "INR"
              },
              "measurementUnit": {
                "quantity": quantityController.text,
                "unitCode": "piece"
              },
              "salePrice": {
                "amount": {
                  "value": salePriceController.text,
                  "currency": "INR"
                }
              }
            }
          ],
          "inStock": widget.productData.inStock,
          "sku": widget.productData.sku,
          "thumbnail": widget.productData.thumbnail,
          "status": widget.productData.status,
          "published": widget.productData.published,
          "bestSeller": widget.productData.bestSeller,
          "spotLight": widget.productData.spotLight,
          "onSale": widget.productData.onSale,
          "store": widget.productData.store
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.pop(context, ProductContent.fromJson(response.data));
        } else {
          showtoast("Failed");
          return true;
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed1");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fill();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Colors.white);
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));

    return Scaffold(
      body:loading?LinearProgressIndicator():Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20,),
              textField(context, "fd_addProduct_textfield1","fd_addProduct_textfield1",
                  "fd_common_errorValidation", nameController),
              SizedBox(height: 10,),
              textField(context, "fd_addProduct_textfield2","fd_addProduct_textfield2",
                  "fd_common_errorValidation", detailsController),
              SizedBox(height: 10,),
              numberField(context, "fd_addProduct_textfield7","fd_addProduct_textfield7",
                  "fd_common_errorValidation", quantityController),
              SizedBox(height: 10,),
              numberField(context, "fd_addProduct_textfield3","fd_addProduct_textfield3",
                  "fd_common_errorValidation", originalPriceController),
              SizedBox(height: 10,),
              numberField(context, "fd_addProduct_textfield4","fd_addProduct_textfield4",
                  "fd_common_errorValidation", salePriceController),
              SizedBox(height: 50,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    // ignore: deprecated_member_use
                    FlatButton(child: Text("fd_cancel_msg",style: _styleBody2_1,).tr(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(secondary))),
                      minWidth:ResponsiveFlutter.of(context).scale(120),
                      height: ResponsiveFlutter.of(context).verticalScale(45),
                      color: Colors.transparent,splashColor: Color(secondary),
                      onPressed: (){
                        Navigator.pop(context);
                      },),
                    // ignore: deprecated_member_use
                    FlatButton(child: Text("fd_account_manage_savebutton",style: _styleBody2_2,).tr(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minWidth:ResponsiveFlutter.of(context).scale(120),
                      height: ResponsiveFlutter.of(context).verticalScale(45),
                      color: Color(secondary),splashColor: Color(primaryWhite),
                      onPressed: ()async {
                      setState(() {
                        loading=true;
                      });
                      await
                      editProductData();
                      },),
                  ]
              ),
            ],
          ),
        ),),
    );
  }
}
