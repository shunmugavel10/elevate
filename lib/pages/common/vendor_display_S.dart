import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Widget vendorDisplayS(BuildContext context,StoreContent storeData){

  return  Container(
    margin: EdgeInsets.only(left: 8,right: 8),
    child: CachedNetworkImage(
      useOldImageOnUrlChange: true,
      imageUrl:
      "https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
      imageBuilder: (context, imageProvider) =>
          Container(
            width: ResponsiveFlutter.of(context).scale(60),
            height: ResponsiveFlutter.of(context).verticalScale(60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover),
            ),
          ),
    ),
  );
}