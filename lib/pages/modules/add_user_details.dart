import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/add_multiple_images.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/common/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AddUser extends StatefulWidget {
  final String storeId;
  final String storeName;

  const AddUser({Key key, this.storeId, this.storeName}) : super(key: key);
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController nameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  bool loading=true;

  Future<bool> postUserData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.post(url_get_products,data: {

        });
        if (response.statusCode == 200) {
          return true;
        } else {
          showtoast("Failed");
          return true;
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
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
      resizeToAvoidBottomInset: true,
      body:loading?LinearProgressIndicator():SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 30,),
              textField(context, "fd_invoice_addMember_textfield1","fd_invoice_addMember_textfield1",
                  "fd_common_errorValidation", nameController),
              SizedBox(height: 15,),
              numberField(context, "fd_invoice_addMember_textfield2","fd_invoice_addMember_textfield2",
                  "fd_common_errorValidation", mobileController),
              SizedBox(height: 15,),
              textField(context, "fd_invoice_addMember_textfield3","fd_invoice_addMember_textfield3",
                  "fd_common_errorValidation", emailController),
              SizedBox(height: 15,),
              textField(context, "fd_invoice_addMember_textfield4","fd_invoice_addMember_textfield4",
                  "fd_common_errorValidation", addressController),
              SizedBox(height: 25,),
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
                       postUserData();
                      },),
                  ]
              ),
            ],
          ),),
      ),
    );
  }
}
