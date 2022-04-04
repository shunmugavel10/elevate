import 'package:dio/dio.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/model/storeDetailed_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/favourite_button.dart';
import 'package:farm_direct/pages/common/product_display_L_tile1.dart';
import 'package:farm_direct/pages/common/rating_bar.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/reviews/create_reviews.dart';
import 'package:farm_direct/pages/reviews/show_reviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/pages/common/size_colors.dart';


class VendorDetailedView extends StatefulWidget {
  final String storeId;
  final String storeName;

  const VendorDetailedView({Key key, this.storeId, this.storeName}) : super(key: key);
  @override
  _VendorDetailedViewState createState() => _VendorDetailedViewState();
}

class _VendorDetailedViewState extends State<VendorDetailedView> {

  var selectedTab=1;

 Future<StoreDetailedContent> getStoreDetailedDataNetwork(String id) async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get("$url_get_store/$id");
        if (response.statusCode == 200) {
          return StoreDetailedContent.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast("Failed");
    }
  }


  change(){
    setState(() {
      selectedTab=3;
    });
  }
  @override
  Widget build(BuildContext context) {

    var _width =MediaQuery.of(context).size.width;
    var _height =MediaQuery.of(context).size.height;

    TextStyle _styleHeader3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
        fontWeight: FontWeight.w500, color:Color(colorText1));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w600,color:Color(colorText1));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(widget.storeName??"",style: _styleBody1,),
          Text("fd_vendorDetailed_products_title",style: _styleBody3,).tr()
        ],),
        actions: [
          cart(context)
        ],
      ),
      floatingActionButton:selectedTab==3? FloatingActionButton(
        child: Icon(FeatherIcons.bookOpen),
        onPressed: () async {
          bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewsRatings(
            id: widget.storeId, name: widget.storeName,
            imgUrl: "https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
          )));
          if(result==true){
            setState(() {
              selectedTab=1;
            });

          }
        },
      ):null,
      body:FutureBuilder(
        future: getStoreDetailedDataNetwork(widget.storeId),
        builder: (context,AsyncSnapshot<StoreDetailedContent> snapshot){
          if(snapshot.hasData)
            return Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: ListView(
                  children:[
                    Container(
                      height: 50,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Assets",style: selectedTab==1?_styleBody1:_styleBody1_1,),
                                selectedTab==1? Container(height:2,width: _width*0.25,color: Color(secondary),):
                                SizedBox()
                              ],),
                            onPressed: (){
                              setState(() {
                                selectedTab=1;
                                print(snapshot.data.storeData.categories.length);
                              });
                            },
                          ),
                          TextButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("FAQ",style: selectedTab==2?_styleBody1:_styleBody1_1,),
                                selectedTab==2? Container(height:2,width: _width*0.25,color: Color(secondary),):
                                SizedBox()
                              ],),
                            onPressed: (){
                              setState(() {
                                selectedTab=2;
                              });
                            },
                          ),
                          TextButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Review",style: selectedTab==3?_styleBody1:_styleBody1_1,),
                                selectedTab==3? Container(height:2,width: _width*0.25,color: Color(secondary),):
                                SizedBox()
                              ],),
                            onPressed: (){
                              setState(() {
                                selectedTab=3;
                              });
                            },
                          ),
                        ],),
                    ),
                    selectedTab==1?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children:[
                            Container(
                            height:ResponsiveFlutter.of(context).verticalScale(120),
                            width: _width,
                            color: Color(0xffF9F9F9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  useOldImageOnUrlChange: true,
                                  imageUrl: snapshot.data.name,
                                  placeholder: (context, url) => shimmerEffects(context),
                                  errorWidget: (context, url, error) => Icon(
                                    FeatherIcons.image,size: 50,color: Colors.grey.shade300,),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: ResponsiveFlutter.of(context).scale(80),
                                        height: ResponsiveFlutter.of(context).verticalScale(80),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width:_width*0.55,
                                        child: Text(widget.storeName,style: _styleHeader3,
                                          maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      ),
                                      SizedBox(height:6,),
                                      SizedBox(width:_width*0.55,
                                        child: Text("20 ${tr("fd_vendorDetailed_products_title")}",style: _styleBody2_1,
                                          maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      ),
                                      Container(width: ResponsiveFlutter.of(context).scale(100),
                                          height:ResponsiveFlutter.of(context).verticalScale(15),
                                          alignment:AlignmentDirectional.centerStart,
                                          child:ratingBar(context,0xffFFC107)
                                      ),
                                    ],),
                                )
                              ],
                            ),
                          ),
                            Container(
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.topRight,
                                child:FavouriteButton(productId: snapshot.data.id,itemType: "STORE",)
                            )
                        ]),
                        Text(tr("fd_vendorDetailed_about_title")+widget.storeName,
                            maxLines:1,
                            overflow: TextOverflow.ellipsis,
                            style:_styleBody2),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,),
                          child: SizedBox(width: _width,
                            child: Text(snapshot.data.description,
                              // 'A banana is an elongated, edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa. In some countries, bananas used for cooking may be called “plantains”, distinguishing them from dessert bananas. … The fruits grow in clusters hanging from the top of the plant.',
                              style:_styleBody2_1,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                                  height: (ResponsiveFlutter.of(context).verticalScale(165)+
                                      ResponsiveFlutter.of(context).fontSize(14.5))*
                                      snapshot.data.storeData.categories.length,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.storeData.categories.length,
                                      itemBuilder: (context, index) {
                                        Category data=snapshot.data.storeData.categories[index];
                                        return SizedBox(
                                          height: ResponsiveFlutter.of(context).verticalScale(165)+
                                              ResponsiveFlutter.of(context).fontSize(14.5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Text(data.name,style: _styleHeader3,),
                                                SizedBox(height: ResponsiveFlutter.of(context).verticalScale(165)+
                                                    ResponsiveFlutter.of(context).fontSize(11.5),
                                                  child: ListView.builder(
                                                      itemCount:data.products.length,
                                                      scrollDirection: Axis.horizontal,
                                                      //padding: EdgeInsets.only(left: 16, right: 16),
                                                      itemBuilder: (BuildContext context, index1) {
                                                        ProductContent data1 =data.products[index1];
                                                        return FittedBox(fit: BoxFit.contain,
                                                            child: productDisplayL(context,data1));
                                                      }),
                                                ),
                                              ]),
                                        );
                                      }),
                                ),
                      ],):selectedTab==2?Container(
                      height: 500,width: _width,
                      child:  FutureBuilder(
                          future: rootBundle.loadString("assets/README.md"),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Markdown(data: snapshot.data);
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ):Container(width: _width,height:_height-kToolbarHeight-50,
                        child: ShowReviews(id: snapshot.data.id,itemType: "EXPENSE",appbar: false,))
                  ]),
            );
          else {
            return
              SizedBox(
                height: ResponsiveFlutter.of(context).verticalScale(170)+
                    ResponsiveFlutter.of(context).fontSize(14.5)*5,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context,index) {
                      return SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(170)+
                            ResponsiveFlutter.of(context).fontSize(14.5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              Container(width: _width*0.3,child: shimmerEffects(context),
                                height: ResponsiveFlutter.of(context).fontSize(2.2),),
                              SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(165)+
                                      ResponsiveFlutter.of(context).fontSize(11.5),
                                  child:  ListView.builder(
                                      itemCount:5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                            padding: const EdgeInsets.only(left: 16),
                                            child: productShimmer1(context)
                                        );
                                      })
                              ),
                            ]),
                      );
                    }),
              );
          }
        },
      )
    );
  }
}
