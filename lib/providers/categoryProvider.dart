import 'dart:math';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/category_model.dart';
// import 'package:farm_direct/model/product_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';

import 'customerProvider.dart';


class CategoryProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  CategoryModel _categoryData;
  int currentpage =0,totalPage=1;

  CategoryModel get categoryData=> _categoryData;
  HomeState get homeState=> _homeState;


  CategoryProvider(){
    _homeState=HomeState.Loading;
    getCategoryNetwork();
  }
  Future<CategoryModel> getCategoryNetwork() async {
    if(totalPage>currentpage) {
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response = await value.get(url_get_category, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if(currentpage==0){
              currentpage++;
              totalPage=CategoryModel.fromJson(response.data)==null?
              1:CategoryModel.fromJson(response.data).totalPages;
              _categoryData = CategoryModel.fromJson(response.data);
              loaded();
            }else {
              currentpage++;
                List<CategoryContent> content = CategoryModel.
                fromJson(response.data).content;
               _categoryData.content.addAll(content);
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
    getCategoryNetwork();
    notifyListeners();
  }

  addData(CategoryContent content ){
    _categoryData.content.add(content);
    notifyListeners();
  }

  deleteData(int index ){
    _categoryData.content.removeAt(index);
    notifyListeners();
  }
}