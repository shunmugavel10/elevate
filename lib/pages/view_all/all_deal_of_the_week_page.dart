import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/product_display_S_tile.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class AllDealsOfTheWeek extends StatefulWidget {
  final Future<ProductModel> dealsOfTheWeekList;

  const AllDealsOfTheWeek({Key key, this.dealsOfTheWeekList}) : super(key: key);
  @override
  _AllDealsOfTheWeekState createState() => _AllDealsOfTheWeekState();
}

class _AllDealsOfTheWeekState extends State<AllDealsOfTheWeek> {

  ScrollController _scrollController = ScrollController();
  int currentpage =0,totalPage;
  Future <ProductModel> dealsOfTheWeekList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dealsOfTheWeekList=widget.dealsOfTheWeekList;
    widget.dealsOfTheWeekList.then((value){
      totalPage=value.value.totalPages;
    });
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getDealsOfTheWeekNetwork();
      }
    });
  }
  Future<ProductModel> getDealsOfTheWeekNetwork() async {
    if((totalPage-1)>currentpage) {
      currentpage++;
      Response response;
      try {
        final _dio = apiClient();
        await _dio.then((value) async {
          response = await value.get(url_get_dealsOfTheWeek, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            setState(() {
              List<ProductContent> productContent = ProductModel.
              fromJson(response.data).value.content;
              dealsOfTheWeekList.then((value) {
                value.value.content.addAll(productContent);
              });
            });
          } else {
            showtoast("Failed");
          }
        });
      } catch (e) {
        showtoast("Failed");
      }
    } else {
      showtoast("No more products");
    }
  }

  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w500,color:Color(colorText1));

    return Scaffold(
      backgroundColor: Color(0xff9DBB46),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("fd_mainpage_4_title",style: _styleBody1,).tr(),
              Text('fd_mainpage_4_sub_title',style: _styleButton1,).tr(),
            ]),
        actions: [
          search(context),
          cart(context)
        ],
      ),
      body:FutureBuilder(
          future: dealsOfTheWeekList,
          builder: (context,AsyncSnapshot<ProductModel> snapshot) {
            if(snapshot.hasData)
              return StaggeredGridView.countBuilder(
                controller: _scrollController,
                padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
                crossAxisCount: Orientation.portrait==orientation?2:3,
                itemCount: snapshot.data.value.content.length,
                itemBuilder: (BuildContext context, int index) =>
                    productDisplayS(context,index,snapshot.data.value.content[index]),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              );
            else return
              StaggeredGridView.countBuilder(
                crossAxisCount: Orientation.portrait==orientation?2:3,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) => shimmerEffects(context),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              );
          }
      ),
    );
  }
}
