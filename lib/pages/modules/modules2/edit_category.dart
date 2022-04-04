// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:farm_direct/model/category_model.dart';
// import 'package:farm_direct/model/product_model.dart';
// import 'package:farm_direct/network/apiClient.dart';
// import 'package:farm_direct/network/api_list.dart';
// import 'package:farm_direct/pages/common/add_multiple_images.dart';
// import 'package:farm_direct/pages/common/size_colors.dart';
// import 'package:farm_direct/pages/common/textField.dart';
// import 'package:farm_direct/pages/common/thumbnail_image.dart';
// import 'package:farm_direct/pages/common/toast_msg.dart';
// import 'package:farm_direct/pages/common/upload_doc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:responsive_flutter/responsive_flutter.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:path/path.dart' as p;

// class EditCategory extends StatefulWidget {
//   final CategoryContent categoryData;

//   const EditCategory({Key key, this.categoryData}) : super(key: key);
//   @override
//   _EditCategoryState createState() => _EditCategoryState();
// }

// class _EditCategoryState extends State<EditCategory> {

//   TextEditingController nameController=TextEditingController();
//   TextEditingController descriptionController=TextEditingController();
  
//   CategoryModel categoryData;
//   int imageUploading=0;
//   bool loading= false;
//   final picker = ImagePicker();
//   List<File> selectedImages=[];
//   List<File> thumnailImages=[];
//   List<String> selectedImagesUrl=[];
//   var selectedCategoryId,selectedCategoryName;
//   var doc=[];
//   List<Widget> tabTitleList=[Tab(text: tr("fd_addCategory_textfield6"),),Tab(text: tr("fd_addCategory_textfield5"),)];


//   getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     } else {
//       print('No image selected.');
//     }
//   }
//   setImages(){
//     doc.clear();
//     var fileName= p.basename(thumnailImages[0].path);
//     var fileName1= p.basenameWithoutExtension(thumnailImages[0].path);
//     var extension =  p.extension(thumnailImages[0].path);
//     var data={
//       "fileName": fileName,
//       "title": fileName1,
//       "contentType": "image/$extension",
//       "mimeType": "image/$extension",
//       "category": "CATEGORY",
//       "uploader": "971007a7-c42b-11eb-af49-9734f3d750f1"
//     };
//     doc.add(data);
//     for(int i=0;i<selectedImages.length;i++){
//       var fileName2= p.basename(selectedImages[i].path);
//       var fileName3= p.basenameWithoutExtension(selectedImages[i].path);
//       var extension1 =  p.extension(selectedImages[i].path);
//       var data1={
//         "fileName": fileName2,
//         "title": fileName3,
//         "contentType": "image/$extension1",
//         "mimeType": "image/$extension1",
//         "category": "CATEGORY",
//         "uploader": "971007a7-c42b-11eb-af49-9734f3d750f1"
//       };
//       doc.add(data1);
//       print("oop");
//     }
//     print(doc);
//   }

//   fill(){
//     setState(() {
//       nameController.text=widget.categoryData.name.english;
//       descriptionController.text=widget.categoryData.description.english;
      
//       selectedCategoryId=widget.categoryData.id;
//     });
//   }
//   Future<bool> editCategoryData() async {
//     Response response;
//     try {
//       final _dio = apiClient();
//       var data= _dio.then((value) async {
//         response =await value.put(url_get_category+"/"+widget.categoryData.id,data:{
//           "id":"e3bce84f-e9e6-11eb-9b35-df4c89e0707a",
//         "adminData":widget.categoryData.adminData,
        
//         "name":{"english": nameController.text},
//         "description":{"english": descriptionController.text},
//         "thumbnail":widget.categoryData.thumbnail,
//         "imageUrl": widget.categoryData.imageUrl,
//         "categorySEO":null,
//         "media":null},);
//         print(response.statusCode);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Navigator.pop(context);
//         } else {
//           showtoast("Failed");
//           return true;
//         }
//       });
//       return data;
//     } catch (e) {
//       showtoast("Failed1");
//     }
//   }

  

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // getCategoryNetwork();
//     fill();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
//         fontWeight: FontWeight.w500,color:Color(colorText1));
//     TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
//         fontWeight: FontWeight.w500,color:Colors.white);
//     TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
//         fontWeight: FontWeight.w900,color:Color(colorText2));

//     return Scaffold(
//       body:loading?LinearProgressIndicator():Container(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(height: 20,),
//               textField(context, "fd_addProduct_textfield1","fd_addProduct_textfield1",
//                   "fd_common_errorValidation", nameController),
//               SizedBox(height: 10,),
//               textField(context, "fd_addProduct_textfield2","fd_addProduct_textfield2",
//                   "fd_common_errorValidation", descriptionController),
              
//               SizedBox(height: 50,),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children:[
//                     // ignore: deprecated_member_use
//                     FlatButton(child: Text("fd_cancel_msg",style: _styleBody2_1,).tr(),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
//                           side: BorderSide(color: Color(secondary))),
//                       minWidth:ResponsiveFlutter.of(context).scale(120),
//                       height: ResponsiveFlutter.of(context).verticalScale(45),
//                       color: Colors.transparent,splashColor: Color(secondary),
//                       onPressed: (){
//                         Navigator.pop(context);
//                       },),
//                     // ignore: deprecated_member_use
//                     FlatButton(child: Text("fd_account_manage_savebutton",style: _styleBody2_2,).tr(),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       minWidth:ResponsiveFlutter.of(context).scale(120),
//                       height: ResponsiveFlutter.of(context).verticalScale(45),
//                       color: Color(secondary),splashColor: Colors.white,
//                       onPressed: ()async {
//                       setState(() {
//                         loading=true;
//                       });
//                       // await setImages();
//                       editCategoryData();
//                       },),
//                   ]
//               ),
//             ],
//           ),
//         ),),
//     );
//   }
// }
