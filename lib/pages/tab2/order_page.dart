import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'orderList_page.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  List<Widget>statusTitleList = [
    Tab(child:Row(children: [Text(" All")],),),
    Tab(child:Row(children: [Icon(Icons.circle,size: 10,color: Colors.blue,),Text(" Processing")],),),
    Tab(child:Row(children: [Icon(Icons.circle,size: 10,color: Colors.red,),Text(" Waiting")],),),
    Tab(child:Row(children: [Icon(Icons.circle,size: 10,color: Colors.green,),Text(" Completed")],),),
    ];
  List<Widget>statusList = [];

  setCategory() {
    for (int i = 0; i < 4; i++) {
      statusList.add(orderListPage(context,i));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCategory();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText2));

    return Container(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(backgroundColor: Colors.white,
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: new Container(
                alignment: AlignmentDirectional.center,
                child: new SafeArea(
                  child: new TabBar(labelStyle:_styleBody2,
                      isScrollable: true,
                      indicatorColor:Color(secondary),
                      unselectedLabelColor: Color(colorText2),
                      labelPadding: EdgeInsets.only(bottom: 5,right:15,left: 15),
                      unselectedLabelStyle:_styleBody3,
                      tabs: statusTitleList

                  ),
                ),
              ),
            ),
            body: TabBarView(
              // physics: NeverScrollableScrollPhysics(),
                children: statusList
            ),

          ),)
    );
  }
}