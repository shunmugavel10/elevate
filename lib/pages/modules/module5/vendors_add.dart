import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/vendors_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/add_multiple_images.dart';
import 'package:farm_direct/pages/common/google_map.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/thumbnail_image.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/common/upload_doc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class AddVendors extends StatefulWidget {
  const AddVendors({Key key}) : super(key: key);

  @override
  _AddVendorsState createState() => _AddVendorsState();
}

class _AddVendorsState extends State<AddVendors> {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressNameController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
  TextEditingController workPhoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController buildingNameController=TextEditingController();
  TextEditingController streetController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController districtController=TextEditingController();
  TextEditingController villageController=TextEditingController();
  TextEditingController mandalController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController landmarkController=TextEditingController();
  TextEditingController urlController=TextEditingController();


  bool locLoading=false;
  List<String> categoryList=["FPO","MFPO"];
  List<String> addressTypeList=["OFFICE","HOME"];
  var selectedCategory,selectedAddressType;
  int imageUploading=0;
 bool loading=false;
  final picker = ImagePicker();
  List<File> thumnailImages=[];
  List<File> selectedImages=[];
  List<String> selectedImagesUrl=[];
  TimeOfDay _time=TimeOfDay.now();
  List <String> startTime= ["","","","","","","",];
  List <String> endTime= ["","","","","","","",];
  List coordinates=["",""];
  var doc=[];

  //  List<Widget> tabTitleList=[Tab(text: tr("fd_addProduct_textfield6"),),Tab(text: tr("fd_addProduct_textfield5"),)];

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
    // for(int i=0;i<selectedImages.length;i++){
    //   var fileName2= p.basename(selectedImages[i].path);
    //   var fileName3= p.basenameWithoutExtension(selectedImages[i].path);
    //   var extension1 =  p.extension(selectedImages[i].path);
    //   var data1={
    //     "fileName": fileName2,
    //     "title": fileName3,
    //     "contentType": "image/$extension1",
    //     "mimeType": "image/$extension1",
    //     "category": "CATEGORY",
    //     "uploader": "971007a7-c42b-11eb-af49-9734f3d750f1"
    //   };
    //   doc.add(data1);
    //   print("oop");
    // }
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

  selecttime(int index,bool isStartTime)async{
    List _tym=[];
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (picked != null) {
      // _tym.add(localizations.formatHour(picked,alwaysUse24HourFormat: false));//
      // _tym.add(localizations.formatMinute(picked));
      _tym.add(localizations.formatTimeOfDay(picked));
      if(isStartTime==true){
        setState(() {
          startTime[index]=(_tym[0].toString());
        });
      }
      else{
        setState(() {
          endTime[index]=(_tym[0].toString());
        });
      }
    }
  }
  Future<bool> postVendorsData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.post(url_get_vendors,data:(
         
          
          {
            
         
            "name": {
              "english": nameController.text
            },
            "description": {
              "english": descriptionController.text
            },
            "addresses": [
              {
                "name": addressNameController.text,
                "street": { "english": streetController.text },
                "city": { "english": cityController.text },
                "state": { "english": stateController.text },
                "notes": {"english": landmarkController.text},
                "village": {"english": villageController.text},
                "mandal": {"english": mandalController.text},
                "district": {"english": districtController.text},
                "country": { "english": countryController.text },
                "pincode": pincodeController.text,
                "type": { "english": selectedAddressType.toString() },
                "latitude": coordinates[0],
                "longitude": coordinates[1]
              }
            ],
            "category": {
              "english": selectedCategory.toString()
            },
            "workingHour": {
              "en_US": [
                { "day": "Monday", "hours": "${startTime[0]} to ${endTime[0]}" },
                { "day": "Tuesday", "hours": "${startTime[1]} to ${endTime[1]}" },
                { "day": "Wednesday", "hours": "${startTime[2]} to ${endTime[2]}" },
                { "day": "Thursday", "hours": "${startTime[3]} to ${endTime[3]}" },
                { "day": "Friday", "hours": "${startTime[4]} to ${endTime[4]}" },
                { "day": "Saturday", "hours": "${startTime[5]} to ${endTime[5]}" },
                { "day": "Sunday", "hours": "${startTime[6]} to ${endTime[6]}" }
              ]
            },
            "documents": doc
          }
        ));
        print(response.statusCode);
        
        if (response.statusCode == 200 || response.statusCode == 201) {
          await uploadDocument2(response.data["uploadUrls"][0]["uploadUrl"], thumnailImages[0]);
          print('donee');
          // for(int j=1;j<response.data["uploadUrls"].length;j++){
          //  await uploadDocument2(response.data["uploadUrls"][j]["uploadUrl"], selectedImages[j-1]);
          // }
          Navigator.pop(context, VendorContent.fromJson(response.data));
        } else {
          showtoast("Failed1");
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
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText1));
        TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Colors.white);
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/images/nav_bar_logo/homeal.png",
            height: ResponsiveFlutter.of(context).verticalScale(28),
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        title: Text("fd_addVendors_title").tr(),
      ),
      body: loading?LinearProgressIndicator():Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
               ThumbnailImage(selectedImages: thumnailImages,),
              SizedBox(height: 20,),
              textField(context, "fd_form_title1", "fd_form_title1", "please provide the neccessary details", nameController),
              SizedBox(height: 20,),
              textField(context, "fd_form_title2", "fd_form_title2", "please provide the neccessary details", descriptionController),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text("fd_form_title3").tr(),
                  underline: SizedBox(),
                  items:categoryList.map((String val) {
                    return DropdownMenuItem(
                      child: new Text(val),
                      value: categoryList.indexOf(val),
                    );
                  }).toList(),
                  onChanged: (var value) {
                    setState(() {
                      selectedCategory=value;
                    });
                  },
                  value: selectedCategory,),
              ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[ Text("fd_form_title4",style: _styleBody1,).tr(),
              TextButton(child:Text("fd_form_button1").tr(),onPressed: (){
                for(int i=1;i<7;i++){
                  startTime[i]=startTime[0];
                  endTime[i]=endTime[0];
                }
                setState(() {

                });
              },)
              ]),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                SizedBox(width: 100,
                    child: Text("fd_form_title5",style: _styleBody1,).tr()),
                GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[0],style: _styleBody1,),),),
                onTap: (){
                  selecttime(0, true);
                },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[0],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(0, false);
                    },),
              ],),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                      child: Text("fd_form_title6",style: _styleBody1,).tr()),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[1],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(1, true);
                    },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[1],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(1, false);
                    },),

                ],),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                      child: Text("fd_form_title7",style: _styleBody1).tr()),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[2],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(2, true);
                    },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[2],style:  _styleBody1,),),),
                    onTap: (){
                      selecttime(2, false);
                    },),
                ],),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                      child: Text("fd_form_title8",style: _styleBody1,).tr()),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[3],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(3, true);
                    },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[3],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(3, false);
                    },),
                ],),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                      child: Text("fd_form_title9",style: _styleBody1,).tr()),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[4],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(4, true);
                    },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[4],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(4, false);
                    },),
                ],),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                      child: Text("fd_form_title10",style: _styleBody1,).tr()),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[5],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(5, true);
                    },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[5],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(5, false);
                    },),
                ],),
              SizedBox(height: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                      child: Text("fd_form_title11",style: _styleBody1,).tr()),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(startTime[6],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(6, true);
                    },),
                  GestureDetector(child: Card(child: Container(height: 45,width: 100,
                    alignment:Alignment.center, child: Text(endTime[6],style: _styleBody1,),),),
                    onTap: (){
                      selecttime(6, false);
                    },),
                ],),
              SizedBox(height: 20,),
              Align(alignment: AlignmentDirectional.centerEnd,
                // ignore: deprecated_member_use
                child: FlatButton(child:locLoading?LinearProgressIndicator():
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("fd_location_currentLocation_button",style: _styleBody1.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,).tr(),
                    Icon(Icons.my_location_outlined,color: Colors.white,
                        size:15),
                  ],),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(secondary))),
                  height: 30,
                  minWidth: MediaQuery.of(context).size.width*0.2,
                  color: Color(secondary),
                  onPressed: () async {
                    if(locLoading==false){
                      setState(() {
                        locLoading=true;
                      });
                     coordinates = await GoogleMapDisplay().createState().currentLocation();

                      List<Placemark> placemarks = await placemarkFromCoordinates(coordinates[0], coordinates[1]);
                      setState(() {
                        Placemark placeMark  = placemarks[0];
                        streetController.text="${placeMark.street} ${placeMark.locality}";
                        cityController.text=placeMark.subLocality;
                        districtController.text=placeMark.subAdministrativeArea;
                        stateController.text=placeMark.administrativeArea;
                        pincodeController.text=placeMark.postalCode;
                        locLoading =false;
                      });
                    }
                  },),
              ),
              SizedBox(height: 10,),
              textField(context, "fd_form_title12", "fd_form_title12", "fd_common_errorValidation",addressNameController ),
              SizedBox(height: 10,),
              textField(context, "fd_form_title13", "fd_form_title13", "fd_common_errorValidation", streetController),
              SizedBox(height: 10,),
              textField(context, "fd_form_title14", "fd_form_title14", "fd_common_errorValidation", villageController),
              SizedBox(height: 10,),
              textField(context, "fd_form_title15", "fd_form_title15", "fd_common_errorValidation", mandalController),
              SizedBox(height: 10,),
              textField(context, "fd_form_title16", "fd_form_title16", "fd_common_errorValidation",cityController ),
              SizedBox(height: 10,),
              textField(context, "fd_form_title17", "fd_form_title17", "fd_common_errorValidation",districtController ),
              SizedBox(height: 10,),
              textField(context, "fd_form_title18", "fd_form_title18", "fd_common_errorValidation",stateController ),
              SizedBox(height: 10,),
              numberField(context, "fd_form_title19", "fd_form_title19", "fd_common_errorValidation",pincodeController ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text("fd_form_title20").tr(),
                  underline: SizedBox(),
                  items:addressTypeList.map((String val) {
                    return DropdownMenuItem(
                      child: new Text(val),
                      value: addressTypeList.indexOf(val),
                    );
                  }).toList(),
                  onChanged: (var value) {
                    setState(() {
                      selectedAddressType=value;
                    });
                  },
                  value: selectedAddressType,),
              ),
              SizedBox(height: 20,),
              // Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 220,
              //     child: DefaultTabController(
              //       length:2,
              //       child: Scaffold(
              //         appBar: new PreferredSize(
              //           preferredSize: Size.fromHeight(60),
              //           child: new Center(
              //             child: new Container(
              //               child: new SafeArea(
              //                 child: new TabBar(labelStyle: TextStyle(fontWeight:FontWeight.w700,color: Color(0XFF767676)),
              //                     indicatorColor:Color(secondary),
              //                     labelColor: Colors.black,
              //                     labelPadding: EdgeInsets.only(bottom: 5),
              //                     indicatorPadding: EdgeInsets.only(bottom: 15),
              //                     unselectedLabelStyle: TextStyle(fontWeight:FontWeight.w500,color: Color(0XFF9E9E9E)),
              //                     tabs: tabTitleList
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         body: TabBarView(
              //           // physics: NeverScrollableScrollPhysics(),
              //             children: [
              //               AddMultipleImages(selectedImages: selectedImages),
              //               textField(context,"fd_addProduct_textfield5","fd_addProduct_textfield5","fd_common_errorValidation",urlController)
              //             ]
              //         ),

              //       ),)
              // ),
              // SizedBox(height: 50,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    // ignore: deprecated_member_use
                    FlatButton(child: Text("fd_cancel_msg",style: _styleBody1.copyWith(color: Color(secondary)),).tr(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(secondary))),
                      minWidth:120,
                      height: 45,
                      color: Colors.transparent,splashColor: Color(secondary),
                      onPressed: (){
                        Navigator.pop(context);
                      },),
                    // ignore: deprecated_member_use
                    FlatButton(child: Text("fd_account_manage_savebutton",style: _styleBody2_2).tr(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minWidth:120,
                      height: 45,
                      color: Color(secondary),splashColor: Color(primaryWhite),
                      onPressed: ()async {
                      setState(() {
                        loading=true;
                      });
                        await setImages();
                          postVendorsData();
                      },),
                  ]
              ),
              SizedBox(height: 16,)
            ],
          ),
        ),
      ),
    );
  }
}


