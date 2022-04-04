import 'package:farm_direct/model/notification_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget notificationTile(BuildContext context, NotificationContent notificationData){

  TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(colorText1));
  TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody5),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  var onTime=notificationData.adminData.updatedOn;
  
  return ListTile(
    leading: Container(width: ResponsiveFlutter.of(context).scale(50),
        height:ResponsiveFlutter.of(context).verticalScale(50),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
            color: Color(0xffE8F0CD),border: Border.all(color: Color(0xffE7E7E8),width:2)
        ), child: Icon(FeatherIcons.truck,color: Color(colorText1),
          size:ResponsiveFlutter.of(context).scale(15),)),
    title: Text(notificationData.description,
      style: _styleBody1_1,
      maxLines: 2, overflow: TextOverflow.ellipsis,),
    subtitle: Text(timeago.format(onTime),style: _styleBody2,),
    hoverColor: Colors.grey,
    tileColor: Colors.white,
  );
}