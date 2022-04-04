import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/coupon_model.dart';
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

class AddCoupon extends StatefulWidget {
  @override
  _AddCouponState createState() => _AddCouponState();
}

class _AddCouponState extends State<AddCoupon> {
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController maximumRedemptionsController = TextEditingController();
  // TextEditingController urlController=TextEditingController();

  CouponModel couponData;
  int imageUploading = 0;
  bool loading = false;
  final picker = ImagePicker();
  // List<File> selectedImages=[];
  List<File> thumnailImages = [];
  // List<String> selectedImagesUrl=[];
  var doc;
  var selectedCouponType;
  List<String> couponTypeList = ["CUSTOMER", "PRODUCT", "STORE"];

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  setImages() {
    // doc.clear();
    var fileName = p.basename(thumnailImages[0].path);
    var fileName1 = p.basenameWithoutExtension(thumnailImages[0].path);
    var extension = p.extension(thumnailImages[0].path);
    doc = {
      "fileName": fileName,
      "title": fileName1,
      "contentType": "image/$extension",
      "mimeType": "image/$extension",
      "category": "CATEGORY",
      "uploader": "971007a7-c42b-11eb-af49-9734f3d750f1"
    };
    print(doc);
  }

  Future<bool> postCouponData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = _dio.then((value) async {
        response = await value.post(url_get_coupons, data: {
          "code": codeController.text,
          "name": nameController.text,
          "description": descriptionController.text,
          "type": selectedCouponType.toString(),
          "maximumRedemptions": maximumRedemptionsController.text,
          "customerId": "",
          "productId": "",
          "categoryId": "",
          "store": {"id": "4528a8ca-dab3-4be8-9e19-2784cca6ba3c"},
          "document": doc
        });
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          await uploadDocument2(
              response.data["uploadUrl"]["uploadUrl"], thumnailImages[0]);
          print('donee');

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
  Widget build(BuildContext context) {
    TextStyle _styleBody2_1 = TextStyle(
        fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,
        color: Color(colorText1));
    TextStyle _styleBody2_2 = TextStyle(
        fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,
        color: Colors.white);
    TextStyle _styleBody1 = TextStyle(
        fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,
        color: Color(colorText2));

    return Scaffold(
      body: loading
          ? LinearProgressIndicator()
          : Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    ThumbnailImage(
                      selectedImages: thumnailImages,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "fd_coupon_title",
                            style: _styleBody1,
                          ).tr(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(primaryGrey),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 40,
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("fd_app_title9").tr(),
                              underline: SizedBox(),
                              items: couponTypeList.map((String val) {
                                return DropdownMenuItem(
                                  child: new Text(val),
                                  value: couponTypeList.indexOf(val),
                                );
                              }).toList(),
                              onChanged: (var value) {
                                setState(() {
                                  selectedCouponType = value;
                                });
                              },
                              value: selectedCouponType,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    textField(
                        context,
                        "fd_addCoupons_subtitle1",
                        "fd_addCoupons_subtitle1",
                        "fd_common_errorValidation",
                        codeController),
                    SizedBox(
                      height: 10,
                    ),
                    textField(
                        context,
                        "fd_addCoupons_subtitle2",
                        "fd_addCoupons_subtitle2",
                        "fd_common_errorValidation",
                        nameController),
                    SizedBox(
                      height: 10,
                    ),
                    textField(
                        context,
                        "fd_addCoupons_subtitle3",
                        "fd_addCoupons_subtitle3",
                        "fd_common_errorValidation",
                        descriptionController),
                    SizedBox(
                      height: 10,
                    ),
                    numberField(
                        context,
                        "fd_addCoupons_subtitle6",
                        "fd_addCoupons_subtitle6",
                        "fd_common_errorValidation",
                        maximumRedemptionsController),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text(
                              "fd_cancel_msg",
                              style: _styleBody2_1,
                            ).tr(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Color(secondary))),
                            minWidth: ResponsiveFlutter.of(context).scale(120),
                            height:
                                ResponsiveFlutter.of(context).verticalScale(45),
                            color: Colors.transparent,
                            splashColor: Color(secondary),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text(
                              "fd_addCoupons_title",
                              style: _styleBody2_2,
                            ).tr(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minWidth: ResponsiveFlutter.of(context).scale(120),
                            height:
                                ResponsiveFlutter.of(context).verticalScale(45),
                            color: Color(secondary),
                            splashColor: Color(primaryWhite),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await setImages();
                              postCouponData();
                            },
                          ),
                        ]),
                  ],
                ),
              ),
            ),
    );
  }
}
