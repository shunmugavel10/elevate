import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/product_display_L_tile1.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class AllSpotlightPage extends StatefulWidget {
  final Future<ProductModel> spotlightList;

  const AllSpotlightPage({Key key, this.spotlightList}) : super(key: key);
  @override
  _AllSpotlightPageState createState() => _AllSpotlightPageState();
}

class _AllSpotlightPageState extends State<AllSpotlightPage> {

  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w500,color:Color(colorText1));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("fd_mainpage_6_title",style: _styleBody1,).tr(),
              Text('fd_vendorDetailed_products_title',style: _styleButton1,).tr(),
            ]),
        actions: [
          search(context),
          cart(context)
        ],
      ),
      body:FutureBuilder(
          future: widget.spotlightList,
          builder: (context,AsyncSnapshot<ProductModel> snapshot) {
            if(snapshot.hasData)
              return StaggeredGridView.countBuilder(
                crossAxisCount: Orientation.portrait==orientation?2:3,
                itemCount: snapshot.data.value.content.length,
                itemBuilder: (BuildContext context, int index) =>
                    productDisplayL(context,snapshot.data.value.content[index]),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              );
            else return
              StaggeredGridView.countBuilder(
                crossAxisCount: Orientation.portrait==orientation?2:3,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: productShimmer(context)
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              );
          }
      ),
    );
  }
}
