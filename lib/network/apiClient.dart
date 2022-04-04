import 'package:dio/dio.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';

Future<Dio> apiClient() async {
  final _dio = Dio();
  _dio.interceptors.clear();
  _dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
    // Do something before request is sent
    // options.headers['content-Type'] = 'application/json';
    // options.headers["Authorization"] = "Bearer" + access_token;
    options.headers["Accept-Language"] = "en";
    return handler.next(options);
  }, onResponse: (Response response, handler) {
    // Do something with response data
    return handler.next(response); // continue
  }, onError: (DioError error, handler) async {
    // Do something with response error
    print("erro");
    print(error.response);
    if (error.response?.statusCode == 403) {
      _dio.interceptors.requestLock.lock();
      RequestOptions options = error.response.requestOptions;
      print("refersh");
      final refreshToken = await getRefreshToken();
      final response =
          await _dio.post('/users/refresh', data: {'token': refreshToken});
      var accessToken;
      if (response.statusCode == 200) {
        accessToken = response.data['accessToken'];
        await saveAccessToken(accessToken);
      }
      options.headers["Authorization"] = "Bearer " + accessToken;
      _dio.interceptors.responseLock.unlock();
      return _dio.request(options.path,
          data: options.data, queryParameters: options.queryParameters);
    } else {
      showtoast("Network Failed");
    }
  }));
  _dio.options.baseUrl = baseUrl;
  _dio.options.connectTimeout = 5000;
  _dio.options.receiveTimeout = 3000;
  return _dio;
}

Future<Dio> signoutClient() async {
  var accessToken = await getAccessToken();
  final _dio = Dio();
  _dio.interceptors.clear();
  _dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
    // Do something before request is sent
    options.headers['content-Type'] = 'application/json';
    options.headers["Authorization"] = "Bearer" + accessToken;
    options.headers["Accept-Language"] = "en";
    return handler.next(options);
  }, onResponse: (Response response, handler) {
    // Do something with response data
    return handler.next(response); // continue
  }, onError: (DioError error, handler) async {
    // Do something with response error
    print("erro");
    print(error.response);
    if (error.response?.statusCode == 403) {
      _dio.interceptors.requestLock.lock();
      RequestOptions options = error.response.requestOptions;
      print("refersh");
      final refreshToken = await getRefreshToken();
      final response =
      await _dio.post('/users/refresh', data: {'token': refreshToken});
      var accessToken;
      if (response.statusCode == 200) {
        accessToken = response.data['accessToken'];
        await saveAccessToken(accessToken);
      }
      options.headers["Authorization"] = "Bearer " + accessToken;
      _dio.interceptors.responseLock.unlock();
      return _dio.request(options.path,
          data: options.data, queryParameters: options.queryParameters);
    } else {
      showtoast("Network Failed");
    }
  }));
  _dio.options.baseUrl = baseUrl;
  _dio.options.connectTimeout = 5000;
  _dio.options.receiveTimeout = 3000;
  return _dio;
}
