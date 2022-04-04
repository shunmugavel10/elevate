import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/model/customer_model.dart';
import 'package:farm_direct/model/vendors_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/modules/module4/coupon_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'shimmers.dart';

Widget couponDisplayLC (BuildContext context,CouponContent couponsData){

  TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight: FontWeight.w500, color:Color(colorText1));
  TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(colorText1));
  TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
      decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500,color:Color(colorText2));

  return GestureDetector(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>CouponDetailed(
        couponData: couponsData,
      )));
    },
    child: FittedBox(
      child: Container(
        width:ResponsiveFlutter.of(context).scale(175),
        child: Stack(children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xfff6f6f8), width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0.1,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: CachedNetworkImage(
                          height: ResponsiveFlutter.of(context).scale(90),
                          width: ResponsiveFlutter.of(context).scale(120),
                          placeholder: (context, url) => shimmerEffects(context),
                          errorWidget: (context, url, error) => Icon(
                            FeatherIcons.image,size: 50,color: Colors.grey.shade300,),
                          fit: BoxFit.contain,useOldImageOnUrlChange: true,
                          imageUrl: couponsData.image 
                      ),
                    ),
                 SizedBox(height: ResponsiveFlutter.of(context).scale(30),),
                 SizedBox(width:ResponsiveFlutter.of(context).scale(160),
                      height: ResponsiveFlutter.of(context).fontSize(5),
                          child: Text(couponsData.code,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:_styleHeader,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      couponsData.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _styleBody2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //     padding: EdgeInsets.all(8),
          //     alignment: Alignment.topRight,
          //     child:FavouriteButton(categoryId: categoryData.id,itemType: "PRODUCT",)
          // )
        ]),
      ),
    ),
  );
}

