import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Widget appCard(BuildContext context,String title){
  TextStyle styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500);
  return Card(child: SizedBox(height: 80,width: 80,
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          Icon(FeatherIcons.feather),
          Text(title,style: styleBody1,textAlign: TextAlign.center,).tr(),
  ]),
  ),);
}