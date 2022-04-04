import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/tab5/accountProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AddCategories extends StatefulWidget {
  @override
  _AddCategoriesState createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {

  TextEditingController nameController=TextEditingController();
  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<bool> postCategoryData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.post(url_get_category,data: {
          "name": {
            "english": nameController.text
          },
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

    return ChangeNotifierProvider(
      create: (context) =>AccountNotifier(false,false,null),
      child: Scaffold(
        body:Container(
          padding: EdgeInsets.all(16),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height:ResponsiveFlutter.of(context).scale(80),
                width: ResponsiveFlutter.of(context).scale(80),
                margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
                child: Consumer<AccountNotifier>(
                    builder:(context,data,child){
                      return Stack(children:[
                        Container(
                          width:ResponsiveFlutter.of(context).scale(75),
                          height: ResponsiveFlutter.of(context).scale(75),
                          child: ClipRRect(borderRadius: BorderRadius.circular(100),
                            child:data.imageEdit?
                            data.image==null?CircleAvatar(
                              radius: ResponsiveFlutter.of(context).scale(75),):
                            Image.file(data.image,fit: BoxFit.cover,)
                                : data.imageLoading?CircularProgressIndicator():
                            CircleAvatar(
                              radius: ResponsiveFlutter.of(context).scale(75),)
                          ),
                        ),
                        Align(alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8,right: 2),
                            child: GestureDetector(
                              onTap: ()async{
                                context.read<AccountNotifier>().updateImageEdit(true);
                                context.read<AccountNotifier>().updateImage(await getImage());
                              },
                              child: CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(14),
                                backgroundColor: Color(secondary),
                                child: Icon(FeatherIcons.edit2,color: Color(primaryWhite),
                                  size:ResponsiveFlutter.of(context).verticalScale(14),),),
                            ),
                          ),
                        ),
                        data.imageEdit?Align(alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8,right: 2),
                            child: GestureDetector(
                              onTap: ()async{
                                context.read<AccountNotifier>().updateImageEdit(false);
                              },
                              child: CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(14),
                                backgroundColor: Color(secondary),
                                child: Icon(FeatherIcons.x,color: Colors.white,
                                  size:ResponsiveFlutter.of(context).verticalScale(14),),),
                            ),
                          ),
                        ):SizedBox(),
                      ]);
                    }
                ),
              ),
              textField(context, "fd_all_categories_msg1","fd_all_categories_msg1",
                  "fd_all_categories_msg1_error", nameController),
              SizedBox(height: 20,),
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
                    onPressed: (){
                      postCategoryData();
                    },),
                ]
              ),
            ],
          ),),
      ),
    );
  }
}
