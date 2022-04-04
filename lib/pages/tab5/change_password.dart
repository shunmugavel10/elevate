import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePassword extends StatefulWidget {
  final String username;

  const ChangePassword({Key key, this.username}) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController rePasswordController=TextEditingController();
  TextEditingController oldPasswordController=TextEditingController();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.username);
    usernameController.text=widget.username;
  }
  @override
  Widget build(BuildContext context) {

    TextStyle _styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        letterSpacing: 1.0, fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody2_4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w600,color:Color(colorText1));


    return Scaffold(
      appBar: AppBar(
        title: Text("fd_account_change_password",style: _styleBody2_1,).tr(),
        toolbarHeight: ResponsiveFlutter.of(context).verticalScale(40),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp,
            size: ResponsiveFlutter.of(context).scale(15),),
          onPressed: (){
            Navigator.pop(context);
          },),
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
                  SizedBox(height: 20,),
                  Text("fd_account_change_password_msg",style: _styleBody2_4,textAlign: TextAlign.center,).tr(),
                  SizedBox(height: 50,),
                  textField(context, "fd_account_change_password_username",
                      "fd_account_change_password_username",
                      "fd_account_change_password_username_hint", usernameController),
                  SizedBox(height: 40,),
                  textField(context, "fd_account_change_password_oldPassword",
                      "fd_account_change_password_oldPassword",
                      "fd_account_change_password_oldPassword_hint", oldPasswordController),
                  SizedBox(height:40,),
                  textField(context, "fd_account_change_password_newPassword",
                      "fd_account_change_password_newPassword",
                      "fd_account_change_password_newPassword_hint", passwordController),
                  SizedBox(height: 40,),
                  textField(context, "fd_account_change_password_repPassword",
                      "fd_account_change_password_repPassword",
                      "fd_account_change_password_repPassword_hint", rePasswordController),
                  SizedBox(height: 40,),
                  // ignore: deprecated_member_use
                  FlatButton(child: Text("fd_account_change_password",style: _styleBody1_3,).tr(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(secondary))),
                    minWidth:MediaQuery.of(context).size.width,
                    height: ResponsiveFlutter.of(context).verticalScale(45),
                    color: Color(secondary),
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>Verify_number()));
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
