import 'package:shared_preferences/shared_preferences.dart';

saveToken(String accessToken, refreshToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token', accessToken);
  prefs.setString('refresh_token', refreshToken);
}

saveAccessToken(String accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token', accessToken);
}

getAccessToken()async{
  String accessToken;
  final prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString('access_token') ?? null;
  return accessToken;
}

getRefreshToken()async{
  String refreshToken;
  final prefs = await SharedPreferences.getInstance();
  refreshToken = prefs.getString('refresh_token') ?? null;
  return refreshToken;
}

saveLoginStatus(int status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('loginStatus', status);
}

getLoginStatus()async{
  int loginStatus;
  final prefs = await SharedPreferences.getInstance();
  loginStatus = prefs.getInt('loginStatus') ?? 0;
  return loginStatus;
}
saveStoreId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', id);
}

getStoreId()async{
  String id;
  final prefs = await SharedPreferences.getInstance();
  id = prefs.getString('userId') ?? "";
  return id;
}
saveStoreData(List<String> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('userData', data);
}

getStoreData()async{
  List<String> data;
  final prefs = await SharedPreferences.getInstance();
  data = prefs.getStringList('userData') ?? [];
  return data;
}
saveLoc(double lat, lng) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setDouble('Latitude', lat);
  prefs.setDouble('Longitude', lng);
}

getLat()async{
  double lattt;
  final prefs = await SharedPreferences.getInstance();
  lattt = prefs.getDouble('Latitude') ?? 8.48560258;
  return lattt;
}


getLng()async{
  double lnggg;
  final prefs = await SharedPreferences.getInstance();
  lnggg = prefs.getDouble('Longitude') ?? 76.92097149 ;
  return lnggg;
}

saveAddress(List<String> address) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('address', address);
}

getAddress()async{
  List<String> address;
  final prefs = await SharedPreferences.getInstance();
  address = prefs.getStringList('address') ?? ["Select","","",""];
  return address;
}

saveLanguage(int language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('language', language);
}

getLanguage()async{
  int address;
  final prefs = await SharedPreferences.getInstance();
  address = prefs.getInt('language') ?? 0;
  return address;
}

saveCartID(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('cart_id', id);
}

getCartID()async{
  String id;
  final prefs = await SharedPreferences.getInstance();
  id = prefs.getString('cart_id') ?? "";
  return id;
}