import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/detail/product_detailed_view.dart';
import 'package:farm_direct/pages/modules/modules2/category_detailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'add_button.dart';
import 'favourite_button.dart';
import 'shimmers.dart';

Widget categoryDisplayLC (BuildContext context,CategoryContent categoryData){

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
      Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryDetailed(
        categoryData: categoryData,
      )));
    },
    child: FittedBox(
      child: Container(
        width:ResponsiveFlutter.of(context).scale(160),
        child: Stack(children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xfff6f6f8), width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0.0,
            child: Padding(
              padding: EdgeInsets.all(12),
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
                          imageUrl: categoryData.thumbnail.url //"https://pngimg.com/uploads/banana/banana_PNG827.png"
                      ),
                    ),
                 SizedBox(height: ResponsiveFlutter.of(context).scale(30),),
                 SizedBox(width:ResponsiveFlutter.of(context).scale(160),
                      height: ResponsiveFlutter.of(context).fontSize(5),
                          child: Text(categoryData.name.english,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:_styleHeader,
                          ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8),
                  //   child: Text(
                  //     '500 g',
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: _styleBody2,
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Padding(
                  //           padding:
                  //           const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  //           child: Text('₹ ${productData.unitPrices[0].salePrice.amount.value}',
                  //             maxLines: 1,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: _styleBody3,),
                  //         ),
                  //         Text('₹ ${productData.unitPrices[0].originalAmount.value}',
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style: _styleBody4,),
                  //       ],
                  //     ),
                  //     AddButton(productData: productData,),
                  //   ],
                  // ),
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

