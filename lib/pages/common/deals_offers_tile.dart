import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shimmer/shimmer.dart';

Widget dealsOffersTile (BuildContext context,CouponContent data){

  return Container(
    height: ResponsiveFlutter.of(context).scale(140),
    width:ResponsiveFlutter.of(context).scale(230),
    margin:EdgeInsets.only(right: 8),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: CachedNetworkImage(
        fit: BoxFit.cover,useOldImageOnUrlChange: true,
        imageUrl: data.image,
        placeholder: (context, url) {
          return Shimmer.fromColors(
            baseColor: Color(0xffE0E0E0),
            highlightColor: Color(0xffF1F1F1),
            child: Container(color: Colors.grey,),
          );
        },
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ),
  );
}