import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget ratingBar(BuildContext context,int code){

  return  FittedBox(
    child: RatingBarIndicator(
      rating: 3,
      direction: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(code),
      ),
    ),
  );
}