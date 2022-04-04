import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/Pages/Authentication/forgot_password.dart';
import 'package:farm_direct/Pages/Authentication/language_selection.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/Pages/Authentication/location_page.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'signup_page.dart';


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameCon=TextEditingController();
  TextEditingController passwordCon=TextEditingController();

  signInNetwork() async {
    Response response;
    Dio dio = Dio();
    try {
       response = await dio.post('$baseUrl$url_post_signIn',
          data: {"userName": usernameCon.text,
            "password": passwordCon.text});
       print(response.requestOptions.path);
       if(response.statusCode==200){
         await saveStoreId(response.data["userId"]);
          saveToken(response.data["accessToken"],response.data["refreshToken"]);
         int lan = await getLanguage();
         List<String> add = await getAddress();
         lan==0?
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageSelection())):
         add[0]=="Select"?
         Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage())):
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
             LandingPage(address: add,)), (route) => false);
       }
       else {
         showtoast("Signin Failed");
       }
    } on SocketException catch (e) {
      showtoast("Network Failed");
    } on TimeoutException catch (e){
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
        fontWeight: FontWeight.w900,color:Color(colorText1 ));
    TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 1.0, fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 5.0, fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody2_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 1.0, fontWeight: FontWeight.w400,color:Color(colorText1));

    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom:8),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("fd_onboardingPage_msg_dont_have_an_account",style: _styleBody2_3,).tr(),
              SizedBox(width: 5,),
              GestureDetector(child: Text(tr("fd_onboardingPage_button2"),style: _styleBody1_1,),
                onTap: () async {
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
                      (context)=>SignUpPage()), (route) => false);
                },),
            ]),
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
                  SizedBox(height: orientation==Orientation.portrait?100:0,),
                  Text("fd_onboardingPage_msg_welcome_back",style: _styleHeader1,).tr(),
                  SizedBox(height: 20,),
                  Text("fd_onboardingPage_msg_signin_to_continue",style: _styleHeader3,).tr(),
                  SizedBox(height: 50,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("fd_onboardingPage_msg_username",style: _styleBody1,).tr(),
                      TextFormField(
                        controller: usernameCon,
                        cursorColor: Color(secondary),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style:_styleBody2_1,
                        decoration: InputDecoration(
                          hintText: "Username",
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
                            return "Please enter username";
                          }
                          return null;
                        },
                      ),
                    ],),
                  SizedBox(height: 40,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("fd_onboardingPage_msg_password",style: _styleBody1,).tr(),
                      TextFormField(
                        controller: passwordCon,
                        cursorColor: Color(secondary),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style:_styleBody2_2,
                        decoration: InputDecoration(
                          hintText: "Password",
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
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                    ],),
                  SizedBox(height:35,),
                  TextButton(
                      child: Text("fd_onboardingPage_msg_forgot_password",style: _styleBody1_1,).tr(),
                  onPressed: (){
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_password()));
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade,
                        child: ForgotPassword()));
                  },),
                  SizedBox(height: 15,),
                  // ignore: deprecated_member_use
                  FlatButton(child: Text("fd_onboardingPage_button1",style: _styleBody1_3,).tr(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(secondary))),
                    minWidth:MediaQuery.of(context).size.width,
                    height: ResponsiveFlutter.of(context).verticalScale(45),
                    color: Color(secondary),
                    onPressed: () async {
                      print("hi");
                      if(_formKey.currentState.validate()){
                        signInNetwork();
                        // List<String> add = await get_address();
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                        //     Landing_page(address: add,)), (route) => false);
                      }
                    },),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
