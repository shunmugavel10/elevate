// import 'package:dio/dio.dart';
// import 'package:farm_direct/model/coupon_model.dart';
// import 'package:farm_direct/network/apiClient.dart';
// import 'package:farm_direct/network/api_list.dart';
// import 'package:farm_direct/pages/common/size_colors.dart';
// import 'package:farm_direct/pages/common/textField.dart';
// import 'package:farm_direct/pages/common/toast_msg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:responsive_flutter/responsive_flutter.dart';


// class AddEditCoupons extends StatefulWidget {
//   final bool edit;
//   final CouponContent couponData;

//   const AddEditCoupons({Key key, this.edit, this.couponData}) : super(key: key);
//   @override
//   _AddEditCouponsState createState() => _AddEditCouponsState();
// }

// class _AddEditCouponsState extends State<AddEditCoupons> {

//   final _formKey = GlobalKey<FormState>();
//   TextEditingController codeController=TextEditingController();
//   TextEditingController nameController=TextEditingController();
//   TextEditingController descriptionController=TextEditingController();
//   TextEditingController typeController=TextEditingController();
//   TextEditingController amountController=TextEditingController();
//   TextEditingController maximumRedemptionsController =TextEditingController();
//   fill(){
//     codeController.text=widget.couponData.code??"";
//     nameController.text=widget.couponData.name??"";
//     descriptionController.text=widget.couponData.description??"";
//     typeController.text=widget.couponData.type??"";
//     amountController.text=widget.couponData.amount??"";
//     maximumRedemptionsController.text=widget.couponData.maximumRedemptions.toString()??"";
//   }

//   Future<CouponModel> addEditCouponNetwork(CouponContent couponData) async {
//     Response response;
//     try {
//       final _dio = apiClient();
//       await _dio.then((value) async {
//         response =await value.post(url_get_coupons,queryParameters: {
//           "code": codeController.text,
//           "name": codeController.text,
//           "description": descriptionController.text,
//           "type": typeController.text,
//           "maximumRedemptions": maximumRedemptionsController.text,
//           "customerId": couponData.customerId,
//           "productId": "",
//           "categoryId": "",
//           "store": {
//             "id": "4528a8ca-dab3-4be8-9e19-2784cca6ba3c"
//           },
//           "image": "",
//         });
//         if (response.statusCode == 200)
//           return CouponModel.fromJson(response.data);
//         else {
//           showtoast("Failed");
//         }
//       });
//     } catch (e) {
//       showtoast("Failed");
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     widget.edit?fill():null;
//   }
//   @override
//   Widget build(BuildContext context) {

//     TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
//         fontWeight: FontWeight.w500,color:Color(colorText1));
//     TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
//         fontWeight: FontWeight.w500,color:Colors.white);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.edit?"fd_editCoupons_title":"fd_addCoupons_title").tr(),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 textField(context, "fd_addCoupons_subtitle1", "fd_addCoupons_subtitle1",
//                     "fd_common_errorValidation", codeController),
//                 SizedBox(height: 20,),
//                 textField(context, "fd_addCoupons_subtitle2", "fd_addCoupons_subtitle2",
//                     "fd_common_errorValidation", nameController),
//                 SizedBox(height: 20,),
//                 textField(context, "fd_addCoupons_subtitle3", "fd_addCoupons_subtitle3",
//                     "fd_common_errorValidation", descriptionController),
//                 SizedBox(height: 20,),
//                 textField(context, "fd_addCoupons_subtitle4", "fd_addCoupons_subtitle4",
//                     "fd_common_errorValidation", typeController),
//                 SizedBox(height: 20,),
//                 textField(context, "fd_addCoupons_subtitle5", "fd_addCoupons_subtitle5",
//                     "fd_common_errorValidation", amountController),
//                 SizedBox(height: 20,),
//                 textField(context, "fd_addCoupons_subtitle6", "fd_addCoupons_subtitle6",
//                     "fd_common_errorValidation", maximumRedemptionsController),
//                 SizedBox(height: 30,),
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children:[

//                       // ignore: deprecated_member_use
//                       FlatButton(child: Text("fd_cancel_msg",style: _styleBody2_1,).tr(),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
//                             side: BorderSide(color: Color(secondary))),
//                         minWidth:ResponsiveFlutter.of(context).scale(120),
//                         height: ResponsiveFlutter.of(context).verticalScale(45),
//                         color: Colors.transparent,splashColor: Color(secondary),
//                         onPressed: (){
//                           Navigator.pop(context);
//                         },),
//                       // ignore: deprecated_member_use
//                       FlatButton(child: Text("fd_account_manage_savebutton",style: _styleBody2_2,).tr(),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         minWidth:ResponsiveFlutter.of(context).scale(120),
//                         height: ResponsiveFlutter.of(context).verticalScale(45),
//                         color: Color(secondary),splashColor: Colors.white,
//                         // onPressed: (){
//                         //   bool result= await postCouponData();
//                         //   if(result==true) {
//                         //     Navigator.pop(context);
//                         //   }
//                         // },
//                         ),
//                     ]
//                 ),
//                 SizedBox(height: 20,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
