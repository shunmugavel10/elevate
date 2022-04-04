import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/product_display_L_tile.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/view_all/all_sponsored_partners_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

Widget sponseredPartner (BuildContext context,Future <ProductModel> spotlightList) {

  var _width = MediaQuery.of(context).size.width;
  TextStyle _styleHeader = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
      fontWeight: FontWeight.w500, color: Color(colorText1));
  TextStyle _styleButton1 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500, color: Color(colorText1));
  TextStyle _styleBody2 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500, color: Color(colorText2));

  return Container(
      width: _width,
      color: Color(0xffF9F9F9),
      child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.55,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                tr('fd_mainpage_6_title'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: _styleHeader
                            ),
                            Text(
                                tr('fd_mainpage_6_sub_title'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: _styleBody2
                            ),
                          ]),
                    ),
                    GestureDetector(
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(width:MediaQuery.of(context).size.width * 0.25,
                            alignment: Alignment.centerRight,
                            child: Text("fd_homw_viewAll_button", style: _styleButton1,
                              overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,
                              maxLines: 2,).tr(),
                          ),
                          SizedBox(width: 5,),
                          CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(10),backgroundColor: Theme.of(context).buttonColor,
                              child: Icon(Icons.arrow_forward_ios,size:ResponsiveFlutter.of(context).verticalScale(12),
                              color: Colors.white,))
                        ],),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => AllSpotlightPage(spotlightList: spotlightList,)));
                      },)
                  ],
                )),
            SizedBox(height: 15,),
            Container(
              height: ResponsiveFlutter.of(context).verticalScale(165)+
                  ResponsiveFlutter.of(context).fontSize(11.5),
              child: FutureBuilder(
                  future: spotlightList,
                  builder: (context,AsyncSnapshot<ProductModel> snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.value.content.length > 5
                              ? 5
                              : snapshot.data.value.content.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16,right: 16),
                          itemBuilder: (BuildContext context, int index) {
                            return productDisplayXL(context, snapshot.data.value.content[index]);
                          });
                    }
                    else return
                      ListView.builder(
                          itemCount:5,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16,right: 16),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: productShimmer(context)
                            );
                          });
                }
              ),
            )
  ])
  );
}