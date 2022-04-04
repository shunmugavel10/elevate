import 'package:dio/dio.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/product_display_L_tile.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AllProductListingByCategory extends StatefulWidget {
  final String categoryId;
  final CategoryModel categoryData;
  final int index;

  const AllProductListingByCategory({Key key, this.categoryId, this.categoryData, this.index}) : super(key: key);
  @override
  _AllProductListingByCategoryState createState() => _AllProductListingByCategoryState();
}

class _AllProductListingByCategoryState extends State<AllProductListingByCategory> {

  bool filter =false;
  ScrollController _scrollController = ScrollController();
  int currentpage =-1,totalPage=1;
  Future <ProductModel> categoryBasedProductList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBasedProductList=getCategoryBasedProductNetwork();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getCategoryBasedProductNetwork();
      }
    });
  }

  Future<ProductModel> getCategoryBasedProductNetwork() async {
    if((totalPage-1)>currentpage) {
      currentpage++;
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response =await value.get(url_get_products,queryParameters: {
            "categoryId":widget.categoryId.toString(),
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
              if(currentpage==0){
                totalPage=ProductModel.fromJson(response.data).value.totalPages;
                return ProductModel.fromJson(response.data);
              }else{
                setState(() {
                  List<ProductContent> productContent = ProductModel.
                  fromJson(response.data).value.content;
                  categoryBasedProductList.then((value) {
                    value.value.content.addAll(productContent);
                  });
                });
              }
          } else {
            showtoast("Failed");
          }
        });
        return data;
      } catch (e) {
        // showtoast("Failed");
      }
    } else {
      showtoast("No more products");
    }
  }

  @override
  Widget build(BuildContext context) {

    var orientation =MediaQuery.of(context).orientation;

    TextStyle _styleHeader = TextStyle(
        fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
        fontWeight: FontWeight.w500,
        color: Color(colorText1));
    TextStyle _styleBody3 = TextStyle(
        fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,
        color: Color(secondary));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: ResponsiveFlutter.of(context).verticalScale(50),
        leading: IconButton(icon: Icon(Icons.arrow_back,size: ResponsiveFlutter.of(context).verticalScale(25),),
          onPressed: (){
            Navigator.pop(context);
          },),
        title:Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(widget.categoryData.content[widget.index].name.english,style: _styleHeader,),
              GestureDetector(
                  child: Text('fd_all_bestsellers_subTitle',style: _styleBody3,).tr(),
              onTap: (){
                showDialog(
                  context: context,
                  barrierColor: Color(secondary).withOpacity(0.5),
                  builder: (BuildContext context) => _buildFilterOption(context,widget.categoryData,widget.categoryId),
                );
              },),
            ]),
        actions: [
          search(context),
          cart(context)
        ],
      ),
      body: FutureBuilder(
        future: categoryBasedProductList,
        builder: (context,AsyncSnapshot<ProductModel> snapshot){
          if(snapshot.hasData)
            return StaggeredGridView.countBuilder(
              controller: _scrollController,
            crossAxisCount: Orientation.portrait==orientation?2:3,
            itemCount: snapshot.data.value.content.length,
            itemBuilder: (BuildContext context, int index) =>
                productDisplayXL(context,snapshot.data.value.content[index]),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          );
          else if(snapshot.data==null && snapshot.connectionState==ConnectionState.done) return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Image.asset("assets/images/nav_bar_logo/navbar_logo.png",
                    height: ResponsiveFlutter.of(context).verticalScale(24),
                    fit: BoxFit.contain,),
                  SizedBox(height: 40,),
                  Text("fd_categories_empty_msg",style: _styleHeader,textAlign: TextAlign.center,).tr()
                ]),
          );
          else return StaggeredGridView.countBuilder(
            crossAxisCount: Orientation.portrait==orientation?2:3,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) => productShimmer(context),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          );
        },
      )
    );
  }
}


Widget _buildFilterOption(BuildContext context, CategoryModel categoryData, String selectedId) {
  var _width = MediaQuery.of(context).size.width;
  TextStyle _styleBody2 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500, color: Color(colorText1));
  TextStyle _styleBody2_1 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
      fontWeight: FontWeight.w500, color: Color(colorText2));
  return new AlertDialog(
    title: const Text('Categories',),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    contentPadding: EdgeInsets.fromLTRB(0,15,0,0),
    content: new Container(
      width: _width*0.9,
      height: _width*0.8,
      child: ListView.builder(
        itemCount: categoryData.content.length,
          itemBuilder: (context,index){
        return
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductListingByCategory(
                  categoryId: categoryData.content[index].id,
                  index: index, categoryData: categoryData,
                )));
              },
              contentPadding: EdgeInsets.fromLTRB(0,0,20,0),
              horizontalTitleGap: 0.0,
              dense: true,
              leading:selectedId==categoryData.content[index].id?Container(width: 4,height: 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Color(secondary)),):
              SizedBox(),
              title: Text(categoryData.content[index].name.english,style: _styleBody2,),
              trailing: Text("208",style: _styleBody2_1,),
            );
      }),
    ),
  );
}
