import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
  return Container(width:155,
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
            child: Container(color: Colors.blueGrey,width:100,
            height: 80,),
          ),

          Container(color: Colors.white,height: 20,margin: EdgeInsets.only(top: 5),width:140,),
          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 5),width:50),
          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 5),width:50),
          Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 5),width:50),
          Container(color: Colors.white,height: 40,margin: EdgeInsets.only(top: 5),width:140),
        ],
      ),
      )
    ),
  );
}


// Widget productShimmer1(BuildContext context){
//   return Container(width:ResponsiveFlutter.of(context).scale(155),
//     decoration: BoxDecoration(
//         border: Border.all(color: Color(0xfff6f6f8), width: 2.0),
//         borderRadius: BorderRadius.circular(8.0)
//     ),padding: EdgeInsets.all(5),
//     child: Shimmer.fromColors(
//         period: Duration(milliseconds: 1500),
//         baseColor: Colors.grey.shade200,
//         highlightColor: Colors.grey.shade50,
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(color: Colors.blueGrey,width:ResponsiveFlutter.of(context).scale(100),
//                   height: ResponsiveFlutter.of(context).scale(100),),
//               ),
//
//               Container(color: Colors.white,height: 20,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(140),),
//               Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
//               Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
//               Container(color: Colors.white,height: 10,margin: EdgeInsets.only(top: 10),width:ResponsiveFlutter.of(context).scale(50),),
//               ],
//           ),
//         )
//     ),
//   );
// }


Widget cardShimmer(BuildContext context){
  var _width = MediaQuery.of(context).size.width;
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          width: _width,
          height: ((_width - 32) / 4.17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(
              left: 16, right: 16, top: 8),
          child: shimmerEffects(context),
        );
      });
}