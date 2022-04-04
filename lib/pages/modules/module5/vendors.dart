
import 'package:dio/dio.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/modules/module5/vendors_list.dart';
import 'package:farm_direct/providers/vendorsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class Vendors extends StatefulWidget {
  @override
  _VendorsState createState() => _VendorsState();
}

class _VendorsState extends State<Vendors> {

  List<Tab>statusTitleList = [
    Tab(child:Row(children: [Text(tr("fd_filter_mode1"))],),),
    Tab(child:Row(children: [Icon(Icons.circle,size: 10,color: Colors.blue,),Text(tr("fd_filter_mode2"))],),),
    Tab(child:Row(children: [Icon(Icons.circle,size: 10,color: Colors.red,),Text(tr("fd_filter_mode3"))],),),
   ];

  @override
  Widget build(BuildContext context) {
 TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText2));
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/images/nav_bar_logo/homeal.png",
            height: ResponsiveFlutter.of(context).verticalScale(28),
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        title: Text(
          "fd_app_title3",
        ).tr(),
        
      ),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(backgroundColor: Colors.white,
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: new Container(
                alignment: AlignmentDirectional.center,
                child: new SafeArea(
                  child: new TabBar(labelStyle:_styleBody2,
                      isScrollable: true,
                      indicatorColor:Color(secondary),
                      unselectedLabelColor: Colors.grey,
                      indicatorPadding: EdgeInsets.only(bottom: 15),
                      labelPadding: EdgeInsets.only(bottom: 5,right:25,left: 25),
                      unselectedLabelStyle:_styleBody3,
                      tabs: statusTitleList

                  ),
                ),
              ),
            ),
            body:ChangeNotifierProvider(
                create: (context) =>VendorProvider(),
                child: TabBarView(
                 physics: NeverScrollableScrollPhysics(),
                  children: [
                    VendorListing(),
                    VendorListing(),
                    VendorListing(),
                  ]
              ),
            ),

          ),)
    );
  }
}