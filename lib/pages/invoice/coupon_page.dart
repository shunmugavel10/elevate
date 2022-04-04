// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
// import 'package:farm_direct/pages/coupons/add_edit_coupons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shimmer/shimmer.dart';


class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

  ScrollController _scrollController = ScrollController();
  int currentpage =-1,totalPage=1;
  Future <CouponModel> couponsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    couponsList=getCouponNetwork();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getCouponNetwork();
      }
    });
  }
  Future<CouponModel> getCouponNetwork() async {
    if((totalPage-1)>currentpage) {
      currentpage++;
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response =await value.get(url_get_coupons,queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200)
            {
            if(currentpage==0){
              totalPage=CouponModel.fromJson(response.data).value.totalPages;
              return CouponModel.fromJson(response.data);
            }else{
              setState(() {
                List<CouponContent> couponContent = CouponModel.
                fromJson(response.data).value.content;
                couponsList.then((value) {
                  value.value.content.addAll(couponContent);
                  totalPage=value.value.totalPages;
                });
              });
            }
          } else {
            showtoast("Failed");
          }
        });
        return data;
      } catch (e) {
         showtoast("Failed");
      }
    } else {
      showtoast("No more products");
    }
  }

  Future<CouponModel> postCouponNetwork(CouponContent couponData) async {
    Response response;
    try {
      final _dio = apiClient();
       await _dio.then((value) async {
        response =await value.post(url_get_coupons,queryParameters: {
            "code": couponData.code,
            "name": couponData.name,
            "description": couponData.description,
            "type": couponData.type,
            "maximumRedemptions": couponData.maximumRedemptions,
            "customerId": couponData.customerId,
            "productId": "",
            "categoryId": "",
            "store": {
              "id": "4528a8ca-dab3-4be8-9e19-2784cca6ba3c"
            },
            "image": couponData.image
        });
        if (response.statusCode == 200)
          return CouponModel.fromJson(response.data);
        else {
          showtoast("Failed");
        }
      });
    } catch (e) {
      showtoast("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text("fd_coupon_title").tr(),
        actions: [
          IconButton(icon: Icon(FeatherIcons.search), onPressed: (){
            showSearch(context: context, delegate: Search(couponData:couponsList));
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditCoupons(edit: false,)));
        },
      ),
      body:FutureBuilder(
          future: couponsList,
          builder: (context, AsyncSnapshot <CouponModel> snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.value.content.length,
                  padding: EdgeInsets.only(left: 8,right: 8,top: 16),
                  itemBuilder: (BuildContext context, int index) {
                    CouponContent couponData=snapshot.data.value.content[index];
                    return Column(
                      children:[
                        Container(
                        height: _width/2.5,
                        width:_width,
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,useOldImageOnUrlChange: true,
                            imageUrl: couponData.image,
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                baseColor: Color(0xffE0E0E0),
                                highlightColor: Color(0xffF1F1F1),
                                child: Container(color: Colors.grey,),
                              );
                            },
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(couponData.code,style: _styleBody2,),
                            // ignore: deprecated_member_use
                          FlatButton(child: Text("Edit",style: _styleBody3,),color: Color(secondary),
                            height: 25,
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(4)),
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditCoupons(edit: true,
                              // couponData: couponData,)));
                            },),
                        ],),
                        Divider(thickness: 0.8,)
                    ]);
                    //   Card(
                    //   child: ListTile(
                    //
                    //     title: Text(couponData.name),
                    //     subtitle: Text(couponData.description),
                    //     leading: CachedNetworkImage(
                    //         // height: ResponsiveFlutter.of(context).scale(60),
                    //         // width: ResponsiveFlutter.of(context).scale(60),
                    //         fit: BoxFit.contain,useOldImageOnUrlChange: true,
                    //         imageUrl:couponData.image),//Icon(FeatherIcons.gift,size: 25,),
                    //     trailing: SizedBox(width: ResponsiveFlutter.of(context).scale(60),
                    //       child: FlatButton(child: Text("Apply",style: _styleBody3,),color: Color(secondary),
                    //         height: 25,
                    //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                    //         onPressed: (){},),
                    //     ),
                    //   ),
                    // );
                  });
            }
            else return ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16,right: 16),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: productShimmer(context));
                });
          }),
    );
  }
}


class Search extends SearchDelegate<dynamic>{

  final Future<CouponModel> couponData;

  Search({this.couponData});

  Future<CouponModel> getCouponNetwork() async {
      Response response;
      try {
        final _dio = apiClient();
        await _dio.then((value) async {
          response =await value.get(url_get_coupons,queryParameters: {
            
          });
          if (response.statusCode == 200)
              return CouponModel.fromJson(response.data);
           else {
            showtoast("Failed");
          }
        });
      } catch (e) {
        showtoast("Failed");
      }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () { query=''; },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(icon: Icon(Icons.arrow_back), onPressed: () {close(context, null) ; },);
  }

  @override
  Widget buildResults(BuildContext context) {

    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Colors.white);
    return FutureBuilder<dynamic>(
      future: getCouponNetwork(),
      builder: (context, snapshot) {
        return  snapshot.hasData? ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title: Text("50 % OFF"),
                subtitle: Text("Best combo offer"),
                leading: Icon(FeatherIcons.gift,size: 25,),
                trailing: SizedBox(width: ResponsiveFlutter.of(context).scale(60),
                  // ignore: deprecated_member_use
                  child: FlatButton(child: Text("Apply",style: _styleBody3,),color: Color(secondary),
                  height: 25,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                  onPressed: (){},),
                ),
              ),
            );
          },
        ):Center(child: LinearProgressIndicator(),);
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Colors.white);

    return FutureBuilder<dynamic>(
      future: query.length>0? getCouponNetwork():null,
      builder: (context, snapshot) {
        return  snapshot.hasData? ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
            return Card(
              child: ListTile(
                title: Text("50 % OFF"),
                subtitle: Text("Best combo offer"),
                leading: Icon(FeatherIcons.gift,size: 25,),
                trailing: SizedBox(width: ResponsiveFlutter.of(context).scale(60),
                  // ignore: deprecated_member_use
                  child: FlatButton(child: Text("Apply",style: _styleBody3,),color: Color(secondary),
                    height: 25,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                    onPressed: (){},),
                ),
              ),
            );
          },
        ):Center(child:Text("No suggestions"));
      },
    );
  }

}
