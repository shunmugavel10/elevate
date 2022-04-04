import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/model/store_model.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/vendor_display_L.dart';
import 'package:farm_direct/pages/detail/vendor_detailed_view.dart';
import 'package:farm_direct/pages/view_all/all_vendors_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Widget vendorsAroundYou(BuildContext context, Future<StoreModel> storeList){

  var _width = MediaQuery.of(context).size.width;
  TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
      fontWeight: FontWeight.w500, color:Color(colorText1));
  TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(colorText1));

  return Container(
    child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.55,
                  child: Text(
                      tr('fd_mainpage_5_title'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:_styleHeader
                  ),
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
                  onTap:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AllVendorsListingPage(
                      storeData: storeList,
                    )));
                  },)
              ],
            )),
        SizedBox(height: 15,),
        Container(
          height:ResponsiveFlutter.of(context).scale(200),
          width:_width,
          child: FutureBuilder(
            future: storeList,
            builder: (context,AsyncSnapshot<StoreModel> snapshot){
              if(snapshot.hasData)
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.value.storeContent.length>10?10:
                  snapshot.data.value.storeContent.length,
                  padding: EdgeInsets.only(left: 8,right: 8),
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorDetailedView(
                            storeId: snapshot.data.value.storeContent[index].id,
                            storeName: snapshot.data.value.storeContent[index].name,
                          )));
                        },
                        child: vendorDisplayL(context,snapshot.data.value.storeContent[index]));
                  });
              else return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  itemBuilder: (context,index){
                    return Container(
                      width: ResponsiveFlutter.of(context).scale(60),
                      height: ResponsiveFlutter.of(context).verticalScale(60),
                      child: shimmerEffects(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    );
                  });
            },
          ),
        )
      ],
    ),
  );
}