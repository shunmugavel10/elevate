import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/Pages/Authentication/location_page.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelection extends StatefulWidget {
  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {

  var radioVal=0;
  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleHeader1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeaderXL),
        fontWeight: FontWeight.w900, color:Color(colorText1));
    TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight:FontWeight.w600, color:Color(colorText2));
    TextStyle _styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight:FontWeight.w700,color:Color(colorText3));


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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: orientation==Orientation.portrait?70:0,),
                Container(width:ResponsiveFlutter.of(context).scale(80),
                height: ResponsiveFlutter.of(context).scale(80),
                child: ClipRRect(borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    useOldImageOnUrlChange: true,fit: BoxFit.cover,
                    placeholder:(context, url)=>shimmerEffects(context),
                    imageUrl: "https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
                  ),
                ),),
                SizedBox(height: 30,),
                Text(tr("fd_language_selection_hi")+" Raghunath",style: _styleHeader1,),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Text("fd_language_selection_msg",style: _styleBody1_1,textAlign:TextAlign.justify,).tr(),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    lanTile(context, "fd_language_selection_EN", 0,1),
                    lanTile(context, "fd_language_selection_TL", 1,2),
                    lanTile(context, "fd_language_selection_MA", 2,3),
                  ],),
                ),
                SizedBox(height: ResponsiveFlutter.of(context).verticalScale(12),),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lanTile(context, "fd_language_selection_KN", 3,1),
                      lanTile(context, "fd_language_selection_TN", 4,2),
                      lanTile(context, "fd_language_selection_ML", 5,3),
                    ],),
                ),

                SizedBox(height:35,),
                // ignore: deprecated_member_use
                FlatButton(child: Text("fd_language_selection_select",style: _styleBody1_3,).tr(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(secondary))),
                  minWidth:MediaQuery.of(context).size.width,
                  height: ResponsiveFlutter.of(context).verticalScale(45),
                  color: Color(secondary),
                  onPressed: () async {
                  if(radioVal==0){
                    setState(() {
                      // ignore: deprecated_member_use
                      context.locale= Locale('en', 'US');
                    });
                  }else if(radioVal==1){
                    setState(() {
                      // ignore: deprecated_member_use
                      context.locale= Locale('ta', 'IN');
                    });
                  }else if(radioVal==2){
                    setState(() {
                      // ignore: deprecated_member_use
                      context.locale= Locale('mr', 'IN');
                    });
                  }else if(radioVal==3){
                    setState(() {
                      // ignore: deprecated_member_use
                      context.locale= Locale('kn', 'IN');
                    });
                  }else if(radioVal==4){
                    setState(() {
                      // ignore: deprecated_member_use
                      context.locale= Locale('te', 'IN');
                    });
                  }else if(radioVal==5){
                    setState(() {
                      // ignore: deprecated_member_use
                      context.locale= Locale('ml', 'IN');
                    });
                  }
                  saveLanguage(radioVal);
                  List<String> add = await getAddress();
                  add[0]=="Select"?
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage())):
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                    LandingPage(address: add,)), (route) => false);
                  },),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget lanTile(BuildContext context,language,_val,align){

    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText2));

    return SizedBox(
      child:align==1? Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(value: _val,
          groupValue: radioVal,
          onChanged: (val){
            setState(() {
              radioVal=val;
            });
          },
          activeColor: Color(secondary),),
        Text(language,
          style: radioVal==_val?_styleBody2_1:_styleBody2_2,).tr()
      ],):align==2?Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Radio(value: _val,
          groupValue: radioVal,
          onChanged: (val){
            setState(() {
              radioVal=val;
            });
          },
          activeColor: Color(secondary),),
        Text(language,
          style: radioVal==_val?_styleBody2_1:_styleBody2_2,).tr()
      ],):Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
        Radio(value: _val,
          groupValue: radioVal,
          onChanged: (val){
            setState(() {
              radioVal=val;
            });
          },
          activeColor: Color(secondary),),
        Text(language,
          style: radioVal==_val?_styleBody2_1:_styleBody2_2,).tr()
      ],)
    );
  }
}
