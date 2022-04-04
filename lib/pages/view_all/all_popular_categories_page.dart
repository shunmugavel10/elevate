// import 'dart:io';
// import 'package:farm_direct/model/category_model.dart';
// import 'package:farm_direct/pages/common/cart_search.dart';
// import 'package:farm_direct/pages/common/shimmers.dart';
// import 'package:farm_direct/pages/common/size_colors.dart';
// import 'package:farm_direct/pages/modules/add_popular_categories.dart';
// import 'package:farm_direct/pages/tab1/sections/section3.dart';
// import 'package:farm_direct/pages/view_all/all_products_listing_by_category.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:responsive_flutter/responsive_flutter.dart';

// class AllCategories extends StatefulWidget {
//   final Future <CategoryModel> categoryList;

//   const AllCategories({Key key, this.categoryList}) : super(key: key);

//   @override
//   _AllCategoriesState createState() => _AllCategoriesState();
// }

// class _AllCategoriesState extends State<AllCategories> {

//   @override
//   Widget build(BuildContext context) {

//     var _width = MediaQuery.of(context).size.width;
//     TextStyle _styleHeader = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
//         fontWeight: FontWeight.w500, color: Color(colorText1));
//     TextStyle _styleBody3 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
//         fontWeight: FontWeight.w500, color: Color(colorText2));

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: ResponsiveFlutter.of(context).verticalScale(50),
//         leading: IconButton(icon: Icon(Icons.arrow_back,size: ResponsiveFlutter.of(context).verticalScale(25),),
//           onPressed: (){
//             Navigator.pop(context);
//           },),
//         title:Column(crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children:[
//               Text("fd_all_categories_title",style: _styleHeader,).tr(),
//               Text('fd_all_categories_subtitle',style: _styleBody3,).tr(),
//             ]),
//         actions: [
//           search(context),
//           cart(context)
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(FeatherIcons.plus),onPressed:(){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategories()));
//       }
//       ),
//       body: FutureBuilder(
//         future: widget.categoryList,
//         builder: (context,AsyncSnapshot <CategoryModel> snapshot){
//           if(snapshot.hasData)
//             return ListView.builder(
//                 itemCount: snapshot.data.content.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     child: tile(context, snapshot.data.content[index]),
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductListingByCategory(
//                         categoryId: snapshot.data.content[index].id,
//                         categoryData: snapshot.data,index: index,
//                       )));
//                     },
//                   );
//                 }
//             );
//           else return SizedBox(
//             height: (ResponsiveFlutter.of(context).verticalScale(70)+8.1)*5,
//             child: ListView.builder(
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: ResponsiveFlutter.of(context).scale(_width),
//                     height: ResponsiveFlutter.of(context).verticalScale(70),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       color: Colors.white,
//                     ),
//                     margin: EdgeInsets.only(left: 16, right: 16, top: 8),
//                     child: shimmerEffects(context),
//                   );
//                 }),
//           );
//         }
//       ),
//     );
//   }
// }
