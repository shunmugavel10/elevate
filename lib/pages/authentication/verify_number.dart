import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/Pages/Authentication/language_selection.dart';
import 'package:farm_direct/model/userAuth_model.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/Pages/Authentication/location_page.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class VerifyNumber extends StatefulWidget {
  final UserAuth userData;

  const VerifyNumber({Key key, this.userData}) : super(key: key);
  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController=TextEditingController();

  UserAuth userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData=widget.userData;
  }
  authVerifyNetwork() async {
    Response response;
    Dio dio = Dio();
    try {
      response = await dio.post('$baseUrl$url_post_authVerify',
          data: {
            "id": userData.id,
            "adminData": userData.adminData,
            "userName": userData.userName,
            "email": userData.email,
            "password": "123",
            "phone": userData.phone,
            "countryCode": userData.countryCode,
            "mfaUserId": userData.mfaUserId,
            "mfaToken": userData.mfaToken
          });
      if (response.statusCode == 200) {
        await saveStoreId(response.data["userId"]);
        await saveToken(response.data["accessToken"],response.data["refreshToken"]);
        int lan = await getLanguage();
        List<String> add = await getAddress();
        lan==0?
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageSelection())):
        add[0]=="Select"?
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage())):
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
            LandingPage(address: add,)), (route) => false);
      } else {
        showtoast("Verify Failed");
      }
    } on SocketException catch (e) {
      showtoast("Network Failed");
    } on TimeoutException catch (e) {
      showtoast("Timeout");
    }
  }
  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleHeader1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeaderXL),
        fontWeight: FontWeight.w900, color:Color(colorText1));
    TextStyle _styleHeader3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
        fontWeight: FontWeight.w600, color:Color(colorText2));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));
    TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 20.0, fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
       fontWeight: FontWeight.w600,color:Color(colorText2));
    TextStyle _styleBody2_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 1.0, fontWeight: FontWeight.w400,color:Color(colorText2));
    TextStyle _styleButton =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(secondary));

    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom:10),
        child: SizedBox(height: ResponsiveFlutter.of(context).verticalScale(22),
            child: Center(child: Image.asset("assets/images/nav_bar_logo/bottom_sheet.png"))),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,bottom: 40,),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: orientation==Orientation.portrait?70:0,),
                  Text("fd_onboardingPage_msg_verifying_your_mobilenumber",style: _styleHeader1,).tr(),
                  SizedBox(height: 20,),
                  Text("fd_onboardingPage_msg_code_sending_msg",style: _styleHeader3,).tr(),
                  Row(children: [
                    Text("+${userData.countryCode} ${userData.phone}",style: _styleHeader3,),
                    TextButton(onPressed:(){

                    }, child:Text("fd_onboardingPage_msg_change_number",style:_styleButton).tr(),)
                  ]),
                  SizedBox(height: 50,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("fd_onboardingPage_msg_enter_code",style: _styleBody1,).tr(),
                      TextFormField(
                        controller: codeController,
                        cursorColor: Color(secondary),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.numberWithOptions(),
                        style:_styleBody2_1,
                        decoration: InputDecoration(
                          hintText: "code",
                          hintStyle: _styleBody2_3,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green,width: 2,style: BorderStyle.solid),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width:1,style: BorderStyle.solid),
                          ),
                        ),
                        enableInteractiveSelection: true,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Please enter the valid code";
                          }
                          return null;
                        },
                      ),
                    ],),
                  SizedBox(height:35,),
                  // ignore: deprecated_member_use
                  FlatButton(child: Text("fd_onboardingPage_msg_verify",style: _styleBody1_3,).tr(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(secondary))),
                    minWidth:MediaQuery.of(context).size.width,
                    height: ResponsiveFlutter.of(context).verticalScale(45),
                    color: Color(secondary),
                    onPressed: () async {
                      // if(_formKey.currentState.validate()){
                      // }
                      authVerifyNetwork();
                    },),
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("fd_onboardingPage_msg_resend_code",style: _styleBody1_1,).tr(),
                      Text("1:20"+" "+tr("fd_onboardingPage_msg_min_left"),style: _styleBody2_2,)
                  ],),

                  SizedBox(height: 45,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
