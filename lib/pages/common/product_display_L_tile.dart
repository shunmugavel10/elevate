import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/detail/product_detailed_view.dart';
import 'package:farm_direct/pages/modules/module1/product_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'add_button.dart';
import 'favourite_button.dart';
import 'shimmers.dart';


Widget productDisplayXL (BuildContext context,ProductContent productData){


  TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
      fontWeight: FontWeight.w500, color:Color(colorText1));
  TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(colorText1));
  TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
      decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleBody6_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody6),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleBody6_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody6),
      fontWeight: FontWeight.w700,color:Color(colorText2));
  TextStyle _styleBody5_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody5),
      fontWeight: FontWeight.w500,color:Color(colorText1));

  return GestureDetector(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailed(
        productData: productData,
      )));
    },
    child: FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width:ResponsiveFlutter.of(context).scale(155),
        child: Stack(children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xfff6f6f8), width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(6,12,6,6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: CachedNetworkImage(
                          height: ResponsiveFlutter.of(context).scale(90),
                          width: ResponsiveFlutter.of(context).scale(120),
                          placeholder: (context, url) => shimmerEffects(context),
                          errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 50,color: Colors.grey.shade300,),
                          fit: BoxFit.contain,useOldImageOnUrlChange: true,
                          imageUrl:productData.thumbnail.url),
                  ),
                  SizedBox(height: ResponsiveFlutter.of(context).scale(20),),
                  SizedBox(width:ResponsiveFlutter.of(context).scale(160),
                      height: ResponsiveFlutter.of(context).fontSize(5),
                      child: Text(productData.name.english,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style:_styleHeader,
                      ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: ResponsiveFlutter.of(context).verticalScale(8),),
                    child: Text(
                      productData.unitPrices.first.measurementUnit.quantity.toString()+" kg",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _styleBody2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(top: ResponsiveFlutter.of(context).verticalScale(8),),
                            child: Text('₹ ${productData.unitPrices[0].salePrice.amount.value}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: _styleBody3,),
                          ),
                          Text('₹ ${productData.unitPrices[0].originalAmount.value}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _styleBody4,),
                        ],
                      ),
                      AddButton(productData: productData,),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      //color: Color(0xff000000),
                      color: Color(0xfff5f5f5),
                      borderRadius:
                      BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          useOldImageOnUrlChange: true,
                          imageUrl:"https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                width: ResponsiveFlutter.of(context).scale(20),
                                height: ResponsiveFlutter.of(context).verticalScale(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                        ),
                        FittedBox(fit: BoxFit.contain,
                          child: Container(
                            width:ResponsiveFlutter.of(context).scale(100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("fd_productDetailed_cultivatedSoldBy_title",
                                    maxLines:1,
                                    overflow: TextOverflow.ellipsis,
                                    style:_styleBody6_1).tr(),
                                Text(" ${productData.store.name}",
                                    maxLines:1,
                                    overflow: TextOverflow.ellipsis,
                                    style:_styleBody5_2),
                                Container(width: ResponsiveFlutter.of(context).scale(100),
                                  height:ResponsiveFlutter.of(context).scale(10),
                                  alignment:AlignmentDirectional.centerStart,
                                  child: FittedBox(
                                    child: RatingBarIndicator(
                                      rating: 4,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("2K Kg ${tr("fd_productDetailed_cultivatedSoldBy_subTitle")}",overflow: TextOverflow.ellipsis,
                                  style: _styleBody6_2,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.topRight,
            child:FavouriteButton(productId: productData.id,itemType: "PRODUCT",)
          )
        ]),
      ),
    ),
  );
}

