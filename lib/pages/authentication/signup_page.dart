import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/model/userAuth_model.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/Pages/Authentication/signin_page.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'verify_number.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
TextEditingController nameController=TextEditingController();
TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController mobileNoController=TextEditingController();
  File _image;
  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image= File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  signUpNetwork() async {
    Response response;
    Dio dio = Dio();
    try {
      response = await dio.post('$baseUrl$url_post_signUp',
          options: Options(responseType: ResponseType.json),
          data: {
            "userName": nameController.text,
            "email": emailController.text,
            "phone": mobileNoController.text,
            "pwdHash": passwordController.text,
            "countryCode": "91"
          });
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyNumber(
                      userData: UserAuth.fromJson(response.data),)));
      } else {
        showtoast("Signup Failed");
      }
    } on SocketException catch (e) {
      showtoast("Network Failed");
    } on TimeoutException catch (e) {
      showtoast("Timeout");
    }
  }

  @override
Widget build(BuildContext context) {

    var _width=MediaQuery.of(context).size.width;
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
      letterSpacing: 1.0, fontWeight: FontWeight.w600,color:Color(colorText1));
  TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      letterSpacing: 5.0, fontWeight: FontWeight.w600,color:Color(colorText1));
  TextStyle _styleBody2_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      letterSpacing: 1.0, fontWeight: FontWeight.w400,color:Color(colorText2));


  return Scaffold(
    bottomSheet:Container(padding: const EdgeInsets.only(bottom:8,top: 5),
      child: Container(
        height: ResponsiveFlutter.of(context).verticalScale(22)+
        ResponsiveFlutter.of(context).fontSize(5),
        child: Column(
          children:[
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text("fd_onboardingPage_msg_have_an_account",style: _styleBody2_3,).tr(),
                SizedBox(width: 5,),
                GestureDetector(child: Text(tr("fd_onboardingPage_button1"),style: _styleBody1_1,),
                  onTap: () async {
                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
                        (context)=>SignInPage()), (route) => false);
                  },),
              ]),
            SizedBox(height: ResponsiveFlutter.of(context).fontSize(1.3),),
            SizedBox(height: ResponsiveFlutter.of(context).verticalScale(28),
                child: Center(child: Image.asset("assets/images/nav_bar_logo/homeal.png"))),
        ]),
      ),
    ),
      body: SafeArea(
          child:Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key:_formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: orientation==Orientation.portrait?50:0,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                SizedBox(width: _width*0.6,
                                  child: Text("fd_onboardingPage_msg_welcome_user",style: _styleHeader1, maxLines: 2,
                                  overflow: TextOverflow.ellipsis,).tr(),
                                ),
                                GestureDetector(
                                  child: Container(
                                    width:ResponsiveFlutter.of(context).scale(80),
                                    height: ResponsiveFlutter.of(context).scale(80),
                                    child: Stack(
                                      children:[
                                        SizedBox(width:ResponsiveFlutter.of(context).scale(80),
                                          height: ResponsiveFlutter.of(context).scale(80),
                                          child: ClipRRect(borderRadius: BorderRadius.circular(100),
                                            child: _image==null?CircleAvatar(
                                              radius: ResponsiveFlutter.of(context).scale(80),):
                                            Image.file(_image,fit: BoxFit.cover,),
                                          ),
                                      ),
                                        Align(alignment: AlignmentDirectional.bottomEnd,
                                        child:Icon(Icons.add_circle_outlined,
                                        size:ResponsiveFlutter.of(context).scale(25),
                                        color: Color(secondary),)),
                                    ]),
                                  ),
                                  onTap: () async {
                                    _image= await getImage();
                                  },
                                ),
                              ]),
                          SizedBox(height: 20,),
                          Text("fd_onboardingPage_msg_sign_up_to_join",style: _styleHeader3,).tr(),
                          SizedBox(height: 50,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("fd_onboardingPage_msg_name",style: _styleBody1,).tr(),
                              TextFormField(
                                controller:nameController,
                                cursorColor: Color(secondary),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                style:_styleBody2_1,
                                decoration: InputDecoration(
                                  hintText: "Name",
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
                                    return "Please enter the name";
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
                                controller: passwordController,
                                cursorColor: Color(secondary),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
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
                          SizedBox(height:40,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("fd_onboardingPage_msg_email",style: _styleBody1,).tr(),
                              TextFormField(
                                controller:emailController,
                                cursorColor: Color(secondary),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                style:_styleBody2_1,
                                decoration: InputDecoration(
                                  hintText: "Email",
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
                                    return "Please enter the valid emailid";
                                  }
                                  return null;
                                },
                              ),
                            ],),
                          SizedBox(height: 40,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("fd_onboardingPage_msg_mobile",style: _styleBody1,).tr(),
                              TextFormField(
                                controller:mobileNoController,
                                cursorColor: Color(secondary),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.numberWithOptions(),
                                style:_styleBody2_1,
                                decoration: InputDecoration(
                                  hintText: "Mobile number",
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
                                  if (val.length!=10) {
                                    return "Please enter the 10 digit mobile number";
                                  }
                                  return null;
                                },
                              ),
                            ],),
                          SizedBox(height: 40,),
                          // ignore: deprecated_member_use
                          FlatButton(child: Text("fd_onboardingPage_button2",style: _styleBody1_3,).tr(),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Color(secondary))),
                            minWidth:MediaQuery.of(context).size.width,
                            height: ResponsiveFlutter.of(context).verticalScale(45),
                            color: Color(secondary),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                await signUpNetwork();
                              }
                            },),
                          SizedBox(height: 120,)
                        ],
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
