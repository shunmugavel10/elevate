import 'package:dio/dio.dart';
import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/category_model.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/model/store_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'sections/section2.dart';
import 'sections/section4.dart';
import 'sections/section5.dart';
import 'sections/section1.dart';
import 'sections/section3.dart';
import 'sections/section6.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  Future <CouponModel> bannerList;
  Future <ProductModel> productsList;
  Future <CategoryModel> categoriesList;
  Future <ProductModel> dealOfTheWeek;
  Future <StoreModel> storeList;
  Future <ProductModel> spotlightList;
  Future <CartModel> cartData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   productsList=getProductsNetwork();
   categoriesList= getCategoryNetwork();
   // dealOfTheWeek=getDealsOfTheWeekNetwork();
   // storeList=getStoreNetwork();
   // spotlightList=getSpotlightNetwork();
    bannerList=getCouponNetwork();
  }


  Future<CouponModel> getCouponNetwork() async {
      Response response;
      try {
        final _dio = apiClient();
        var data = await _dio.then((value) async {
          response = await value.get(url_get_coupons);
          print(response.data);
          if (response.statusCode == 200)
            return CouponModel.fromJson(response.data);
          else {
            showtoast("Failed");
          }
        });
        return data;
      } catch (e) {
        showtoast("Failed2");
      }
  }
  Future<ProductModel> getProductsNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_products,
            queryParameters: {
          "storeId":"a9de42ab-e9e5-11eb-9b35-cf21feca0da7",
        }
        );
        print(response.data);
        if (response.statusCode == 200) {
          return ProductModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed1");
    }
  }
  Future<CategoryModel> getCategoryNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_category);
        if (response.statusCode == 200) {
          return CategoryModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed3");
    }
  }
  Future<ProductModel> getDealsOfTheWeekNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_dealsOfTheWeek);
        print(response.data);
        if (response.statusCode == 200) {
          return ProductModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      print(e);
      showtoast("Failed");
    }
  }
  Future<StoreModel> getStoreNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_store);
        print(response.data);
        if (response.statusCode == 200) {
          return StoreModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }
  Future<ProductModel> getSpotlightNetwork() async {
    Response response;
    try {
      final _dio = apiClient();
      var data= await _dio.then((value) async {
        response =await value.get(url_get_spotlight);
        print(response.data);
        if (response.statusCode == 200) {
          return ProductModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                 children:[
                   SizedBox(height: 15,),
                   advertisement(context,bannerList),
                   SizedBox(height: 15,),
                   bestSellers(context,productsList),
                   SizedBox(height: 15,),
                   popularCategories(context,categoriesList,),
                   //dealsOfTheWeek(context,dealOfTheWeek),
                   // SizedBox(height: 15,),
                   // vendorsAroundYou(context,storeList),
                   // SizedBox(height: 15,),
                   // sponseredPartner(context,spotlightList),
                   // SizedBox(height: 15,),
                     ]),
          )
    )
    );
  }
}
