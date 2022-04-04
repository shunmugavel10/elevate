import 'package:dio/dio.dart';
import 'package:farm_direct/model/store_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/common/vendor_display_L.dart';
import 'package:farm_direct/pages/detail/vendor_detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';


class AllVendorsListingPage extends StatefulWidget {
  final Future<StoreModel> storeData;

  const AllVendorsListingPage({Key key, this.storeData}) : super(key: key);
  @override
  _AllVendorsListingPageState createState() => _AllVendorsListingPageState();
}

class _AllVendorsListingPageState extends State<AllVendorsListingPage> {

  ScrollController _scrollController = ScrollController();
  int currentpage =0,totalPage;
  Future <StoreModel> storeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeList=widget.storeData;
    widget.storeData.then((value){
      totalPage=value.value.totalPages;
    });
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getStoresNetwork();
      }
    });
  }
  Future<StoreModel> getStoresNetwork() async {
    if((totalPage-1)>currentpage) {
      currentpage++;
      Response response;
      try {
        final _dio = apiClient();
        await _dio.then((value) async {
          response = await value.get(url_get_store, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            setState(() {
              List<StoreContent> storeContent = StoreModel.
              fromJson(response.data).value.storeContent;
              storeList.then((value) {
                value.value.storeContent.addAll(storeContent);
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
      showtoast("No more stores");
    }
  }

  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText2));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("fd_mainpage_5_title").tr(),
              Text('fd_all_listing_subTitle',style: _styleButton1,).tr(),
            ]),
        actions: [
          search(context),
          cart(context)
        ],
      ),
      body:Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: FutureBuilder(
          future: storeList,
          builder: (context,AsyncSnapshot<StoreModel> snapshot){
            if(snapshot.hasData)
            return StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: Orientation.portrait==orientation?2:3,
              itemCount: snapshot.data.value.storeContent.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: vendorDisplayL(context,snapshot.data.value.storeContent[index]),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>VendorDetailedView(
                    storeId: snapshot.data.value.storeContent[index].id,
                    storeName: snapshot.data.value.storeContent[index].name,
                  )));
                },),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
            );
            else return StaggeredGridView.countBuilder(
              crossAxisCount: Orientation.portrait==orientation?2:3,
              itemCount: 14,
              itemBuilder: (BuildContext context, int index) => Container(width:ResponsiveFlutter.of(context).scale(155),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfff6f6f8), width: 2.0),
                    borderRadius: BorderRadius.circular(8.0)
                ),padding: EdgeInsets.all(5),
                child: Shimmer.fromColors(
                    period: Duration(milliseconds: 1500),
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade50,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(color: Colors.blueGrey,width:ResponsiveFlutter.of(context).scale(100),
                              height: ResponsiveFlutter.of(context).scale(100),),
                          ),
                          Container(color: Colors.white,height: 20,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(140),),
                          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
                          ],
                      ),
                    )
                ),
              ),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
            );
          },
        ),
      ),
    );
  }
}
