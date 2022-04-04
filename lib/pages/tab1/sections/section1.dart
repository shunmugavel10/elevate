import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/pages/common/deals_offers_tile.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/invoice/coupon_page.dart';
import 'package:farm_direct/pages/modules/module4/coupons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

Widget advertisement(BuildContext context,Future <CouponModel> bannerList) {

  var _width = MediaQuery.of(context).size.width;
  TextStyle _styleBody3 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500, color: Color(colorText1));

  return Container(
    child: FutureBuilder(
        future: bannerList,
        builder: (BuildContext context, AsyncSnapshot<CouponModel> snapshot) {
          if (snapshot.hasData && snapshot.data.value!=null) {
            return Container(
              height:ResponsiveFlutter.of(context).scale(140),width:_width,
              child: ListView.builder(
                 padding: EdgeInsets.only(left: 16,right: 16),
                  itemCount: snapshot.data.value.content.length+1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context,index) {
                    if(index<snapshot.data.value.content.length)
                    return dealsOffersTile(context,snapshot.data.value.content[index]);
                    else return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Coupons()));
                      },
                      child: Container(
                          height: ResponsiveFlutter.of(context).scale(140),
                          width:ResponsiveFlutter.of(context).scale(230),
                      //margin:EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Color(0xffF5F5F5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                        Text("fd_all_deals_offers_viewMore_body",style:_styleBody3,).tr(),
                        Icon(Icons.arrow_forward_ios_sharp)
                      ])),
                    );
                  }),
            );
          } else if (snapshot.hasError == true) {
            return Text("Error");
          } else {
            return Container(
              height: ResponsiveFlutter.of(context).scale(140),
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14, 14, 0),
                      child: Container(
                        height: ResponsiveFlutter.of(context).scale(140),
                        width:ResponsiveFlutter.of(context).scale(230),
                        // margin:EdgeInsets.only(left: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: shimmerEffects(context)
                        ),
                      ),
                    );
                  }),
            );
          }
        }),
  );
}