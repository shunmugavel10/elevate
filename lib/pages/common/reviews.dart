import 'package:farm_direct/model/reviews_model.dart';
import 'package:farm_direct/pages/reviews/show_reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'shimmers.dart';
import 'toast_msg.dart';


Widget review(BuildContext context,String id,){

  var _width = MediaQuery.of(context).size.width;

  TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(colorText1));
  TextStyle _styleBody3_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w400,color:Color(colorText1));
  TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
      fontWeight: FontWeight.w500,color:Color(colorText2));

  getReviewsNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = await _dio.then((value) async {
        response = await value.get(url_get_reviews,queryParameters: {
          "itemId": id,
          "itemType":"EXPENSE",
        });
        if (response.statusCode == 200)
          return ReviewsModel.fromJson(response.data);
        else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }

  return Container(
    child: FutureBuilder(
      future: getReviewsNetwork(),
      builder: (context,AsyncSnapshot<ReviewsModel> snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData && snapshot.data.value !=null)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Container(height:snapshot.data.value.content.length>3?80*3.0
                  :80*snapshot.data.value.content.length.toDouble(),
                    child: ListView.builder(
                      itemCount: snapshot.data.value.content.length>3?3:snapshot.data.value.content.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.only(top:10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data.value.content[index].feedback,maxLines: 2,
                                  style: _styleBody3_1,overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 6,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            useOldImageOnUrlChange: true,
                                            imageUrl:
                                            "https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
                                            imageBuilder: (context, imageProvider) =>
                                                Container(
                                                  width: ResponsiveFlutter.of(context).scale(28),
                                                  height: ResponsiveFlutter.of(context).verticalScale(28),
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
                                              width:_width*0.5,
                                              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data.value.content[index].reviewer.userName,
                                                      maxLines:1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style:_styleBody3),
                                                  Text( DateFormat.yMMMEd().format(DateTime.parse(snapshot.data.value.content[index].reviewer.createdAt)),//"11 june, 2020, 04:50 am",
                                                      maxLines:1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style:_styleBody4),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(width: ResponsiveFlutter.of(context).scale(70),
                                        height:ResponsiveFlutter.of(context).verticalScale(20),
                                        alignment:AlignmentDirectional.centerStart,
                                        child: FittedBox(
                                          child: RatingBarIndicator(
                                            rating: snapshot.data.value.content[index].ratingZeroToFive.toDouble(),
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                Divider(thickness: 0.3,)
                              ]),
                        );
                      },
                    ),
                  ),
                  Align(alignment: Alignment.centerRight,
                      child: TextButton(child: Text("fd_productDetailed_customerReviewsRatings_button2").tr(),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowReviews(id: id,
                            itemType:"EXPENSE",appbar: true,)));
                      },))
                ]);
          else return Center(child: Text("fd_productDetailed_customerReviewsRatings_msg",style: _styleBody2,).tr());
        }
        else return Container(height: 100,width: _width,child: shimmerEffects(context),);
      },
    ),
  );
}

