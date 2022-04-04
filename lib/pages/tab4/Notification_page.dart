import 'package:dio/dio.dart';
import 'package:farm_direct/model/notification_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/notification_tile.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  ScrollController _scrollController = ScrollController();
  int currentpage =0,totalPage=2;
  Future <NotificationModel> notificationList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationList=getNotifcation();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getNotifcation();
      }
    });
  }

 Future<NotificationModel> getNotifcation() async {
    Response response;
    if(currentpage<totalPage) {
      currentpage++;
      try {
        var userId = await getStoreId();
        final _dio = apiClient();
        var data = _dio.then((value) async {
          response = await value.get(url_get_notification, queryParameters: {
            "recipientId": userId,
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if (currentpage == 0) {
              totalPage=NotificationModel.fromJson(response.data).value.totalPages;
              return NotificationModel.fromJson(response.data);
            }
            else {
              setState(() {
                List<NotificationContent> notificationData=NotificationModel.fromJson(response.data).value.content;
                notificationList.then((value){
                  value.value.content.addAll(notificationData);
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
    }
  }


  @override
  Widget build(BuildContext context) {

    TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader2),
        fontWeight: FontWeight.w600, color:Color(colorText1));

    return Scaffold(
      appBar:AppBar(
        title: Text("fd_notification_title",style: _styleHeader,).tr(),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: notificationList,
        builder: (context,AsyncSnapshot<NotificationModel> snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasData)
              return ListView.builder(
                controller: _scrollController,
                  itemCount: snapshot.data.value.content.length,
                  itemBuilder: (context,index) {
                    return notificationTile(context,snapshot.data.value.content[index]);
                  });
            else return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Image.asset("assets/images/main_logo/main_logo.png",
                      height: ResponsiveFlutter.of(context).verticalScale(24),
                      fit: BoxFit.contain,),
                    SizedBox(height: 40,),
                    Text("fd_notification_empty_msg",style: _styleHeader,).tr()
                  ]),
            );
          }else return LinearProgressIndicator();
        },
      )
    );
    }
  }
