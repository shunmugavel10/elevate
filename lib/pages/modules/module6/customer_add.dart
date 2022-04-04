import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/customer_model.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as p;
import 'package:responsive_flutter/responsive_flutter.dart';


class AddCustomer extends StatefulWidget {
  const AddCustomer({Key key}) : super(key: key);
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController notesController=TextEditingController();
  TextEditingController deliveryInstructionController=TextEditingController();
  TextEditingController streetController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController districtController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController street1Controller=TextEditingController();
  TextEditingController city1Controller=TextEditingController();
  TextEditingController district1Controller=TextEditingController();
  TextEditingController state1Controller=TextEditingController();
  TextEditingController pincode1Controller=TextEditingController();
  TextEditingController country1Controller=TextEditingController();
  TextEditingController urlController=TextEditingController();
  bool locLoading=false,useSame=false;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deliveryInstructionsController = TextEditingController();
  List<String> customerTypeList=["ORGANIZATION", "INDIVIDUAL"];
  List<String> addressTypeList=["HOME","WORK"];
  var selectedAddressType,selectedAddressType1, selectedCustomerType;
  int imageUploading=0;
  bool loading=false;
  final picker = ImagePicker();
  List<File> selectedImages=[];
  List<String> selectedImagesUrl=[];
  List coordinates=["",""];
  var doc=[];
  List<File> thumnailImages=[];

  List<Widget> tabTitleList=[Tab(text: tr("fd_form_title21"),),Tab(text: tr("fd_form_title22"),)];

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //  postCustomerData();
    
  // }


  setImages(){
    // doc.clear();
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


  // ignore: missing_return
  Future<bool> postCustomerData() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.post(url_get_customers,data: {
          "name": { "english": nameController.text },
          "notes": { "english": descriptionController.text },
          "deliveryInstructions": {
            "english": deliveryInstructionsController.text
          },
          "type": selectedCustomerType.toString(),
          "billingAddress": {
            "street": { "english": streetController.text },
            "city": { "english": cityController.text },
            "state": { "english": stateController.text },
            "country": { "english": countryController.text },
            "pincode": pincodeController.text,
            "type": { "english": selectedAddressType.toString() }
          },
          "shippingAddress": {
            "street": { "english": useSame?streetController.text:street1Controller },
            "city": { "english": useSame?cityController.text:city1Controller },
            "state": { "english": useSame?stateController.text:state1Controller },
            "country": { "english": useSame?countryController.text :country1Controller},
            "pincode": useSame?pincodeController.text:pincode1Controller,
            "type": { "english": useSame?selectedAddressType.toString() : selectedAddressType1.toString() }
          },
          "bankDetails": {
            "routingNumber": "000",
            "accountNumber": "111",
            "type": "CHECKING",
            "directDeposit": true
          },
          "documents": doc
        });
        if (response.statusCode == 201 || response.statusCode == 201) {
          await uploadDocument2(response.data["uploadUrls"][0]["uploadUrl"], thumnailImages[0]);
          print('donee');
          for(int j=1;j<response.data["uploadUrls"].length;j++){
            await uploadDocument2(response.data["uploadUrls"][j]["uploadUrl"], selectedImages[j-1]);
             print('yes');
          }
          Navigator.pop(context,CustomerContent.fromJson(response.data));
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
      appBar: AppBar(
       
        centerTitle: true,
        elevation: 0,
        title: Text("fd_addCustomers_title").tr(),
      ),
      body: loading?LinearProgressIndicator():Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
              ThumbnailImage(selectedImages: thumnailImages),
              SizedBox(height: 20,),
              textField(context, "Name", "name", "please provide the neccessary details", nameController),
              SizedBox(height: 20,),
              textField(context, "Notes", "notes", "please provide the neccessary details", notesController),
              SizedBox(height: 20,),
              textField(context, "Delivery Instruction", "delivery instruction", "please provide the neccessary details", deliveryInstructionController),
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
                  hint: Text("Customer Type"),
                  underline: SizedBox(),
                  items:customerTypeList.map((String val) {
                    return DropdownMenuItem(
                      child: new Text(val),
                      value: customerTypeList.indexOf(val),
                    );
                  }).toList(),
                  onChanged: (var value) {
                    setState(() {
                      selectedCustomerType=value;
                    });
                  },
                  value: selectedCustomerType,),
              ),
              SizedBox(height: 20,),
              Text("Billing Address",style: _styleBody1,),
              SizedBox(height: 10,),
              Align(alignment: AlignmentDirectional.centerEnd,
                // ignore: deprecated_member_use
                child: FlatButton(child:locLoading?LinearProgressIndicator():
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Get the location",style: _styleBody2_2,
                      overflow: TextOverflow.ellipsis,
                      ),
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
              textField(context, "fd_form_title13", "fd_form_title13", "please provide the necessary details", streetController),
              SizedBox(height: 10,),
              textField(context, "fd_form_title16", "fd_form_title16", "please provide the necessary details",cityController ),
              SizedBox(height: 10,),
              textField(context, "fd_form_title17", "fd_form_title17", "please provide the necessary details",districtController ),
              SizedBox(height: 10,),
              textField(context, "fd_form_title18", "fd_form_title18", "please provide the necessary details",stateController ),
              SizedBox(height: 10,),
              numberField(context, "fd_form_title19", "fd_form_title19", "please provide the necessary details",pincodeController ),
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
                  hint: Text("Address Type"),
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
              Text("Shipping Address",style:_styleBody1),
              SizedBox(height: 5,),
              Row(children: [
                Text("Same as the billing address"),
                Checkbox(value: useSame, onChanged: (val){
                  setState(() {
                    useSame=val;
                  });
                })
              ],),
              SizedBox(height: 10,),
              useSame?SizedBox():
              Column(children: [
                textField(context, "fd_form_title13", "fd_form_title13", "please provide the necessary details", street1Controller),
                SizedBox(height: 10,),
                textField(context, "fd_form_title16", "fd_form_title16", "please provide the necessary details",city1Controller ),
                SizedBox(height: 10,),
                textField(context, "fd_form_title17", "fd_form_title17", "please provide the necessary details",district1Controller ),
                SizedBox(height: 10,),
                textField(context, "fd_form_title18", "fd_form_title18", "please provide the necessary details",state1Controller ),
                SizedBox(height: 10,),
                numberField(context, "fd_form_title19", "fd_form_title19", "please provide the necessary details",pincode1Controller ),
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
                    hint: Text("Address Type"),
                    underline: SizedBox(),
                    items:addressTypeList.map((String val) {
                      return DropdownMenuItem(
                        child: new Text(val),
                        value: addressTypeList.indexOf(val),
                      );
                    }).toList(),
                    onChanged: (var value) {
                      setState(() {
                        selectedAddressType1=value;
                      });
                    },
                    value: selectedAddressType1,),
                ),
              ],),
              SizedBox(height: 20,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
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
                            textField(context,"fd_form_title22","fd_form_title25","fd_common_errorValidation",urlController)
                          ]
                      ),

                    ),)
              ),
              SizedBox(height: 50,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    // ignore: deprecated_member_use
                    FlatButton(child: Text("fd_form_button2",style: _styleBody2_1,).tr(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color:Color(secondary))),
                      minWidth:120,
                      height: 45,
                      color: Colors.transparent,splashColor: Color(secondary),
                      onPressed: (){
                        Navigator.pop(context);
                      },),
                    // ignore: deprecated_member_use
                    FlatButton(child: Text("fd_form_button3",style: _styleBody2_2,).tr(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minWidth:120,
                      height: 45,
                      color: Color(secondary),splashColor: Colors.white,
                      onPressed: ()async {
                        setState(() {
                          loading=true;
                        });
                        await setImages();
                        postCustomerData();
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
