
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/customer_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/pages/common/shimmers.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/slider.dart';
import 'package:farm_direct/pages/modules/module1/edit_products.dart';
import 'package:farm_direct/pages/modules/module6/customer_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class CategoryDetailed extends StatefulWidget {
  final CategoryContent categoryData;

  const CategoryDetailed({Key key, this.categoryData}) : super(key: key);

  @override
  _CategoryDetailedState createState() => _CategoryDetailedState();
}

class _CategoryDetailedState extends State<CategoryDetailed> {

  PageController _pageController=PageController();
  List<Widget> images=[];
  CategoryContent categoryData;

  List<String> categoryList=["FPO","MFPO"];

  addImage(){
    for(int i=0;i<categoryData.thumbnail.images.length;i++){
      images.add(CachedNetworkImage(
          fit: BoxFit.contain,useOldImageOnUrlChange: true,
          placeholder: (context, url) => shimmerEffects(context),
          errorWidget: (context, url, error) => Icon(FeatherIcons.image,size: 70,color: Colors.grey.shade300,),
          imageUrl:categoryData.thumbnail.images[i]),);
    }
    //images.add(player(context));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryData=widget.categoryData;
   addImage();
  }
  @override
  Widget build(BuildContext context) {
    var _width =MediaQuery.of(context).size.width;
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Colors.white);
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w900,color:Color(colorText2));
    return Scaffold(
      appBar: AppBar(
       title:Text(categoryData.name.english),
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProducts(
        //       productData: widget.categoryData)));
        //   }, icon: Icon(Icons.edit_outlined,color:  Color(secondary),
        //   size: 30,))
        // ],
      ),
      body: Container(padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              slider(context, _pageController,images,),
              Center(child: indicator(context,_pageController, widget.categoryData.thumbnail.images.length)),
              SizedBox(height: 15,),
              Text(widget.categoryData.name.english,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:_styleBody1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,5,0,15),
                child: Divider(thickness: 10,color: Color(0xffF2F2F2),),
              ),
              Text(
                'fd_onboardingPage_msg_name',
                overflow: TextOverflow.ellipsis,
                style:_styleBody1.copyWith(color:  Color(secondary)),
              ).tr(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(width: _width,
                  child: Text(categoryData.name.english,
                    // 'A banana is an elongated, edible fruit ??? botanically a berry ??? produced by several kinds of large herbaceous flowering plants in the genus Musa. In some countries, bananas used for cooking may be called ???plantains???, distinguishing them from dessert bananas. ??? The fruits grow in clusters hanging from the top of the plant.',
                    style:_styleBody1.copyWith(color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              // Text(
              //   'fd_section1_subTitle2',
              //   overflow: TextOverflow.ellipsis,
              //   style:_styleBody1.copyWith(color: Color(secondary)),
              // ).tr(),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: SizedBox(width: _width,
              //     child: Text(categoryList[int.parse(customerData!.type!)],
              //       style:styleBody1.copyWith(color: quaternaryColor),
              //       textAlign: TextAlign.justify,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 15,),
              // Text(
              //   'fd_section1_subTitle4',
              //   overflow: TextOverflow.ellipsis,
              //   style:_styleBody1.copyWith(color:  Color(secondary)),
              // ).tr(),
              // ListView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: 1,
              //   shrinkWrap: true,
              //   itemBuilder: (context, index){
              //     List<String> address=["","","","",];
              //     // address=setAddress(snapshot.data!.addressList![index]);
              //     return Card(
              //       child: ListTile(
              //         title: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             // ignore: unrelated_type_equality_checks
              //             Text(productData.billingAddress.type==1?"fd_account_home":"fd_account_work",
              //               style: _styleBody1,).tr(),
              //             Text(address[0]+address[1]+address[2]+address[3],style: _styleBody1,)
              //           ],),
              //         trailing: Icon(Icons.arrow_forward_ios_sharp),
              //         hoverColor: Colors.grey,
              //         tileColor: Colors.white,
              //         onTap: (){

              //         },
              //       ),
              //     );
              //   },
              // ),

              // TextButton(
              //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("fd_account_add_new_address",style:_styleBody1,).tr(),
              //         Icon(Icons.add_circle_outlined,color: Color(secondary),
              //           size:(20) ,)
              //       ]),
              //   onPressed: (){
              //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(
              //     //   addressData: customerData!.addresses[0]!,
              //     // )));
              //   },),
            ],
          ),
        ),
      ),
    );
  }
}
