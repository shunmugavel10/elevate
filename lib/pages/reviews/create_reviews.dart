import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/slider.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class ReviewsRatings extends StatefulWidget {
  final String id, name, imgUrl;

  const ReviewsRatings({Key key, this.id, this.name, this.imgUrl}) : super(key: key);
  @override
  _ReviewsRatingsState createState() => _ReviewsRatingsState();
}

class _ReviewsRatingsState extends State<ReviewsRatings> {

  double ratingValue=0;
  int index=0;
  PageController _pageController=PageController();
  TextEditingController reviewController=TextEditingController();
  bool loading = false;
  File _image;
  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image= File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<dynamic> postReviewNetwork() async {

    Response response;
    try {
      List<String> userData=await getStoreData();
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.post(url_get_reviews,data: {
          "itemId": widget.id,
          "itemType": "EXPENSE",
          "rating": "THUMB_UP",
          "feedback": reviewController.text,
          "ratingZeroToFive": ratingValue.toInt(),
          "reviewStatus": "RATED",
          "reviewer": {
            "userId": userData[0]??"",
            "profileUrl": userData[2]??"",
            "userName": userData[1]??"",
            "createdAt": DateTime.now().toString()
          },
        });
        if (response.statusCode == 201) {
          Navigator.pop(context,true);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("fd_productDetailed_customerReviewsRatings_create_title").tr(),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
          height:50,alignment: Alignment.center,
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            index==1?TextButton(child: Text("fd_productDetailed_customerReviewsRatings_button1").tr(),onPressed: ()async{
              _image=getImage();
            },):SizedBox(),
            indicator(context,_pageController,2),
              index==1&&loading==false?TextButton(child: Text("fd_account_manage_savebutton").tr(),
                onPressed: (){
                setState(() {
                  loading=true;
                });
                  postReviewNetwork();
            },):SizedBox(),
          ],)),
      body: loading?LinearProgressIndicator():PageView(
        controller: _pageController,
        children: [
          setRatings(context,_pageController),
          setReviews(context)
        ],
        onPageChanged: (int page){
          setState(() {
            index=page;
          });
        },
      ),
    );
  }

  Widget setRatings(BuildContext context,PageController controller){

    var _width= MediaQuery.of(context).size.width;
    TextStyle _styleHeader2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
        fontWeight: FontWeight.w500, color:Color(colorText1));
    TextStyle _styleHeader1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w500, color:Color(colorText1));
    TextStyle _styleHeader1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w400, color:Color(colorText1));
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(width: _width*0.35,height: _width*0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,useOldImageOnUrlChange: true,
                    placeholder: (context, url) => shimmerEffects(context),
                    errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 70,),
                    imageUrl:widget.imgUrl),
              ),
            ),
            SizedBox(height: 10,),
            Text(widget.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,textAlign: TextAlign.center,
              style:_styleHeader1,
            ),
            SizedBox(height: 50,),
            Text("fd_productDetailed_customerReviewsRatings_create_subTitle",style: _styleHeader2,
                textAlign: TextAlign.center).tr(),
            SizedBox(height: 15,),
            Text("fd_productDetailed_customerReviewsRatings_create_subTitle1",style: _styleHeader1_1,
                textAlign: TextAlign.center).tr(),
            SizedBox(height: 30,),
            RatingBar.builder(
              initialRating: ratingValue,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(secondary),
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  ratingValue=rating;
                  controller.nextPage(duration: Duration(milliseconds:700), curve: Curves.fastOutSlowIn);
                });

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget setReviews(BuildContext context){

    TextStyle _styleHeader1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w500, color:Color(colorText1));
   TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
       fontWeight: FontWeight.w600,color:Color(colorText1));
   TextStyle _styleBody2_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
       letterSpacing: 1.0, fontWeight: FontWeight.w400,color:Color(colorText2));
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      child: Column(
        children: [
          ListTile(
            leading:  SizedBox(width: 70,height:70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,useOldImageOnUrlChange: true,
                    placeholder: (context, url) => shimmerEffects(context),
                    errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 70,),
                    imageUrl:widget.imgUrl),
              ),
            ),
            title: Text(widget.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:_styleHeader1,
            ),
            subtitle: SizedBox(height: 20,
              child: Align(alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: RatingBarIndicator(
                    rating: ratingValue,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Color(secondary),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            controller:reviewController,
            cursorColor: Color(secondary),
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            style:_styleBody2_2,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: tr("fd_productDetailed_customerReviewsRatings_create_textfieldHint"),
              hintStyle: _styleBody2_3,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green,width: 2,style: BorderStyle.solid),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey,width:1,style: BorderStyle.solid),
              ),
            ),
            enableInteractiveSelection: true,
          ),

        ],
      ),
    );
  }

}
