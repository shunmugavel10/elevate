import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/order_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Widget orderListPage(BuildContext context,index){

  var val;

  Future<OrderModel> getOrdersNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      String storeId=await getStoreId();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_orders,queryParameters: {
          "storeId":storeId,
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          return OrderModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast("Failed1");
    }
  }

  return FutureBuilder(
    future: getOrdersNetwork(),
    builder: (context,AsyncSnapshot<OrderModel> snapshot){
      TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
          fontWeight: FontWeight.w500,color:Color(secondary));
      TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
          fontWeight: FontWeight.w500, color:Color(colorText1));

      val=index==0?"All":index==1?"Approved":index==2?"Waiting":"Completed";
      if(snapshot.connectionState==ConnectionState.done) {
        if (snapshot.hasData && snapshot.data.value != null)
          return ListView.builder(
              itemCount: snapshot.data.value.orderContent.length,
              itemBuilder: (context, index) {
                OrderContent list = snapshot.data.value.orderContent[index];
                if (list.status == val || val == "All") {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(color: Color(
                                  0xffE7E7E8)))),
                      child: ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                          title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue, radius: 4.0,),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text("Order# : ${19900 + index}",
                                    style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(fontBody1),
                                        fontWeight: FontWeight.w500,
                                        color: Color(colorText1)),),
                                ),
                              ]),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              Text(list.orderDate ?? "", style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(fontBody3),
                                  fontWeight: FontWeight.w500,
                                  color: Color(colorText2)),),
                              SizedBox(height: 5,),
                              Text(list.status ?? "", style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(fontBody4),
                                  fontWeight: FontWeight.w500,
                                  color: Color(colorText2)),),
                            ],
                          ),
                          trailing: Container(width: 150, height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list.items.length > 2 ? 3 : list
                                    .items
                                    .length,
                                itemBuilder: (context, index1) {
                                  if (index1 == 2)
                                    return
                                      Container(width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.1),
                                            borderRadius: BorderRadius.circular(
                                                2)),
                                        child: Text(
                                          "+${(list.items.length) - 2}\n more",
                                          style: _styleBody3,
                                          textAlign: TextAlign.center,),);
                                  else
                                    return Container(width: 50, height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1),
                                          borderRadius: BorderRadius.circular(
                                              2)),
                                      child: CachedNetworkImage(
                                          height: ResponsiveFlutter.of(context)
                                              .scale(60),
                                          width: ResponsiveFlutter.of(context)
                                              .scale(60),
                                          fit: BoxFit.contain,
                                          useOldImageOnUrlChange: true,
                                          imageUrl: list.items[index1].product
                                              .thumbnail ?? ""),
                                    );
                                }), //
                          )
                      ),
                    ),
                  );
                }
                else return
                  Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/main_logo/main_logo.png",
                            height: ResponsiveFlutter.of(context).verticalScale(
                                24),
                            fit: BoxFit.contain,),
                          SizedBox(height: 40,),
                          Text("fd_order_empty_msg", style: _styleHeader,).tr()
                        ]),
                  );
              });
        else return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Image.asset("assets/images/main_logo/main_logo.png",
                  height: ResponsiveFlutter.of(context).verticalScale(70),
                  fit: BoxFit.contain,),
                SizedBox(height: 40,),
                Text("fd_order_empty_msg",style: _styleHeader,).tr()
              ]),
        );
      }
      else return Container();
    },
  );
}
