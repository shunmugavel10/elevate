import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/store_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/detail/vendor_detailed_view.dart';
import 'favourite_button.dart';
import 'shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

Widget vendorDisplayL (BuildContext context,StoreContent storeData){


  var _width =MediaQuery.of(context).size.width;
  TextStyle _styleHeader3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
      fontWeight: FontWeight.w500, color:Color(colorText1));
  TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleButton =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(secondary));
  return Container(
    width: _width*0.4,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xfff6f6f8),width:4.0)
    ),
    child:Stack(
      children:[
        Column(
        children: [
          SizedBox(height: ResponsiveFlutter.of(context).scale(100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                  fit: BoxFit.cover ,useOldImageOnUrlChange: true,
                  placeholder: (context, url) => shimmerEffects(context),
                  errorWidget: (context, url, error) => Icon(
                    FeatherIcons.image,size: 50,color: Colors.grey.shade300,),
                  imageUrl: storeData.imageUrl??"",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width:_width*0.55,
                  child: Text(storeData.name??"",style: _styleHeader3,
                    maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,),
                ),
                SizedBox(height:4,),
                SizedBox(width:_width*0.55,
                  child: Text("20 ${tr("fd_vendorDetailed_products_title")}",style: _styleBody2_1,
                    maxLines:1,overflow: TextOverflow.ellipsis,),
                ),
                TextButton(child:Text("fd_all_vendorsListing_viewFarmer_button",
                textAlign: TextAlign.start,
                style: _styleButton,).tr(),onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>VendorDetailedView(
                    storeId: storeData.id,storeName: storeData.name,
                  )));
                },)
                // Container(width: ResponsiveFlutter.of(context).scale(100),
                //     height:ResponsiveFlutter.of(context).verticalScale(15),
                //     alignment:AlignmentDirectional.centerStart,
                //     child:rating_bar(context,0xffFFC107)
                // ),
              ],),
          )
        ],
      ),
        Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.topRight,
            child:FavouriteButton(productId: storeData.id,itemType: "STORE",)
        )
    ]) ,
  );
}