import 'package:dio/dio.dart';
import 'package:farm_direct/model/favourite_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/product_display_L_tile.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/common/vendor_display_L.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class FavouritesPage extends StatefulWidget {
  final List<String> favouriteIdList;

  const FavouritesPage({Key key, this.favouriteIdList}) : super(key: key);
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {

  Future<FavouriteModel> getFavouritesNetwork(String itemType) async {
    Response response;
    try {
      FavouriteModel favouritedata;
      String userId= await getStoreId();
      final _dio = apiClient();
      favouritedata= await _dio.then((value) async {
        response =await value.get("$url_get_post_favouriteProduct",queryParameters: {
          "userId":userId,
          "expand":"fav",
          "itemType":itemType
        });
        if (response.statusCode == 200) {
          return FavouriteModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return favouritedata;
    } catch (e) {
      showtoast("Failed2");
    }
  }

  @override
  Widget build(BuildContext context) {

   TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader2),
        fontWeight: FontWeight.w600, color:Color(colorText1));
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w600,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText2));

    return Scaffold(
        appBar:AppBar(
          title: Text("fd_favourites_title",style: _styleHeader,).tr(),
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Container(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(backgroundColor: Colors.white,
                appBar: new PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: new Container(
                    alignment: AlignmentDirectional.center,
                    child: new SafeArea(
                      child: new TabBar(labelStyle:_styleBody2,
                          isScrollable: true,
                          indicatorColor:Color(secondary),
                          unselectedLabelColor: Color(colorText2),
                          labelPadding: EdgeInsets.only(bottom: 5,right:15,left: 15),
                          unselectedLabelStyle:_styleBody3,
                          tabs: [
                            Tab(child:Text("fd_vendorDetailed_products_title").tr(),),
                            Tab(child:Text("fd_favourites_subTitle").tr(),),
                          ]
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                    children: [
                      favouritesList(context,1,"PRODUCT"),
                      favouritesList(context,2,"STORE")
                    ]
                ),

              ),)
        )
    );
  }
  Widget favouritesList(BuildContext context,int type, String itemType){

    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader2),
        fontWeight: FontWeight.w600, color:Color(colorText1));

    return FutureBuilder(
        future: getFavouritesNetwork(itemType),
        builder: (context,AsyncSnapshot<FavouriteModel> snapshot) {
          if(snapshot.connectionState==ConnectionState.done) {
            if (snapshot.hasData && snapshot.data.value != null )
              return StaggeredGridView.countBuilder(
                crossAxisCount: Orientation.portrait == orientation ? 2 : 3,
                itemCount: snapshot.data.value.favouriteContent.length,
                itemBuilder: (BuildContext context, int index){
                  if(type==1) return
                    productDisplayXL(context, snapshot.data.value.favouriteContent[index].product);
                  else return
                    vendorDisplayL(context, snapshot.data.value.favouriteContent[index].store);
                },
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              );
            else if (snapshot.data.value == null)
              return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/nav_bar_logo/navbar_logo.png",
                        height: ResponsiveFlutter.of(context).verticalScale(
                            24),
                        fit: BoxFit.contain,),
                      SizedBox(height: 40,),
                      Text("fd_favourite_empty_msg", style: _styleHeader,
                        textAlign: TextAlign.center,).tr()
                    ]),
              );
            else return LinearProgressIndicator();
          }
          else  return
            StaggeredGridView.countBuilder(
              crossAxisCount: Orientation.portrait==orientation?2:3,
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) => productShimmer(context),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
        }
    );
  }
}
