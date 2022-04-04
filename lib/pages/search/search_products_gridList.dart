import 'package:farm_direct/pages/common/product_display_L_tile.dart';
import 'package:farm_direct/pages/detail/vendor_detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchProductsGridList extends StatefulWidget {
  @override
  _SearchProductsGridListState createState() => _SearchProductsGridListState();
}

class _SearchProductsGridListState extends State<SearchProductsGridList> {
  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: Orientation.portrait==orientation?2:3,
            itemCount: 16,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              child: productDisplayXL(context,snapshot.data),
              onTap: (){
                // Navigator.push(context,MaterialPageRoute(builder: (context)=>VendorDetailedView()));
              },
              ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
          );
        }
      ),
    );
  }
}
