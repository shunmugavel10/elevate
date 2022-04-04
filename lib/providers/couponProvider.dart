import 'dart:math';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/coupon_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';

import 'customerProvider.dart';


class CouponProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  CouponModel _couponData;
  int currentpage =0,totalPage=1;

  CouponModel get couponData=> _couponData;
  HomeState get homeState=> _homeState;


  CouponProvider(){
    _homeState=HomeState.Loading;
    getCouponNetwork();
  }
  Future<CouponModel> getCouponNetwork() async {
    if(totalPage>currentpage) {
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response = await value.get(url_get_coupons, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if(currentpage==0){
              currentpage++;
              totalPage=CouponModel.fromJson(response.data).value==null?
              1:CouponModel.fromJson(response.data).value.totalPages;
              _couponData = CouponModel.fromJson(response.data);
              loaded();
            }else {
              currentpage++;
                List<CouponContent> content = CouponModel.
                fromJson(response.data).value.content;
               _couponData.value.content.addAll(content);
            }
          } else {
            error();
            showtoast("Failed");
          }
        });
        return data;
      } catch (e) {
        error();
        showtoast("Failed1");
      }
    } else {
      showtoast("No more products");
    }
  }

  loaded(){
    _homeState=HomeState.Loaded;
    notifyListeners();
  }
  error(){
    _homeState=HomeState.Error;
    notifyListeners();
  }
  nextPage(){
    getCouponNetwork();
    notifyListeners();
  }

  addData(CouponContent content ){
    _couponData.value.content.add(content);
    notifyListeners();
  }

  deleteData(int index ){
    _couponData.value.content.removeAt(index);
    notifyListeners();
  }
}