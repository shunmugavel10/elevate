import 'package:farm_direct/Pages/Authentication/signin_page.dart';
import 'package:farm_direct/Pages/Authentication/terms_privacy_text.dart';
import 'package:farm_direct/main.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'signup_page.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  
  final PageController _pageController = PageController();
  int _currentindex = 0;

  List _list1=["fd_splashScreen_intro1_heading","fd_splashScreen_intro2_heading","fd_splashScreen_intro3_heading",];
  List _list2=["fd_splashScreen_intro1_body","fd_splashScreen_intro2_body","fd_splashScreen_intro3_body",];

  @override
  Widget build(BuildContext context) {

    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    TextStyle _styleBody =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText3));

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            allowImplicitScrolling: true,
            onPageChanged: (val){
              setState(() {
                _currentindex=_pageController.page.round();
              });
            },
            controller: _pageController,
            children: [
              showCase(context,"assets/images/intro_slider_screen/intro1.png",_list1[0],_list2[0]),
              showCase(context,"assets/images/intro_slider_screen/intro2.png",_list1[1],_list2[1]),
              showCase(context,"assets/images/intro_slider_screen/intro3.png",_list1[2],_list2[2]),
              // Image.asset("assets/images/intro_slider_screen/intro1.png",fit:BoxFit.cover,),
              // Image.asset("assets/images/intro_slider_screen/intro2.png",fit:BoxFit.cover),
              // Image.asset("assets/images/intro_slider_screen/intro3.png",fit:BoxFit.cover),
            ],
          ),
          // Align(alignment: AlignmentDirectional.center,
          //   child: AnimatedContainer(duration: Duration(milliseconds: 500),
          //   width: _width*0.9,
          //   curve: Curves.fastOutSlowIn,
          //     child: Column(mainAxisAlignment: MainAxisAlignment.center,
          //         children:[
          //       Text(_list1[_currentindex],style: _styleHeader,textAlign:TextAlign.center,
          //       maxLines: 2,overflow: TextOverflow.ellipsis,).tr(),
          //       SizedBox(height: 15,),
          //       Text(_list2[_currentindex],style: _styleBody,textAlign:TextAlign.center,
          //         maxLines: 2,overflow: TextOverflow.ellipsis,).tr(),
          //     ]),
          //   ),
          // ),
          Align(alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding:  EdgeInsets.only(bottom:_height*0.10),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: ResponsiveFlutter.of(context).fontSize(0.5),
                    backgroundColor:_currentindex==0?Colors.white:Colors.grey,),
                  SizedBox(width: 10,),
                  CircleAvatar(radius: ResponsiveFlutter.of(context).fontSize(0.5),
                    backgroundColor:_currentindex==1?Colors.white:Colors.grey,),
                  SizedBox(width: 10,),
                  CircleAvatar(radius: ResponsiveFlutter.of(context).fontSize(0.5),
                    backgroundColor:_currentindex==2?Colors.white:Colors.grey,),
                  SizedBox(width: 10,),
                ],),
            ) ,),
          Align(alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding:EdgeInsets.only(top:_height*0.13),
                child: SizedBox(width: _width*0.42,
                    child: Image.asset("assets/images/main_logo/main_logo.png",fit: BoxFit.contain,)),
              )),

          // Align(alignment: AlignmentDirectional.topEnd,
          // child: Padding(
          //   padding: const EdgeInsets.fromLTRB(0,10,10,0),
          //   child: TextButton(child: Text("Skip",style: _styleBody,),onPressed: () async {
          //       List<String> address = await get_address();
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn_Page()));
          //   },),
          // ),),

          Align(alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding:EdgeInsets.only(bottom:_height*0.2),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                // ignore: deprecated_member_use
                FlatButton(child: Text("fd_onboardingPage_button2",style: _styleBody,).tr(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minWidth:ResponsiveFlutter.of(context).scale(120),
                  height: ResponsiveFlutter.of(context).verticalScale(45),
                  color: Color(secondary),splashColor: Colors.white,
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpPage()));
                },),
                // ignore: deprecated_member_use
                FlatButton(child: Text("fd_onboardingPage_button1",style: _styleBody,).tr(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white)),
                  minWidth:ResponsiveFlutter.of(context).scale(120),
                  height: ResponsiveFlutter.of(context).verticalScale(45),
                  color: Colors.transparent,splashColor: Color(secondary),
                  onPressed:  () async {
                    List<String> address = await getAddress();
                   Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
                        (context)=>LandingPage(address:address,)), (route) => false);
                  },)
              ],)
            ),),
          Align(alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom:_height*0.03),
            child: TermsPrivacyText(),
          ),)
        ],
      ),
    );
  }
}

Widget showCase(BuildContext context,route,content1,content2){

  TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeaderXL),
      fontWeight: FontWeight.w500, color:Color(colorText3));
  TextStyle _styleBody =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight:  FontWeight.w500, color:Color(colorText3));
  return ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.black26, Colors.black26],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)
            .createShader(bounds),
        blendMode: BlendMode.darken,
    child: Container(
      decoration:BoxDecoration(
        
        image: DecorationImage(
          image: AssetImage(route),fit: BoxFit.cover,
          ),
          
      ),
      child:Center(
        child:Padding(
          padding:  EdgeInsets.only(left: 16,right: 16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text(content1,style: _styleHeader,textAlign:TextAlign.center,
                  maxLines: 3,overflow: TextOverflow.ellipsis,).tr(),
                SizedBox(height: 15,),
                Text(content2,style: _styleBody,textAlign:TextAlign.center,
                  maxLines: 3,overflow: TextOverflow.ellipsis,).tr(),
              ]),
        ),
      ),
    ),
  );
}