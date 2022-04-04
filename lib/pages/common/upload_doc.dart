import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/document_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:path/path.dart' as p;
import 'toast_msg.dart';


uploadDocument1({File file, String title,itemId,itemType,category}) async {
  var fileName= p.basename(file.path);
  final extension =  p.extension(file.path);
  Response response;
  try {
    final _dio = apiClient();
    var data= await _dio.then((value) async {
      response =await value.post(url_upload_doc,data: {
          "fileName": fileName,
          "title": title,
          "contentType": extension,
          "itemId": "20312f29-60a9-4fa3-af88-3a45be4a9e3d",
          "itemType": itemType,
          "category": category
      });
      if (response.statusCode == 201) {
        bool result =await uploadDocument2(response.data["uploadUrl"],file);
        return result;
      } else {
        showtoast("Failed");
      }
    });
    return data;
  } catch (e) {
    showtoast("Failed");
  }
}

uploadDocument2(String url,File file) async {
  Dio dio = Dio();
  Response response;
  try {
    Uint8List bytes = await file.readAsBytes();
    response = await dio.put(url,data:bytes);
    if(response.statusCode==200){
      print(response.data);
      return true;
    }
    else {
      showtoast("Failed");
      return false;
    }
  } on SocketException catch (e) {
    showtoast("Network Failed");
  } on TimeoutException catch (e){
    showtoast("Timeout");
  }
}


Future<String> getDocument1({String id,type}) async {

  Response response;
  try {
    final _dio = apiClient();
    var data= await _dio.then((value) async {
      response =await value.get(url_upload_doc,queryParameters: {
        "itemId": id,
        "itemType": type,
      });
      if (response.statusCode == 200) {
        String documentData=await getDocument2(
            DocumentModel.fromJson(response.data).value.content.last.id);
        // if(documentData!=null){
          return documentData;
        // }
        // else {return null;}
      } else {
        showtoast("Failed99");
      }
    });
    return data;
  } catch (e) {
    showtoast(e);
  }
}

Future<dynamic> getDocument2(String id) async {

  Response response;
  try {
    final _dio = apiClient();
    var data= await _dio.then((value) async {
      response =await value.get("$url_upload_doc/$id");
      if (response.statusCode == 200) {
        return (response.data)["location"];
      } else {
        showtoast("Failed96");
      }
    });
    return data;
  } catch (e) {
    showtoast("Failed91");
  }
}

