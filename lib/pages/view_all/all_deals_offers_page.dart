import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shimmer/shimmer.dart';

class DealsOffersAllPage extends StatefulWidget {
  final Future <CouponModel> bannerList;

  const DealsOffersAllPage({Key key, this.bannerList}) : super(key: key);
  @override
  _DealsOffersAllPageState createState() => _DealsOffersAllPageState();
}

class _DealsOffersAllPageState extends State<DealsOffersAllPage> {


  @override
  Widget build(BuildContext context) {

    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Text("fd_all_deals_offers_title").tr(),
        actions: [
          search(context),
          cart(context)
        ],
      ),
      body: FutureBuilder(
          future: widget.bannerList,
          builder: (BuildContext context, AsyncSnapshot<CouponModel> snapshot) {
            if (snapshot.hasData) {
              List<CouponContent> list = snapshot.data.value.content;
              return Container(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context,index) {
                      return Container(
                        height: _width/2.5,
                        width:_width,
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,useOldImageOnUrlChange: true,
                            imageUrl: list[index].image,
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
                    }),
              );
            } else if (snapshot.hasError == true) {
              return Text("Error");
            } else {
              return Container(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 14, 0),
                        child: Container(
                          width:_width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Shimmer.fromColors(
                              baseColor: Color(0xffE0E0E0),
                              highlightColor: Color(0xffF1F1F1),
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}
