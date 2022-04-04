import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/product_display_S_tile.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/view_all/all_deal_of_the_week_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

Widget dealsOfTheWeek (BuildContext context,Future <ProductModel> dealsOfTheWeek){

  var _width = MediaQuery.of(context).size.width;

  TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
      fontWeight: FontWeight.w500, color:Color(colorText3));
  TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(colorText3));
  TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(0xffEEFFBE));

  return Container(
    width:_width,
    color: Color(0xff9DBB46),
    child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        tr('fd_mainpage_4_title'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:_styleHeader
                    ),
                      Text(
                          tr('fd_mainpage_4_sub_title'),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:_styleBody2
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
                      CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(10),backgroundColor:Color(colorText3),
                          child: Icon(Icons.arrow_forward_ios,size:ResponsiveFlutter.of(context).verticalScale(12),
                            color: Color(0xff9DBB46),))
                    ],),
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AllDealsOfTheWeek(dealsOfTheWeekList: dealsOfTheWeek,)));
                  },)
              ],
            )),
        SizedBox(height: 15,),
        FutureBuilder(
          future: dealsOfTheWeek,
          builder: (context,AsyncSnapshot<ProductModel> snapshot){
            if(snapshot.hasData)
              return SizedBox( height: ResponsiveFlutter.of(context).scale(240),width:_width,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 16,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  itemBuilder: (BuildContext context, int index) =>
                      productDisplayS(context,index,snapshot.data.value.content[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  scrollDirection: Axis.horizontal,
                ),
              );
            else return SizedBox( height: ResponsiveFlutter.of(context).scale(240),width:_width,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: 16,
                padding: EdgeInsets.only(left: 16,right: 16),
                itemBuilder: (BuildContext context, int index) => shimmerEffects(context),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                scrollDirection: Axis.horizontal,
              ),
            ); 
          },
        ),
        SizedBox(height: 15,),
      ],
    ),
  );
}