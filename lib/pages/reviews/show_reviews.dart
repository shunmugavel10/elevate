import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/reviews_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class ShowReviews extends StatefulWidget {
  final String id,itemType;
  final bool appbar;
  const ShowReviews({Key key, this.id, this.itemType, this.appbar,}) : super(key: key);
  @override
  _ShowReviewsState createState() => _ShowReviewsState();
}

class _ShowReviewsState extends State<ShowReviews> {
  Future <ReviewsModel> reviewsList;
  ScrollController _scrollController = ScrollController();
  int currentpage =-1,totalPage=2;

  Future<ReviewsModel> getReviewsNetwork() async {
    var data;
    if(totalPage>currentpage) {
      currentpage++;
      Response response;
      try {
        final _dio = apiClient();
         data = await _dio.then((value) async {
          response = await value.get(url_get_reviews,queryParameters: {
            "itemId": widget.id,
            "itemType":widget.itemType,
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if (currentpage == 0) {
              totalPage=ReviewsModel.fromJson(response.data).value.totalPages;
              return ReviewsModel.fromJson(response.data);
            }else {
              setState(() {
                List<ReviewContent> reviewContent = ReviewsModel.fromJson(response.data).value.content;
                reviewsList.then((value){
                  value.value.content.addAll(reviewContent);
                });
              });
            }
          } else {
            showtoast("Failed");
          }
        });
         return data;
      } catch (e) {
        showtoast("Failed");
      }
      return data;
    } else {
      showtoast("No more reviews");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewsList=getReviewsNetwork();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getReviewsNetwork();
      }
    });
  }

  @override
  Widget build(BuildContext context){

    var _width = MediaQuery.of(context).size.width;
  TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500,color:Color(colorText2));
  TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500,color:Color(colorText1));
  TextStyle _styleBody3_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w400,color:Color(colorText1));
  TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
      fontWeight: FontWeight.w500,color:Color(colorText2));

    return Scaffold(
      appBar: widget.appbar?AppBar(
        title: Text("fd_productDetailed_customerReviewsRatings_create_title").tr(),
      ):null,
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: FutureBuilder(
          future: reviewsList,
          builder: (context,AsyncSnapshot<ReviewsModel> snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasData && snapshot.data.value !=null)
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data.value.content.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.only(top:10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: _width,
                              child: Text(snapshot.data.value.content[index].feedback,
                                style: _styleBody3_1,),
                            ),
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
                );
              else return Center(child: Text("fd_productDetailed_customerReviewsRatings_msg",style: _styleBody2,).tr());
            }
            else return Container(height: 100,width: _width,child: shimmerEffects(context),);
          },
        ),
      ),
    );
  }
}
