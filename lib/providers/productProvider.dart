import 'dart:math';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';

import 'customerProvider.dart';


class ProductProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  ProductModel _productData;
  int currentpage =0,totalPage=1;

  ProductModel get productData=> _productData;
  HomeState get homeState=> _homeState;


  ProductProvider(){
    _homeState=HomeState.Loading;
    getProductNetwork();
  }
  Future<ProductModel> getProductNetwork() async {
    if(totalPage>currentpage) {
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response = await value.get(url_get_products, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if(currentpage==0){
              currentpage++;
              totalPage=ProductModel.fromJson(response.data).value==null?
              1:ProductModel.fromJson(response.data).value.totalPages;
              _productData = ProductModel.fromJson(response.data);
              loaded();
            }else {
              currentpage++;
                List<ProductContent> content = ProductModel.
                fromJson(response.data).value.content;
               _productData.value.content.addAll(content);
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
    getProductNetwork();
    notifyListeners();
  }

  addData(ProductContent content ){
    _productData.value.content.add(content);
    notifyListeners();
  }

  deleteData(int index ){
    _productData.value.content.removeAt(index);
    notifyListeners();
  }
}