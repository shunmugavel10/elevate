import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/pages/detail/product_detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'favourite_button.dart';
import 'shimmers.dart';

Widget productDisplayS(BuildContext context,int value,ProductContent productData){

  TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight: FontWeight.w500,color:Color(0xffFFFFFF));

  return GestureDetector(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailedView(
        productData: productData,
      )));
    },
    child: FittedBox(
      child: Container(
          width:  ResponsiveFlutter.of(context).scale(120),
          height:ResponsiveFlutter.of(context).scale(120),
          child: Stack(
            children:[
              Container(
              width:  ResponsiveFlutter.of(context).scale(120),
              height:ResponsiveFlutter.of(context).scale(110),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color://value.isOdd?
                Color(0xffFFFFFF)
                // :Color(0xffB3D550)
              ),
                child: Center(
                  child: CachedNetworkImage(
                      height: ResponsiveFlutter.of(context).scale(80),
                      width: ResponsiveFlutter.of(context).scale(80),
                      placeholder: (context, url) => shimmerEffects(context),
                      errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 50,color: Colors.grey.shade300,),
                      useOldImageOnUrlChange: true,
                      fit: BoxFit.contain,
                      imageUrl:productData.thumbnail.url),//"https://pngimg.com/uploads/banana/banana_PNG827.png"
                ),
            ),
              Align(alignment: AlignmentDirectional.bottomCenter,
              child: SizedBox(width:ResponsiveFlutter.of(context).scale(90),
                child: Image.asset(//value.isOdd?
                "assets/images/deals_images/Group 64142.png"
                  //  :"assets/images/deals_images/Group 64133.png"
                  ,fit: BoxFit.contain,),
              ),),
              Align(alignment: AlignmentDirectional.bottomCenter,
                child: SizedBox(width:ResponsiveFlutter.of(context).scale(60),
                  child:Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text("20% off",style: //value.isOdd?
                    _styleBody2_2
                    //    :_styleBody2_1,
                    ),
                  )
                ),),
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