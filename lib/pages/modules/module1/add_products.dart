import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/add_multiple_images.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/thumbnail_image.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/common/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as p;

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {

  TextEditingController nameController=TextEditingController();
  TextEditingController detailsController=TextEditingController();
  TextEditingController originalPriceController=TextEditingController();
  TextEditingController salePriceController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  TextEditingController urlController=TextEditingController();
  CategoryModel categoryData;
  int imageUploading=0;
  bool loading=true;
  final picker = ImagePicker();
  List<File> selectedImages=[];
  List<File> thumnailImages=[];
  List<String> selectedImagesUrl=[];
  var selectedCategoryId,selectedCategoryName;
  var doc=[];
  List<Widget> tabTitleList=[Tab(text: tr("fd_addProduct_textfield6"),),Tab(text: tr("fd_addProduct_textfield5"),)];


  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }
  setImages(){
    doc.clear();
    var fileName= p.basename(thumnailImages[0].path);
    var fileName1= p.basenameWithoutExtension(thumnailImages[0].path);
    var extension =  p.extension(thumnailImages[0].path);
    var data={
      "fileName": fileName,
      "title": fileName1,
      "contentType": "image/$extension",
      "mimeType": "image/$extension",
      "category": "CATEGORY",
      "uploader": "971007a7-c42b-11eb-af49-9734f3d750f1"
    };
    doc.add(data);
    for(int i=0;i<selectedImages.length;i++){
      var fileName2= p.basename(selectedImages[i].path);
      var fileName3= p.basenameWithoutExtension(selectedImages[i].path);
      var extension1 =  p.extension(selectedImages[i].path);
      var data1={
        "fileName": fileName2,
        "title": fileName3,
        "contentType": "image/$extension1",
        "mimeType": "image/$extension1",
        "category": "CATEGORY",
        "uploader": "971007a7-c42b-11eb-af49-9734f3d750f1"
      };
      doc.add(data1);
      print("oop");
    }
    print(doc);
  }

  Future<bool> postProductData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.post(url_get_products,data:{
          "categoryId": selectedCategoryId,
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
          "inStock": true,
          "sku": "Chapathi1008",
          "status": "NEW",
          "published": true,
          "bestSeller": true,
          "spotLight": true,
          "onSale": true,
          "store": {
            "id": "a9de42ab-e9e5-11eb-9b35-cf21feca0da7",
            "name": {
              "english": "Raghu Breakfasts"
            },
            "storeType": "STORE"
          },
          "documents": doc
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          await uploadDocument2(response.data["uploadUrls"][0]["uploadUrl"], thumnailImages[0]);
          print('donee');
          for(int j=1;j<response.data["uploadUrls"].length;j++){
            await uploadDocument2(response.data["uploadUrls"][j]["uploadUrl"], selectedImages[j-1]);
          }
          
          
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

   getCategoryNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_category);
        if (response.statusCode == 200) {
          setState(() {
            categoryData= CategoryModel.fromJson(response.data);
            loading=false;
          });
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNetwork();
    
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
      appBar: AppBar(
       
        centerTitle: true,
        elevation: 0,
        title: Text("fd_addProducts_title").tr(),
      ),
      body:loading?LinearProgressIndicator():Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 16,),
             ThumbnailImage(selectedImages: thumnailImages,),
             SizedBox(height: 20,),
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text("fd_mainpage_3_title",style: _styleBody1,).tr(),
                  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width*0.6,
                  height: 40,
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Text("fd_mainpage_3_title").tr(),
                    underline: SizedBox(),
                    items:categoryData.content.map((CategoryContent val) {
                      return DropdownMenuItem(
                        child: new Text(val.name.english),
                        value: categoryData.content.indexOf(val),
                      );
                    }).toList(),
                    onChanged: (var value) {
                      setState(() {
                        selectedCategoryName=value;
                        selectedCategoryId=categoryData.content[value].id;
                      });
                    },
                    value: selectedCategoryName,),
                ),
              ]),
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
              SizedBox(height: 10,),
             Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: DefaultTabController(
                    length:2,
                    child: Scaffold(
                      appBar: new PreferredSize(
                        preferredSize: Size.fromHeight(60),
                        child: new Center(
                          child: new Container(
                            child: new SafeArea(
                              child: new TabBar(labelStyle: TextStyle(fontWeight:FontWeight.w700,color: Color(0XFF767676)),
                                  indicatorColor:Color(secondary),
                                  labelColor: Colors.black,
                                  labelPadding: EdgeInsets.only(bottom: 5),
                                  indicatorPadding: EdgeInsets.only(bottom: 15),
                                  unselectedLabelStyle: TextStyle(fontWeight:FontWeight.w500,color: Color(0XFF9E9E9E)),
                                  tabs: tabTitleList
                              ),
                            ),
                          ),
                        ),
                      ),
                      body: TabBarView(
                        // physics: NeverScrollableScrollPhysics(),
                          children: [
                            AddMultipleImages(selectedImages: selectedImages),
                            textField(context,"fd_addProduct_textfield5","fd_addProduct_textfield5","fd_common_errorValidation",urlController)
                          ]
                      ),

                    ),)
              ),
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
                      await setImages();
                      postProductData();
                      
                      },
                      ),
                  ]
              ),
            ],
          ),
        ),),
    );
  }
}
