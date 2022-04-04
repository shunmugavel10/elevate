import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'search_products_gridList.dart';


class SearchShowCase extends StatefulWidget {
  @override
  _SearchShowCaseState createState() => _SearchShowCaseState();
}

class _SearchShowCaseState extends State<SearchShowCase> {


  List<Widget>categorytitleList = [];
  List<Widget>categoryList = [];

  setCategory() {
    for (int i = 0; i < 5; i++) {
      categoryList.add(SearchProductsGridList());
      categorytitleList.add(Tab(text: "Fruits",));
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

    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText2));

    return Container(
        child: DefaultTabController(
          length: 5,
          child: Scaffold(backgroundColor: Colors.white,
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: new Center(
                child: new Container(
                  child: new SafeArea(
                    child: new TabBar(labelStyle:_styleBody2,
                        isScrollable: true,
                        indicatorColor:Color(secondary),
                        unselectedLabelColor: Color(colorText2),
                        labelPadding: EdgeInsets.only(bottom: 5,right:15,left: 15),
                        unselectedLabelStyle:_styleBody3,
                        tabs: categorytitleList
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
                children: categoryList
            ),

          ),)
    );
  }
}