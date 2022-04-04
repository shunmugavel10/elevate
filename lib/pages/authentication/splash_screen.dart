import 'dart:async';
import 'package:farm_direct/Pages/Authentication/onboarding_screens.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  router() async {
    int loginStatus=await getLoginStatus();
    List<String> add = await getAddress();
    Timer(Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(context, PageTransition(
          duration: Duration(milliseconds: 800),
          type: PageTransitionType.fade, child:
      loginStatus==0?OnBoardScreen():LandingPage(address: add)), (route) => false);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   router();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children:[
        Align(alignment: AlignmentDirectional.center,
          child: SizedBox(width:ResponsiveFlutter.of(context).scale(150),
            child: Image.asset("assets/images/main_logo/main_logo.png")),
        ),
        // Align(alignment: AlignmentDirectional.bottomCenter,
        // child:  Container(height: ResponsiveFlutter.of(context).verticalScale(80),color: Colors.black,
        //     padding: EdgeInsets.only(bottom: 40),
        //     child: Center(child: Image.asset("assets/images/splash_screen/Group123.png"))),)
      ]
      ),
    );
  }
}
