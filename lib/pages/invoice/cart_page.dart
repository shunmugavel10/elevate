import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/modules/add_user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'cart_add_button.dart';
import 'coupon_page.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  final String cartId,userId;

  const CartPage({Key key, this.cartId, this.userId}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  CartModel cartData;

  Future<CartModel> getCartDataNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
        await _dio.then((value) async {
        response =await value.get("$url_get_cartProduct/${widget.cartId}");
        if (response.statusCode == 200) {
          setState(() {
            cartData= CartModel.fromJson(response.data);
          });
        } else {
          showtoast("Failed1");
        }
      });
    } catch (e) {
      showtoast("Failed2");
    }
  }

  Future<String> createOrderNetwork({CartModel cartData,var amount, currencyType}) async {
    Response response,response1;
    try {
      final _dio = apiClient();
      await Future.wait([
        _dio.then((value) async {response =await value.post("$url_get_orders",data: {
          "customerId": widget.userId,
          "type": "SALES",
          "creatorType": "POS",
          "paymentType": "CREDIT_CARD",
          "items": cartData.items,
          "orderLevelDiscount": cartData.orderLevelDiscount,
          "subTotal":cartData.subTotal,
          "totalTax":cartData.totalTax,
          "total": cartData.total,
          "billingAddress": {
            "street": "101 Nandhini Street",
            "city": "Hyderabad",
            "state": "AndhraPradesh",
            "country": "India",
            "pincode": "516003",
            "type": "HOME"
          },
          "shippingAddress": {
            "street": "101 Nandhini Street",
            "city": "Hyderabad",
            "state": "AndhraPradesh",
            "country": "India",
            "pincode": "516003",
            "type": "WORK"
          },
          "payment": {
            "paymentId": "",
            "status": "Not Paid",
            "method": "",
            "paymentResponse": "",
            "paidAmount": {
              "value": 0,
              "currency": "INR"
            }
          },
          "vendorId": "965df4d0-d44e-4cd2-b8f9-f01b6b3f0635"
        });}),
    _dio.then((value) async {response1 =await value.post("$url_get_cartProduct",data: {
    "cartId": widget.cartId,
    "customerId": widget.userId,
    "order": {
    "amount": amount, "currency": currencyType
    },
    "payment": {
    "amount": amount, "currency": currencyType
    }
    });})
      ]);
        if (response.statusCode == 201 && response1.statusCode == 200) {
          return response.data["id"];
        } else {
          showtoast("Failed");
          return null;
        }
    } catch (e) {
      showtoast("Failed");
      return null;
    }
  }

  checkfn() async {
    await getCartDataNetwork();
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartDataNetwork();
  }

  @override
  Widget build(BuildContext context) {

    var _width=MediaQuery.of(context).size.width;
    TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w500, color:Color(colorText1));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w900,color:Colors.white);
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody3_4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(0xffFF8680));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w700,color:Color(colorText1));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleButton2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(secondary));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody3_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(secondary));
    TextStyle _styleBody3_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody3_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody4_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody5),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody4_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w400,color:Color(colorText1));
    TextStyle _styleButton4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w500,color:Color(0xff3EA5DB));


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: ResponsiveFlutter.of(context).verticalScale(50),
        leading: IconButton(icon: Icon(Icons.arrow_back,size: ResponsiveFlutter.of(context).verticalScale(25),),
        onPressed: (){
          Navigator.pop(context);
        },),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("fd_invoice_title",style: _styleHeader,).tr(),
            Text("fd_invoice_subTitle",style: _styleBody3_2,).tr()],),
      ),

      body:cartData==null?LinearProgressIndicator():
      // ignore: deprecated_member_use
      WatchBoxBuilder(
        box: Hive.box('cart'),
        builder: (context, cartBox){
          if(cartBox.isNotEmpty) {
            return ListView(
              children:[
                Container(height:ResponsiveFlutter.of(context).scale(58)*cartBox.values.length.toDouble(),
                  child: ListView.builder(
                    itemCount: cartData.items.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context, index)
                     {
                       if(cartBox.containsKey(cartData.items[index].product.id)){
                      return Container(
                        decoration: new BoxDecoration(
                            border: new Border(bottom: new BorderSide(color:Color(0xffE7E7E8)))),
                        child: ListTile(
                          leading: CachedNetworkImage(
                              height: ResponsiveFlutter.of(context).scale(60),
                              width: ResponsiveFlutter.of(context).scale(60),
                              fit: BoxFit.contain,useOldImageOnUrlChange: true,
                              imageUrl:cartData.items[index].product.thumbnail),
                          title: SizedBox(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                              Text("Fruits",style: _styleBody3_1,overflow: TextOverflow.ellipsis,),
                              Text(cartData.items[index].product.name,style: _styleHeader,overflow: TextOverflow.ellipsis,),
                              Text(tr("fd_productDetailed_cultivatedSoldBy_title")+ " Narayana swamy",style: _styleBody4_1,overflow: TextOverflow.ellipsis,),
                              Text("Qty : 1",style: _styleBody4_1,)
                            ]),
                          ),
                          trailing: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                              CartAddButton(cartData: cartData.items[index]),
                              Column(
                                children: [
                                  Text('₹ ${cartData.items[index].price.salePrice.amount.value}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: _styleBody2,),
                                  Text('₹ ${cartData.items[index].price.amount.value}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: _styleBody3,),
                                ],
                              ),
                            ]),
                          )
                        ),
                      );
                  }else return SizedBox();
                     }),
                ),
                Container(height: 10,color: Color(0xffF2F2F2),),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: ListTile(
                    leading: Container(width: ResponsiveFlutter.of(context).scale(30),
                        height:ResponsiveFlutter.of(context).scale(30),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                            color: Color(0xff4F4F4),border: Border.all(color: Color(0xffE7E7E8),width:2)
                        ), child: Icon(FeatherIcons.userPlus,color: Color(secondary),
                          size:ResponsiveFlutter.of(context).scale(15),)),
                    title: Text("fd_invoice_details_title",style: _styleBody2_1,).tr(),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                    contentPadding: EdgeInsets.all(5),
                    hoverColor: Colors.grey,
                    tileColor: Colors.white,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUser()));
                    },
                  ),
                ),
                Container(height: 10,color: Color(0xffF2F2F2),),
                Container(
                  padding: EdgeInsets.only(left:16,right: 16),
                  height: ResponsiveFlutter.of(context).verticalScale(80),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: TextSpan(
                        children: [
                          TextSpan(text: tr("fd_invoice_details_title1"),style: _styleBody2_1),
                          TextSpan(text: " Brigade Palmsprings",style: _styleBody2_2),
                        ]
                      ),overflow: TextOverflow.ellipsis,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: _width*0.5, child: Text("35/37, Brigade Millenium Rd, Paradise Colony, Phase 7,J. P. Nagar, Bengaluru, Karnataka 560078",
                              style: _styleBody4_1),),
                          TextButton(
                              child: Text("fd_invoice_button",style: _styleButton2).tr(),
                              onPressed: (){

                          })
                        ],
                      )
                    ],
                  ),
                ),
                Container(height: 10,color: Color(0xffF2F2F2),),
                // Container(
                //   padding: EdgeInsets.only(left: 16,right: 16),
                //   height: ResponsiveFlutter.of(context).fontSize(8),
                //   color: Colors.white,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("fd_cart_bill_title",style: _styleBody3_3).tr(),
                //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("fd_cart_subTotal_title",style: _styleBody2_1,).tr(),
                //           Text("₹ ${cartData.subTotal.value}",style: _styleBody2_1,),
                //         ],
                //       ),
                //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("fd_cart_charge1_title",style: _styleBody4,).tr(),
                //           Text("₹ ${cartData.totalTax.value}",style: _styleBody4,),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Container(color: Color(0xffE2E2E2),
                //   padding: EdgeInsets.only(left: 16,right: 16),
                //   margin: EdgeInsets.only(bottom: 20),
                //   height: ResponsiveFlutter.of(context).fontSize(3),
                //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("fd_cart_total_title",style: _styleBody2_1,).tr(),
                //       Text("₹ ${cartData.total.value}",style: _styleBody2_1,),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      child: Text("fd_invoice_proceed_button",style: _styleButton1,).tr(),
                      color: Color(secondary),
                      height: 50,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        //bool res=await checkfn();
                        // if(res == true){
                        //   var orderId= await createOrderNetwork(cartData: cartData,amount: cartData.total.value,
                        //       currencyType: cartData.total.currency);
                        //   if(orderId!=null) {
                        //    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(
                        //             orderId: orderId, userId: widget.userId, cartData: cartData,
                        //             amount: cartData.total.value, currencyType: cartData.total.currency)));
                        //   }
                        // }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(left: _width*0.3,right: _width*0.3),
                  child: Container(height: 6,
                  margin: EdgeInsets.only(top: 8,bottom: 16),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.black,),),
                ),
                Container(height: 10,color: Color(0xffF2F2F2),),
                Container(
                 // padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Text("fd_cart_cancellation_title",style: _styleBody1,).tr(),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(FeatherIcons.clock,color: Color(secondary),
                              size: ResponsiveFlutter.of(context).fontSize(2.2),),
                            SizedBox(width: 10,),
                            SizedBox(width: _width-ResponsiveFlutter.of(context).fontSize(8),
                              child: Text("fd_transactionResult_msg2",
                                style: _styleBody4_2,).tr(),
                            ),
                          ],),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Icon(FeatherIcons.clock,color: Color(secondary),
                            size: ResponsiveFlutter.of(context).fontSize(2.2),),
                          SizedBox(width: 10,),
                          SizedBox(width: _width-ResponsiveFlutter.of(context).fontSize(8),
                            child: Text("fd_transactionResult_msg2",
                              style: _styleBody4_2,).tr(),
                          ),
                        ],),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Text("fd_cart_policy_msg",style: _styleBody3_4,).tr(),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          child: GestureDetector(child: Text("fd_cart_read_button",style: _styleButton4,).tr(),
                            onTap: (){

                            },)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,)

            ]);
          }
          else return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
              Image.asset("assets/images/nav_bar_logo/navbar_logo.png",
                height: ResponsiveFlutter.of(context).verticalScale(24),
                fit: BoxFit.contain,),
              SizedBox(height: 40,),
              Text("fd_cart_empty_msg",style: _styleHeader,).tr()
            ]),
          );
        },
      ),
    );
  }
}
