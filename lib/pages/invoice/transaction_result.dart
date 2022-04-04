import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:farm_direct/pages/tab2/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';


class TransactionResult extends StatelessWidget {
  final bool result;

  const TransactionResult({Key key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var _width=MediaQuery.of(context).size.width;
    TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeaderXL),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleButton2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText3));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(result?"fd_transactionResult_success":
                  "fd_transactionResult_failed",style: _styleHeader,).tr(),
                  Container(
                    width: ResponsiveFlutter.of(context).scale(120),height: ResponsiveFlutter.of(context).scale(120),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(secondary),width: 3),
                      shape: BoxShape.circle,),
                    child: Icon(result?FeatherIcons.check:FeatherIcons.x,color: Color(secondary),
                      size: ResponsiveFlutter.of(context).scale(80),),
                  ),
                  Column(children: [
                    Text("fd_transactionResult_msg1",style: _styleBody2,).tr(),
                    SizedBox(height: 10,),
                    Text("fd_transactionResult_msg2",style: _styleBody3,textAlign: TextAlign.center,).tr(),
                  ],)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // ignore: deprecated_member_use
                  FlatButton(child: Text("fd_transactionResult_button1",style: _styleButton2,).tr(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minWidth:_width,
                    height: ResponsiveFlutter.of(context).verticalScale(45),
                    color: Color(secondary),splashColor: Colors.white,
                    onPressed: () async {
                      List<String> add = await getAddress();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LandingPage(
                        address: add,)), (route) => false);
                    },),
                  SizedBox(height: ResponsiveFlutter.of(context).verticalScale(25),),
                  // ignore: deprecated_member_use
                  FlatButton(child: Text("fd_transactionResult_button2",style: _styleButton1,).tr(),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(secondary))),
                    minWidth:_width,
                    height: ResponsiveFlutter.of(context).verticalScale(45),
                    color: Colors.transparent,splashColor: Color(secondary),
                    onPressed: (){

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OrderPage()),
                              (route) => false);
                    },)
                ],
              ),
            )
        ],),
      ),
    );
  }
}
