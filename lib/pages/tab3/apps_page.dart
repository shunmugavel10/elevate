import 'package:farm_direct/pages/common/app_card.dart';
import 'package:farm_direct/pages/modules/module1/products.dart';
import 'package:farm_direct/pages/modules/module1/products_list.dart';
import 'package:farm_direct/pages/modules/module4/coupons.dart';
import 'package:farm_direct/pages/modules/module5/vendors.dart';
import 'package:farm_direct/pages/modules/module6/customer.dart';
import 'package:farm_direct/pages/modules/modules2/Category.dart';
import 'package:farm_direct/pages/modules/modules2/category_list.dart';
import 'package:farm_direct/pages/modules/modules3/orders.dart';
import 'package:farm_direct/pages/tab2/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AppsPage extends StatefulWidget {

  @override
  _AppsPageState createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {

  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var orientation =MediaQuery.of(context).orientation;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StaggeredGridView.count(
          controller: _scrollController,
          crossAxisCount: 4,
          crossAxisSpacing: 1.0,
          shrinkWrap: true,
          mainAxisSpacing: 1.0,
          children: [
            GestureDetector(child: appCard(context,"fd_app_title1"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Products()));
            },),
            GestureDetector(child: appCard(context,"fd_app_title7"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Category()));
            },),
            GestureDetector(child: appCard(context,"fd_app_title3"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Vendors()));
            },
            ),
            appCard(context,"fd_app_title4"),
            GestureDetector(child: appCard(context,"fd_app_title8"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Orders()));
            },),
            GestureDetector(child: appCard(context,"fd_app_title9"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Coupons()));
            },),
            GestureDetector(child: appCard(context,"fd_app_title10"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Customer()));
            },),
          ],
          staggeredTiles:<StaggeredTile> [
            StaggeredTile.count(1,1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
          ]
        ),
      )
    );
  }
}
