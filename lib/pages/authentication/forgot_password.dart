import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCon=TextEditingController();

  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    TextStyle styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));
    TextStyle styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));
    TextStyle styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle  styleBody2_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 1.0, fontWeight: FontWeight.w400,color:Color(colorText2));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("fd_forgot_password",style:  styleBody2_1,).tr(),
        toolbarHeight: ResponsiveFlutter.of(context).verticalScale(40),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp,
              size: ResponsiveFlutter.of(context).scale(15),),
        onPressed: (){
              Navigator.pop(context);
        },),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom:10),
        child:
         
        SizedBox(height: ResponsiveFlutter.of(context).verticalScale(30),
            child: Center(child: Image.asset("assets/images/nav_bar_logo/homeal.png"))),
      ),
      body:Padding(
        padding: EdgeInsets.only(
          left: 16,right: 16
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: orientation==Orientation.portrait?ResponsiveFlutter.of(context).verticalScale(25):0,),
              Text("fd_forgot_password_msg",style:  styleBody2_1,textAlign: TextAlign.center,).tr(),
              SizedBox(height: ResponsiveFlutter.of(context).verticalScale(50),),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("fd_onboardingPage_msg_email",style: styleBody1,).tr(),
              TextFormField(
                controller: emailCon,
                cursorColor: Color(secondary),
                textAlign: TextAlign.left,
                keyboardType: TextInputType.text,
                style: styleBody2_1,
                decoration: InputDecoration(
                  hintText: "email",
                  hintStyle:  styleBody2_3,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,width: 2,style: BorderStyle.solid),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width:1,style: BorderStyle.solid),
                  ),
                ),
                enableInteractiveSelection: true,
                validator: (String val) {
                  if (val.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
              ),
            ],),
          SizedBox(height: 50,),
          // ignore: deprecated_member_use
          FlatButton(child: Text("fd_forgot_password_send",style: styleBody1_3,).tr(),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Color(secondary))),
            minWidth:MediaQuery.of(context).size.width,
            height: ResponsiveFlutter.of(context).verticalScale(45),
            color: Color(secondary),
            onPressed: (){
              if(_formKey.currentState.validate()){

              }
            },),
            ],
          ),
        ),
      ),
    );
  }
}
