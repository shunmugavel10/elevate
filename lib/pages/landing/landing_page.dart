import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/model/favourite_model.dart';
import 'package:farm_direct/model/hive/cart_model_hive.dart';
import 'package:farm_direct/model/hive/favourites_model_hive.dart';
import 'package:farm_direct/model/user_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:farm_direct/pages/common/google_map.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/tab1/home_page.dart';
import 'package:farm_direct/pages/tab2/order_page.dart';
import 'package:farm_direct/pages/tab3/apps_page.dart';
import 'package:farm_direct/pages/tab3/favourites_page.dart';
import 'package:farm_direct/pages/tab4/Notification_page.dart';
import 'package:farm_direct/pages/tab5/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class LandingPage extends StatefulWidget {
  final List<String> address;

  const LandingPage({Key key, this.address}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final List  tab=  [ShopPage(),OrderPage(),AppsPage(),NotificationPage(),AccountPage()];
  int _currentindex = 0;
  List<String> address=[];
  var val=1;
  Future <FavouriteModel> favouritesIdList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    address=widget.address;
    saveLoginStatus(1);
    getCartDataNetwork("7b29417d-b7ef-11eb-8b62-bf16fe781934");
    favouritesIdList= getFavouritesNetwork();
    getProfileData();
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<UserModel> getProfileData() async {
    Response response;
    try {
      String userId= await getStoreId();
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.get("$url_get_userProfile/$userId",);
        if (response.statusCode == 200) {
          List<String> data=[];
          data.add(UserModel.fromJson(response.data).id);
          data.add(UserModel.fromJson(response.data).userName);
          data.add(UserModel.fromJson(response.data).profilePictures);
          saveStoreData(data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> addCart(Item data)  {
    final cartData=  Cart(productId: data.product.id,updateId:data.id,quantity: data.quantity.toString());
    final cartbox=Hive.box('cart');
    cartbox.put(data.product.id, cartData);
  }
  Future<void> deleteCart() async {
    final cartbox=Hive.box('cart');
    await cartbox.clear();
  }

  Future<CartModel> getCartDataNetwork(String id) async {
    //var cart_id= await get_cartID();
    Response response;
    try {
      CartModel data;
      final _dio = apiClient();
      await _dio.then((value) async {
        response =await value.get("$url_get_cartProduct/$id");
        if (response.statusCode == 200) {
          await deleteCart();
          data= CartModel.fromJson(response.data);
          for(int i=0;i<data.items.length;i++){
            addCart(data.items[i]);
          }
        } else {
          showtoast("Failed");
        }
      });
    } catch (e) {
      showtoast("Failed");
    }
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> addFavourite(FavouriteContent favouritedata)  {
    final Favourites favouriteData=  Favourites(productId:favouritedata.itemId,
        updateId: favouritedata.id, isFavourite: true);
    final favouritebox=Hive.box('favourites');
    favouritebox.put(favouritedata.itemId, favouriteData);
  }
  Future<void> deleteFavourite() async {
    final favouritebox=Hive.box('favourites');
    await favouritebox.clear();
  }

  Future<FavouriteModel> getFavouritesNetwork() async {
    Response response;
    try {
      FavouriteModel favouritedata;
      String userId= await getStoreId();
      print("userId");
      print(userId);
      final _dio = apiClient();
      // ignore: missing_return
      favouritedata= await _dio.then((value) async {
        response =await value.get("$url_get_post_favouriteProduct?userId=$userId");
        if (response.statusCode == 200) {
          await deleteFavourite();
          favouritedata= FavouriteModel.fromJson(response.data);
          for(int i=0;i<favouritedata.value.favouriteContent.length;i++){
            addFavourite(favouritedata.value.favouriteContent[i]);
          }
        } else {
          showtoast("Failed");
        }
      });
      return favouritedata;
    } catch (e) {
      //showtoast("Failed");
    }
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  List<Box> boxList = [];
  Future<List<Box>> _openBox() async {
    var cartBox = await Hive.openBox("cart");
    var favouritesBox = await Hive.openBox("favourites");
    boxList.add(cartBox);
    boxList.add(favouritesBox);
    return boxList;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w700,color: Color(colorText1));
    TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w700,color: Color(colorText2));
    return FutureBuilder(
      future: _openBox(),
      builder: (context,AsyncSnapshot snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData)
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title:_currentindex==3 || _currentindex==4?
                  Image.asset("assets/images/main_logo/main_logo.png",
                    height: ResponsiveFlutter.of(context).verticalScale(24),
                    fit: BoxFit.contain,):
                  GestureDetector(
                    child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(FeatherIcons.mapPin,color: Color(secondary),size: 18,),
                                    SizedBox(width: 8,),
                                    Text(address[0]??"",style: _styleBody3)
                                ],),
                                Text(
                                  "${address[1]??""} ${address[2]??""} ${address[3]??""} ",
                                  style: _styleBody4,
                                )
                              ],) ,),
                    onTap: () async {
                      double lat = await getLat();
                      double lng =await getLng();
                     List coordinates=await Navigator.push(context, MaterialPageRoute(
                         builder: (context)=>GoogleMapDisplay(latt: lat,lngg: lng,)));
                    if(coordinates!=null){
                      setState(() {
                        Placemark placemark=coordinates[2];
                        address[0]=placemark.locality;
                        address[1]=placemark.street;
                        address[2]=placemark.subLocality;
                        address[3]=placemark.subAdministrativeArea;
                      });
                    }
                    },
                  ),
                  toolbarHeight: ResponsiveFlutter.of(context).verticalScale(45),
                  actions: [
                    search(context),
                    cart(context)
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 50,
                  backgroundColor:Colors.white ,
                  currentIndex: _currentindex,
                  type: BottomNavigationBarType.fixed,
                  iconSize:ResponsiveFlutter.of(context).verticalScale(16),
                  unselectedItemColor: Colors.grey,
                  showUnselectedLabels: true,
                  selectedItemColor:Color(secondary),
                  onTap: (int index) {
                    setState(() {
                      _currentindex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(FeatherIcons.shoppingBag),
                        // ignore: deprecated_member_use
                        title: Text("Home",style: _styleBody4,)),
                    BottomNavigationBarItem(
                        icon: Icon(FeatherIcons.package,),
                        // ignore: deprecated_member_use
                        title: Text("Order",style: _styleBody4,)),
                    BottomNavigationBarItem(
                        icon: Icon(FeatherIcons.grid,),
                        // ignore: deprecated_member_use
                        title: Text("App",style: _styleBody4,)),
                    BottomNavigationBarItem(
                        icon: Icon(FeatherIcons.bell,),
                        // ignore: deprecated_member_use
                        title: Text("Notification",style: _styleBody4,)),
                    BottomNavigationBarItem(
                        icon: Icon(FeatherIcons.user,),
                        // ignore: deprecated_member_use
                        title: Text("Account",style: _styleBody4,)),
                  ],
                ),
                body: WillPopScope(
                  // ignore: missing_return
                  onWillPop: (){
                    if(val==2){
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    }
                    Fluttertoast.showToast(
                        msg: "Press the back button again to exit", timeInSecForIosWeb: 4);
                    val=2;
                    Timer(Duration(seconds:2),(){
                        val=1;
                    });
                  },
                  child: tab[_currentindex],
                ),
              );
          else return Scaffold();
        }else{
          return Scaffold();
        }
      }
    );
  }
}
