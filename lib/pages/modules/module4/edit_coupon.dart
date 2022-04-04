import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/model/vendors_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class EditCoupons extends StatefulWidget {
  final CouponContent couponsData;

  const EditCoupons({Key key, this.couponsData}) : super(key: key);
  @override
  _EditCouponsState createState() => _EditCouponsState();
}

class _EditCouponsState extends State<EditCoupons> {

  TextEditingController codeController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  // TextEditingController salePriceController=TextEditingController();
  // TextEditingController quantityController=TextEditingController();
  bool loading=false;

  fill(){
    setState(() {
       codeController.text=widget.couponsData.code;
      nameController.text=widget.couponsData.name;
      descriptionController.text=widget.couponsData.description;
      // quantityController.text=widget.productData.unitPrices.first.measurementUnit.quantity.toString();
      // originalPriceController.text=widget.productData.unitPrices.first.originalAmount.value.toString();
      // salePriceController.text=widget.productData.unitPrices.first.salePrice.amount.value.toString();
    });
  }
  Future<bool> editCouponsData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.put(url_get_coupons+"/"+widget.couponsData.id,data:{
          "id": widget.couponsData.id,
          "adminData": widget.couponsData.adminData,
          "code": codeController.text,
	        "name": nameController.text,
	        "description": descriptionController.text,
	        "type": widget.couponsData.type,
	        "maximumRedemptions": widget.couponsData.maximumRedemptions,
	        "customerId": widget.couponsData.customerId,
	        "productId":widget.couponsData.productId,
	       "categoryId": widget.couponsData.categoryId,
        	"store": widget.couponsData.store,
          
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.pop(context, CouponContent.fromJson(response.data));
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
                  "fd_common_errorValidation", codeController),
              SizedBox(height: 20,),
              textField(context, "fd_addProduct_textfield1","fd_addProduct_textfield1",
                  "fd_common_errorValidation", nameController),
              SizedBox(height: 10,),
              textField(context, "fd_addProduct_textfield2","fd_addProduct_textfield2",
                  "fd_common_errorValidation", descriptionController),
              // SizedBox(height: 10,),
              // numberField(context, "fd_addProduct_textfield7","fd_addProduct_textfield7",
              //     "fd_common_errorValidation", quantityController),
              // SizedBox(height: 10,),
              // numberField(context, "fd_addProduct_textfield3","fd_addProduct_textfield3",
              //     "fd_common_errorValidation", originalPriceController),
              // SizedBox(height: 10,),
              // numberField(context, "fd_addProduct_textfield4","fd_addProduct_textfield4",
              //     "fd_common_errorValidation", salePriceController),
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
                      editCouponsData();
                      },),
                  ]
              ),
            ],
          ),
        ),),
    );
  }
}
