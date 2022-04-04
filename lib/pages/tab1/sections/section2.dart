import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/product_display_L_tile.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/modules/module1/products.dart';
import 'package:farm_direct/pages/view_all/all_bestsellers_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Widget bestSellers(BuildContext context,Future <ProductModel> bestsellersList) {

  TextStyle _styleHeader = TextStyle(
      fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
      fontWeight: FontWeight.w500,
      color: Color(colorText1));
  TextStyle _styleButton1 = TextStyle(
      fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,
      color: Color(colorText1));
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(tr('fd_mainpage_2_title'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: _styleHeader),
                ),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width:MediaQuery.of(context).size.width * 0.25,
                        alignment: Alignment.centerRight,
                        child: Text("fd_homw_viewAll_button", style: _styleButton1,
                          overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,
                          maxLines: 2,).tr(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                          radius:
                              ResponsiveFlutter.of(context).verticalScale(10),
                          backgroundColor: Theme.of(context).buttonColor,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size:
                                ResponsiveFlutter.of(context).verticalScale(12),
                            color: Colors.white,
                          ))
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Products()));
                  },
                )
              ],
            )),
        SizedBox(
          height: 15,
        ),
        Container(
          height: ResponsiveFlutter.of(context).verticalScale(175) +
              ResponsiveFlutter.of(context).fontSize(16),
          child: FutureBuilder(
              future: bestsellersList,
              builder: (context, AsyncSnapshot <ProductModel> snapshot) {
                if (snapshot.hasData && snapshot.data.value!=null){
                  return ListView.builder(
                      itemCount: snapshot.data.value.content.length > 5 ? 5 :
                      snapshot.data.value.content.length,
                      padding: EdgeInsets.only(left: 16,right: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return productDisplayXL(context, snapshot.data.value.content[index]);
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
        )
      ],
    ),
  );
}
