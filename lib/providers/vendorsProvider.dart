
import 'package:dio/dio.dart';
import 'package:farm_direct/model/vendors_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';


import 'customerProvider.dart';

class VendorProvider extends ChangeNotifier{
  HomeState _homeState=HomeState.Initial;
  VendorsModel _vendorData;
  int currentpage =0,totalPage=1;

  VendorsModel get vendorData=> _vendorData;
  HomeState get homeState=> _homeState;


  VendorProvider(){
    _homeState=HomeState.Loading;
    getVendorNetwork();
  }

  Future<VendorsModel> getVendorNetwork() async {
    if(totalPage>currentpage) {
      Response response;
      try {
        final _dio = apiClient();
        var data= await _dio.then((value) async {
          response = await value.get(url_get_vendors, queryParameters: {
            "page": currentpage.toString(),
          });
          if (response.statusCode == 200) {
            if(currentpage==0){
              currentpage++;
              _vendorData=VendorsModel.fromJson(response.data);
              loaded();
            }else {
              currentpage++;
              List<VendorContent> content = VendorsModel.
              fromJson(response.data).value.content;
              _vendorData.value.content.addAll(content);
            }
          } else {
            showtoast("Failed");
            error();
          }
        });
        return data;
      } catch (e) {
        error();
        showtoast("Failed1");
      }
    } else {
      showtoast("No more organization");
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
    getVendorNetwork();
    notifyListeners();
  }

  addData(VendorContent content ){
    _vendorData.value.content.add(content);
    notifyListeners();
  }

  deleteData(int index ){
    _vendorData.value.content.removeAt(index);
    notifyListeners();
  }
}