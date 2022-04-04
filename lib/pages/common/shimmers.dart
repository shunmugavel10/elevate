import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

Widget shimmerEffects(BuildContext context){
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.grey.shade50,
    child: Container(
      color: Colors.grey,
    ),
  );
}


Widget productShimmer(BuildContext context){
  return Container(width:ResponsiveFlutter.of(context).scale(155),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xfff6f6f8), width: 2.0),
      borderRadius: BorderRadius.circular(8.0)
    ),padding: EdgeInsets.all(5),
    child: Shimmer.fromColors(
      period: Duration(milliseconds: 1500),
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(color: Colors.blueGrey,width:ResponsiveFlutter.of(context).scale(100),
            height: ResponsiveFlutter.of(context).scale(80),),
          ),

          Container(color: Colors.white,height: 20,margin: EdgeInsets.only(top: 5),width:ResponsiveFlutter.of(context).scale(140),),
          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 5),width:ResponsiveFlutter.of(context).scale(50),),
          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 5),width:ResponsiveFlutter.of(context).scale(50),),
          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 5),width:ResponsiveFlutter.of(context).scale(50),),
          Container(color: Colors.white,height: 40,margin: EdgeInsets.only(top: 5),width:ResponsiveFlutter.of(context).scale(140),),
        ],
      ),
      )
    ),
  );
}


Widget productShimmer1(BuildContext context){
  return Container(width:ResponsiveFlutter.of(context).scale(155),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xfff6f6f8), width: 2.0),
        borderRadius: BorderRadius.circular(8.0)
    ),padding: EdgeInsets.all(5),
    child: Shimmer.fromColors(
        period: Duration(milliseconds: 1500),
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade50,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(color: Colors.blueGrey,width:ResponsiveFlutter.of(context).scale(100),
                  height: ResponsiveFlutter.of(context).scale(100),),
              ),

              Container(color: Colors.white,height: 20,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(140),),
              Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
              Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
              Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
              ],
          ),
        )
    ),
  );
}
