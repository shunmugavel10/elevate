import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/customer_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/Shimmer_update.dart';
import 'package:farm_direct/pages/common/category_display_Lgrid_tile.dart';
import 'package:farm_direct/pages/common/product_display_L_tile1.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/modules/module1/add_products.dart';
import 'package:farm_direct/pages/modules/module1/edit_products.dart';
import 'package:farm_direct/pages/modules/module1/product_detailed.dart';
import 'package:farm_direct/pages/modules/modules2/add_category.dart';
import 'package:farm_direct/pages/modules/modules2/category_detailed.dart';
import 'package:farm_direct/providers/categoryProvider.dart';

import 'package:farm_direct/providers/customerProvider.dart';
import 'package:farm_direct/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CategoryListing extends StatefulWidget {
  @override
  _CategoryListingState createState() => _CategoryListingState();
}

class _CategoryListingState extends State<CategoryListing> {

  ScrollController _scrollController = ScrollController();
  int type=1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        context.read<CategoryProvider>().nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));
    var _width = MediaQuery.of(context).size.width;
    var orientation =MediaQuery.of(context).orientation;

    return Container(height: double.infinity,

      child: Column(
          children: [
            Expanded(flex: 1, child: Container(height: 50,
              child: Row(children: [
                IconButton(onPressed: () {setState(() {
                  type=1;
                });}, icon: Icon(FeatherIcons.list,
                  color: type == 1 ? Color(secondary) : Color(secondaryGrey)),),
                IconButton(onPressed: () {
                  setState(() {
                    type=2;
                  });
                }, icon: Icon(FeatherIcons.grid),
                  color: type == 2 ? Color(secondary) : Color(secondaryGrey),),
                IconButton(onPressed: () {
                  setState(() {
                    type=3;
                  });
                }, icon: Icon(FeatherIcons.map),
                  color: type == 3 ? Color(secondary) : Color(secondaryGrey),)
              ],),),),
            Expanded(flex: 8,
              child: Scaffold(
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton:FloatingActionButton(
                  backgroundColor: Color(secondary),
                  child: Icon(Icons.add),
                  onPressed: ()async{
                    CategoryContent result=await Navigator.push(context,MaterialPageRoute(builder: (context)=>AddCategory()));
                    if(result != null){
                      context.read<CategoryProvider>().addData(result);
                    }},) ,
                body: Consumer<CategoryProvider>(
                                builder:(context,data,child){
                                if(data.homeState == HomeState.Loading){
                                return cardShimmer(context);}
                                else if(data.homeState== HomeState.Loaded) {
                                  return Container(child:
                                  type == 1 ? ListView.builder(
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      itemCount: data.categoryData.content.length,
                                      itemBuilder: (context, index) {
                                        return tile(context,
                                            data.categoryData.content[index], index);
                                      })
                                      : type == 2 ? StaggeredGridView.countBuilder(
                                    controller: _scrollController,
                                    crossAxisCount: Orientation.portrait == orientation ? 2 : 3,
                                    itemCount: data.categoryData.content.length,
                                    itemBuilder: (BuildContext context, int index) =>
                                       categoryDisplayLC (
                                            context, data.categoryData
                                            .content[index]),
                                    staggeredTileBuilder: (int index) =>
                                        StaggeredTile.fit(1),
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                  ) : Container());
                                }else {
                                  return Center(child:Text("No Data",style: _styleBody1,));
                                }
                                }),
              ),
            ),
          ]),
    );
  }
}


Widget tile(BuildContext context,CategoryContent categoryData,int index){
TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight: FontWeight.w500,color:Color(colorText1));
    var _width = MediaQuery.of(context).size.width;
    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));
        TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight: FontWeight.w500,color:Colors.white);

  Future<CategoryModel> deleteCategoryNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data = await _dio.then((value) async {
        response = await value.delete(url_get_category+"/"+categoryData.id);
        print(response.data);
        if (response.statusCode == 200 || response.statusCode == 201) {
       context.read<CategoryProvider>().deleteData(index);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast("Failed1");
    }
  }

  return Card(
    child: ListTile(
        leading: SizedBox(height: 50,width: 50,
          child: ClipRRect(borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              fit: BoxFit.cover ,useOldImageOnUrlChange: true,
              placeholder: (context, url) => SizedBox(width:40,height: 40,child: shimmerEffects(context)),
              errorWidget: (context, url, error) => Image.asset("assets/images/nav_bar_logo/homeal.png"),
              imageUrl: categoryData.thumbnail==null?"":
              categoryData.thumbnail.url,
            ),
          ),
        ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetailed(
          categoryData: categoryData)));
      },
      title: Text(categoryData.name.english,style: _styleBody2_1,),
      subtitle: Text(categoryData.name.english),
      trailing: SizedBox(width:55,
        child: Row(children: [
          // IconButton(
          //   icon: Icon(Icons.edit_outlined,size: 25,color: Color(secondary),),
          //   onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCategory(
          //       productData: productData,)));
          //   },),
          IconButton(
            icon: Icon(Icons.delete_rounded,size: 25,color: Color(secondary),),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                  builder: (context) {
                    return Container(
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Text("fd_delete_msg",style: _styleBody1,).tr(),
                          SizedBox(width: _width/2.5,height: _width/2.5,
                            child: CachedNetworkImage(
                              useOldImageOnUrlChange: true,
                              imageUrl:categoryData.thumbnail==null?"":
                              categoryData.thumbnail.url,
                              placeholder: (context, url) => shimmerEffects(context),
                              errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 50,color: Colors.grey.shade300,),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: _width/2.5,
                                    height: _width/2.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                            ),
                          ),
                        // ignore: deprecated_member_use
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              // ignore: deprecated_member_use
                              FlatButton(child: Text("fd_cancel_msg",style: _styleBody2_1.copyWith(color: Color(secondary)),).tr(),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color:Color(secondary))),
                                minWidth:120,
                                height: 45,
                                color: Colors.transparent,splashColor: Color(secondary),
                                onPressed: (){
                                  Navigator.pop(context);
                                },),
                              // ignore: deprecated_member_use
                              FlatButton(child: Text("fd_delete_button",style: _styleBody2_2.copyWith(color:Colors.white),).tr(),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                minWidth:120,
                                height: 45,
                                color: Color(secondary),splashColor: Colors.white,
                                onPressed: ()async {
                                deleteCategoryNetwork();
                                Navigator.pop(context);
                                },),
                            ]
                        ),
                      ],),
                    );
                  });
            },),
        ],),
      )
    ),
  );
}
