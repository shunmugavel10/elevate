import 'package:dio/dio.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/google_map.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController mobileController=TextEditingController();
  TextEditingController buildingNameController=TextEditingController();
  TextEditingController areaController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  TextEditingController landmarkController=TextEditingController();

  bool loading=true;
  int selectedAddressType=0;
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future<bool> postProfileAddress() async {
    Response response;
    try {
      String userId= await getStoreId();
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.put("$url_get_userProfile/$userId",data: {
          "addressList": [{
              "addressName":nameController.text,
              "mobile_number":mobileController.text,
              "buildingNo":buildingNameController.text,
              "area":areaController.text,
                "city":cityController.text,
                "state":stateController.text,
                "pincode":pincodeController.text,
                "landmark":landmarkController.text,
            "type":selectedAddressType
        }],
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

    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));
    TextStyle _styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 1.0, fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w700,color:Colors.white);


    return Scaffold(
      appBar: AppBar(
        title: Text("fd_account_manage_address",style: _styleBody2_1,).tr(),
        toolbarHeight: ResponsiveFlutter.of(context).verticalScale(40),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp,
            size: ResponsiveFlutter.of(context).scale(15),),
          onPressed: (){
            Navigator.pop(context);
          },),
      ),
      body:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Align(alignment: AlignmentDirectional.centerEnd,
                  // ignore: deprecated_member_use
                  child: FlatButton(child:loading?LinearProgressIndicator():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Icon(Icons.my_location_outlined,color: Colors.white,
                    size: ResponsiveFlutter.of(context).verticalScale(15),),
                    Text("fd_location_currentLocation_button",style: _styleBody3,
                    overflow: TextOverflow.ellipsis,).tr()
                  ],),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(secondary))),
                    height: ResponsiveFlutter.of(context).verticalScale(30),
                    minWidth: MediaQuery.of(context).size.width*0.2,
                    color: Color(secondary),
                    onPressed: () async {
                    setState(() {
                      loading=true;
                    });
                      List coordinates = await GoogleMapDisplay().createState().currentLocation();
                      List<String> address=[];
                      if(coordinates!=null){
                        List<Placemark> placemarks = await placemarkFromCoordinates(coordinates[0], coordinates[1]);
                        setState(() {
                          Placemark placeMark  = placemarks[0];
                          address.add(placeMark.locality);
                          address.add(placeMark.street);
                          address.add(placeMark.subLocality);
                          address.add(placeMark.subAdministrativeArea);
                          areaController.text="${placeMark.street} ${placeMark.locality}";
                          cityController.text=placeMark.subAdministrativeArea;
                          stateController.text=placeMark.administrativeArea;
                          pincodeController.text=placeMark.postalCode;
                          loading =false;
                        });
                        saveAddress(address);
                        }
                    },),
                ),
                SizedBox(height: 20,),
                textField(context, "fd_account_manage_address_name",
                    "fd_account_manage_address_name",
                    "fd_account_manage_address_name_error", nameController),
                SizedBox(height: 40,),
                textField(context, "fd_account_manage_address_mobile",
                    "fd_account_manage_address_mobile",
                    "fd_account_manage_address_mobile_error", mobileController),
                SizedBox(height:40,),
                textField(context, "fd_account_manage_address_buildingName",
                    "fd_account_manage_address_buildingName",
                    "fd_account_manage_address_buildingName_error", buildingNameController),
                SizedBox(height: 40,),
                textField(context, "fd_account_manage_address_area",
                    "fd_account_manage_address_area",
                    "fd_account_manage_address_area_error", areaController),
                SizedBox(height: 40,),
                textField(context, "fd_account_manage_address_city",
                    "fd_account_manage_address_city",
                    "fd_account_manage_address_city_error", cityController),
                SizedBox(height: 40,),
                textField(context, "fd_account_manage_address_state",
                    "fd_account_manage_address_state",
                    "fd_account_manage_address_state_error", stateController),
                SizedBox(height: 40,),
                numberField(context, "fd_account_manage_address_pincode",
                    "fd_account_manage_address_pincode",
                    "fd_account_manage_address_pincode_error", pincodeController),
                SizedBox(height: 40,),
                textField(context, "fd_account_manage_address_landmark",
                    "fd_account_manage_address_landmark",
                    "fd_account_manage_address_landmark", landmarkController),
                SizedBox(height: 40,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("fd_account_manage_address_addressType",style: _styleBody1,).tr(),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedAddressType=1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10,5,10,5),
                            decoration: BoxDecoration(
                                color: selectedAddressType==1?Color(secondary).withOpacity(0.5)
                                    :Colors.grey.shade300,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text("fd_account_home").tr(),),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedAddressType=2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10,5,10,5),
                            decoration: BoxDecoration(
                                color: selectedAddressType==2?Color(secondary).withOpacity(0.5)
                                    :Colors.grey.shade300,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text("fd_account_work").tr(),),
                        )
                      ],)
                  ],),
                SizedBox(height: 40,),
                // ignore: deprecated_member_use
                FlatButton(child: Text("fd_account_manage_address_savebutton",style: _styleBody1_3,).tr(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(secondary))),
                  minWidth:MediaQuery.of(context).size.width,
                  height: ResponsiveFlutter.of(context).verticalScale(45),
                  color: Color(secondary),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      bool result = await postProfileAddress();
                      if(result==true) {
                        Navigator.pop(context);
                      }
                    }
                  },),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
