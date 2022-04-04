import 'dart:io';
import 'package:dio/dio.dart';
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

class EditVendors extends StatefulWidget {
  final VendorContent vendorsData;

  const EditVendors({Key key, this.vendorsData}) : super(key: key);
  @override
  _EditVendorsState createState() => _EditVendorsState();
}

class _EditVendorsState extends State<EditVendors> {

  TextEditingController nameController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  // TextEditingController originalPriceController=TextEditingController();
  // TextEditingController salePriceController=TextEditingController();
  // TextEditingController quantityController=TextEditingController();
  bool loading=false;

  fill(){
    setState(() {
      nameController.text=widget.vendorsData.name.english;
      descriptionController.text=widget.vendorsData.description.english;
      // quantityController.text=widget.productData.unitPrices.first.measurementUnit.quantity.toString();
      // originalPriceController.text=widget.productData.unitPrices.first.originalAmount.value.toString();
      // salePriceController.text=widget.productData.unitPrices.first.salePrice.amount.value.toString();
    });
  }
  Future<bool> editVendorsData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.put(url_get_vendors+"/"+widget.vendorsData.id,data:{
          "id": widget.vendorsData.id,
          "adminData": widget.vendorsData.adminData,
          "categoryId": widget.vendorsData.category,
          "name": {
            "english": nameController.text
          },
          "description": {
            "english": descriptionController.text
          },
          "contacts": widget.vendorsData.contacts,
          "workingHour": widget.vendorsData.workingHour,
          "thumbnail": widget.vendorsData.thumbnail,
          "billingAddress": widget.vendorsData.billingAddress,
          "shippingAddress": widget.vendorsData.shippingAddress,
          "addresses": widget.vendorsData.addresses,
          "notes": widget.vendorsData.notes,
          "deliveryInstructions": widget.vendorsData.deliveryInstructions,
          "kycStatus": widget.vendorsData.kycStatus,
          "onlineStatus": widget.vendorsData.onlineStatus,
          "bankAccount": widget.vendorsData.bankAccount,
          "location": widget.vendorsData.location,
          "media": widget.vendorsData.media    
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.pop(context, VendorContent.fromJson(response.data));
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
                      editVendorsData();
                      },),
                  ]
              ),
            ],
          ),
        ),),
    );
  }
}
