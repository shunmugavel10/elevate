import 'dart:math';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/customer_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';


enum HomeState{
  Initial,
  Loading,
  Loaded,
  Error
}

class CustomerProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  CustomerModel _customerData;
  int currentpage =0,totalPage=1;

  CustomerModel get customerData=> _customerData;
  HomeState get homeState=> _homeState;


  CustomerProvider(){
    _homeState=HomeState.Loading;
    getCustomerNetwork();
  }
  Future<CustomerModel> getCustomerNetwork() async {
    if(totalPage>currentpage) {
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response = await value.get(url_get_customers, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if(currentpage==0){
              currentpage++;
              totalPage=CustomerModel.fromJson(response.data).value==null?
              1:CustomerModel.fromJson(response.data).value.totalPages;
              _customerData = CustomerModel.fromJson(response.data);
              loaded();
            }else {
              currentpage++;
                List<CustomerContent> content = CustomerModel.
                fromJson(response.data).value.content;
               _customerData.value.content.addAll(content);
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
      showtoast("No more customers");
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
    getCustomerNetwork();
    notifyListeners();
  }

  addData(CustomerContent content ){
    _customerData.value.content.add(content);
    notifyListeners();
  }

  deleteData(int index ){
    _customerData.value.content.removeAt(index);
    notifyListeners();
  }
}