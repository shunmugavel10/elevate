import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/modules/modules2/Category.dart';
import 'package:farm_direct/pages/view_all/all_popular_categories_page.dart';
import 'package:farm_direct/pages/view_all/all_products_listing_by_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

Widget popularCategories(BuildContext context, Future<CategoryModel> categoriesList) {
  var _width = MediaQuery.of(context).size.width;
  TextStyle _styleHeader = TextStyle(
      fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader3),
      fontWeight: FontWeight.w500,
      color: Color(colorText1));
  TextStyle _styleButton1 = TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
      fontWeight: FontWeight.w500, color: Color(colorText1));

  return Container(
    color: Color(0xffF9F9F9),
    child: Column(
      children: [
        Container(
          width: _width,
          height: 12,
          color: Color(0xffF2F2F2),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(tr('fd_mainpage_3_title'),
                      overflow: TextOverflow.ellipsis, style: _styleHeader),
                ),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width:MediaQuery.of(context).size.width * 0.25,
                        alignment: Alignment.centerRight,
                        child: Text("fd_homw_viewAll_button", style: _styleButton1,
                          overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,
                          maxLines: 2,).tr(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                          radius:
                              ResponsiveFlutter.of(context).verticalScale(10),
                          backgroundColor: Theme.of(context).buttonColor,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size:
                                ResponsiveFlutter.of(context).verticalScale(12),
                          ))
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Category(
                      // categoriesList:categoriesList,
                    )));
                  },
                )
              ],
            )),
        FutureBuilder(
            future: categoriesList,
            builder: (context, AsyncSnapshot<CategoryModel> snapshot) {
              if (snapshot.hasData && snapshot.data.content!=null)
                return ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.content.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(child: tile(context, snapshot.data.content[index]),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductListingByCategory(
                            categoryId: snapshot.data.content[index].id,
                            categoryData: snapshot.data,index: index,
                          )));
                        },);
                    });
              else return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: ResponsiveFlutter.of(context).scale(_width),
                      height: ((_width-32)/4.17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: shimmerEffects(context),
                    );
                  });
            }),
        SizedBox(
          height: 15,
        ),
        Container(
          width: _width,
          height: 12,
          color: Color(0xffF2F2F2),
        ),
      ],
    ),
  );
}

Widget tile(BuildContext context, CategoryContent categories) {
  var _width = MediaQuery.of(context).size.width;
  TextStyle _styleBody1 = TextStyle(
      fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight: FontWeight.w600,
      color: Color(colorText3));

  return Container(
    width: _width,
    height: (_width-32)/4.17,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
    margin: EdgeInsets.only(left: 16, right: 16, top:8 ),
    child: Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: SizedBox(
          width: _width,
          height: (_width-32)/4.17,
          child: CachedNetworkImage(
              // height: ResponsiveFlutter.of(context).verticalScale(120),
              // width: ResponsiveFlutter.of(context).scale(90),
              fit: BoxFit.cover,
              useOldImageOnUrlChange: true,
              imageUrl: categories.imageUrl),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        alignment: AlignmentDirectional.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Text(
              categories.name.english,
              style: _styleBody1,
            ),
            SizedBox(
              width: 15,
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: Color(colorText3),
            ),
          ],
        ),
      ),
    ]),
  );
}
