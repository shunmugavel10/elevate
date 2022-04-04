import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/add_button.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/favourite_button.dart';
import 'package:farm_direct/pages/common/product_display_L_tile1.dart';
import 'package:farm_direct/pages/common/rating_bar.dart';
import 'package:farm_direct/pages/common/reviews.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/slider.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/reviews/create_reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:video_player/video_player.dart';
import 'vendor_detailed_view.dart';

class ProductDetailedView extends StatefulWidget {

  final ProductContent productData;

  const ProductDetailedView({Key key, this.productData}) : super(key: key);
  @override
  _ProductDetailedViewState createState() => _ProductDetailedViewState();
}

class _ProductDetailedViewState extends State<ProductDetailedView> {

  ProductContent productData;
  PageController _pageController=PageController();
  List<Widget> images=[];
  int type=1;

  addImage(){
    for(int i=0;i<widget.productData.thumbnail.images.length;i++){
      images.add(CachedNetworkImage(
          fit: BoxFit.contain,useOldImageOnUrlChange: true,
          placeholder: (context, url) => shimmerEffects(context),
          errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 70,),
          imageUrl:widget.productData.thumbnail.images[i]),);
    }
    //images.add(player(context));
  }
  Widget player(BuildContext context){
    return  Stack(
      children:[
        Container(height: 200,width: 500,
          alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: controller !=null
            ? VideoPlayer(controller) : Container(child: CircularProgressIndicator(),),
      ),
        GestureDetector(
          child:Container(width: 500,height: 200,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: controller.value.isPlaying ? Container(
            child:Text("") ): Container(color: Colors.black.withOpacity(0.5),
            child: Icon( Icons.play_arrow,size: 40,color: Color(secondary),),),
          ),
          onTap: (){
            setState(() {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            });
          },
        )
    ]);
  }

  VideoPlayerController controller;

 Future<ProductModel> getProductBasedOnStoreIdNetwork(String id) async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_products,queryParameters: {
          "storeId":id,
        });
        if (response.statusCode == 200) {
          return ProductModel.fromJson(response.data);
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
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/sample.mp4")
        // 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => setState(() {}));
    productData=widget.productData;
    addImage();
  }

  @override
  Widget build(BuildContext context) {


   // List <Widget> review_list=[review(context),review(context),review(context)];
    var _width =MediaQuery.of(context).size.width;

    TextStyle _styleHeader2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader2),
        fontWeight: FontWeight.w500, color:Color(colorText1));
    TextStyle _styleHeader3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
        fontWeight: FontWeight.w500, color:Color(colorText1));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody2_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Colors.white);
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody3_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody5_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody5),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(secondary));


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          cart(context)
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                IconButton(
                    color:  Colors.grey,
                    icon: type==1?Icon(FeatherIcons.video): Icon(FeatherIcons.videoOff), onPressed: (){
                  setState(() {
                    type=type==1?2:1;
                    type==1?controller.pause():controller.play();
                  });
                })
              ],),
            type==1?Stack(children:[
              slider(context, _pageController,images,),
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.topRight,
                  child:FavouriteButton(productId: productData.id,itemType: "PRODUCT",)
              )
            ]):player(context),
            SizedBox(height: 10,),
            type==1?Center(child: indicator(context,_pageController, widget.productData.thumbnail.images.length)):
            SizedBox(),
            SizedBox(height: 30,),
             Text(productData.name.english,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style:_styleHeader2,
          ),
        Padding(
          padding: const EdgeInsets.only(top:15),
          child: Text(
            '500 g',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _styleBody1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(crossAxisAlignment:CrossAxisAlignment.center,
                  children:[
                    Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0,0, 10, 0),
                    child: Text('₹ ${productData.unitPrices[0].salePrice.amount.value}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _styleBody2,),
                  ),
                    Text('₹ ${productData.unitPrices[0].originalAmount.value}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _styleBody3,),
                ]),
              ],
            ),
            AddButton(productData:productData,),
          ],
        ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,15),
              child: Divider(thickness: 10,color: Color(0xffF2F2F2),),
            ),
            Text(
              'fd_productDetailed_product_description_title',
              overflow: TextOverflow.ellipsis,
              style:_styleHeader3,
            ).tr(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(width: _width,
                child: Text(productData.details.english,
                  //'A banana is an elongated, edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa. In some countries, bananas used for cooking may be called “plantains”, distinguishing them from dessert bananas. … The fruits grow in clusters hanging from the top of the plant.',
                  style:_styleBody2_1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: ResponsiveFlutter.of(context).verticalScale(100),width: _width,
            child: ListView.builder(
              itemCount: 3,scrollDirection: Axis.horizontal,
                itemBuilder:(context,index){
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                  CircleAvatar(radius:ResponsiveFlutter.of(context).verticalScale(30),
                    child: Image.asset("assets/images/Group 64196.png"),),
                  Text('vegan',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _styleBody5_2,),
                ]),
              );
            }),),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,15),
              child: Divider(thickness: 10,color: Color(0xffF2F2F2),),
            ),
            Text("fd_productDetailed_cultivatedSoldBy_title",
                maxLines:1,
                overflow: TextOverflow.ellipsis,
                style:_styleHeader3).tr(),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    useOldImageOnUrlChange: true,
                    imageUrl: "https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          width: ResponsiveFlutter.of(context).scale(50),
                          height: ResponsiveFlutter.of(context).verticalScale(50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover),
                          ),
                        ),
                  ),
                  Container(
                    width: _width*0.75,
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData.store.name.english,
                            maxLines:1,
                            overflow: TextOverflow.ellipsis,
                            style:_styleBody2),
                        Container(width: ResponsiveFlutter.of(context).scale(100),
                          height:ResponsiveFlutter.of(context).verticalScale(15),
                          alignment:AlignmentDirectional.centerStart,
                          child:ratingBar(context,secondary)
                        ),
                        TextButton(child: Text("fd_productDetailed_view_profile_button",style:_styleButton1,).tr(),
                            style:ButtonStyle(),
                            onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>VendorDetailedView(
                            storeId: productData.store.id,storeName: productData.store.name.english,
                          )));
                        }),
                        SizedBox(height: 10,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,15),
              child: Divider(thickness: 10,color: Color(0xffF2F2F2)),
            ),
            Text("fd_productDetailed_otherCultivationsFrom_title",
                maxLines:1,
                overflow: TextOverflow.ellipsis,
                style:_styleHeader3).tr(),
            Container(
              height: ResponsiveFlutter.of(context).verticalScale(160)+
                  ResponsiveFlutter.of(context).fontSize(11),
              child: FutureBuilder(
                  future: getProductBasedOnStoreIdNetwork(widget.productData.store.id),
                  builder: (context,AsyncSnapshot<ProductModel> snapshot) {
                    if(snapshot.hasData)
                  return ListView.builder(
                      itemCount: snapshot.data.value.content.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                            child: productDisplayL(context,snapshot.data.value.content[index]));
                      });
                    else return
                      ListView.builder(
                          itemCount:5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: productShimmer(context)
                            );
                          });

                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,15),
              child: Divider(thickness: 10,color: Color(0xffF2F2F2),),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SizedBox(width: _width*0.5,
                child: Text("fd_productDetailed_customerReviewsRatings_title",
                    maxLines:2,
                    overflow: TextOverflow.ellipsis,
                    style:_styleHeader3).tr(),
              ),
              // ignore: deprecated_member_use
              FlatButton(child: SizedBox(width: 80,
                child: Text("fd_productDetailed_customerReviewsRatings_button3",
                  overflow: TextOverflow.ellipsis,
                  style: _styleBody2_3,).tr(),
              ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(secondary))),
                minWidth:80,
                height: ResponsiveFlutter.of(context).verticalScale(30),
                color: Color(secondary),
                onPressed: () async {
                  bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewsRatings(
                    id: productData.id,name: productData.name.english,imgUrl: productData.thumbnail.images[1],
                  )));if(result==true){
                    setState(() {
                      result=false;
                    });
                  }
                },),
            ],),
            SizedBox(height: 25,),
            // Column(
            //   children: review_list.map((oneCard){
            //     return oneCard;
            //   }).toList(),
            // ),
            review(context, productData.id),
            SizedBox(height: 10,),
            Divider(thickness: 10,color: Color(0xffF2F2F2),),
            Text("fd_productDetailed_importantInformation_title",
                maxLines:1,
                overflow: TextOverflow.ellipsis,
                style:_styleHeader3).tr(),
            SizedBox(height: 10,),
            Text("fd_productDetailed_importantInformation_body",
                style:_styleBody3_2).tr(),
            SizedBox(height: 10,),
          ]),
      )
    );
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
