import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'size_colors.dart';

  Widget slider(BuildContext context,PageController pageController,List<Widget> images) {
    var _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width, height: ResponsiveFlutter.of(context).verticalScale(200),
      padding: EdgeInsets.only(bottom: 15),
      child: PageView(
            controller: pageController,
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            children: images,
          ));
  }


Widget indicator(BuildContext context,_controller,int len){
  return SizedBox(height: 1,
    child: SmoothPageIndicator(
        controller: _controller,  // PageController
        count:len == null || len == 0 ? 1 : len,
        effect: ExpandingDotsEffect(
        spacing:  8.0,
        radius:  8.0,
        dotWidth:  10.0,
        dotHeight:  10.0,
        paintStyle:  PaintingStyle.fill,
        strokeWidth:  1.5,
        dotColor:  Colors.grey.shade300,
        activeDotColor:  Color(secondary)
    ),
    ),
  );

}