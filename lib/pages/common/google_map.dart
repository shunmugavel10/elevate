import 'dart:async';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'shared_preference.dart';

class GoogleMapDisplay extends StatefulWidget {
  final double latt, lngg;

  const GoogleMapDisplay({Key key, this.latt, this.lngg}) : super(key: key);

  @override
  _GoogleMapDisplayState createState() => _GoogleMapDisplayState();
}

class _GoogleMapDisplayState extends State<GoogleMapDisplay> {

  Completer<GoogleMapController> _controller = Completer();
  List data= [];
  double lat, lng;
  double latPos, lngPos;
  List<Marker> mymarker = [];
  double pos;bool popup=false;
  String street="",sublocality="",locality="",city="",state="",country="";


  @override
  Widget build(BuildContext context) {

    var _width=MediaQuery.of(context).size.width;
    var _height=MediaQuery.of(context).size.height;
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color: Color(colorText1));
    TextStyle _styleBody3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w700,color: Color(colorText2));
    TextStyle _styleBody1_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));

    pos=popup?_height-230:_height;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            compassEnabled: true,
            mapToolbarEnabled: true,
            initialCameraPosition: CameraPosition(
              target: (LatLng(widget.latt, widget.lngg)), zoom: 14,),
            markers: Set.from(mymarker),
            onTap: _hanldetap,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context,null);
              },
            ),
          ),
          AnimatedContainer(height: 230,width: _width,
          decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))),
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.only(left: 16,right: 16,bottom: 10),
          transform: Matrix4.translationValues(0, pos, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(FeatherIcons.mapPin,color: Color(secondary),size: 18,),
                SizedBox(width: 8,),
                Text(locality,style: _styleBody1)
              ],),
              Text("$street $sublocality $locality $city $state $country",
                style: _styleBody3,
              ),
              // ignore: deprecated_member_use
              FlatButton(child: Text("Confirm location",style: _styleBody1_2,),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(secondary))),
                minWidth:MediaQuery.of(context).size.width,
                height: ResponsiveFlutter.of(context).verticalScale(45),
                color: Color(secondary),
                onPressed: (){
                saveAddress([locality,street,sublocality,city]);
                Navigator.pop(context,data);
                },),
            ],) ,)
        ]),
      ),
    );
  }

  _hanldetap(LatLng tappedpoint){
    setState(() {
      popup=true;
      lat = tappedpoint.latitude;
      lng = tappedpoint.longitude;
      data.clear();
      data.add(lat);
      data.add(lng);
      getLocName(lat,lng);
      mymarker = [];
      saveLoc(lat, lng);
      mymarker.add(
          Marker(
              markerId: MarkerId(tappedpoint.toString()),
              position: tappedpoint
          )
      );
    });
  }

  getLocName(double lat, lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    setState(() {
      Placemark placeMark  = placemarks[0];
      data.add(placeMark);
      city=placeMark.subAdministrativeArea;
      locality=placeMark.locality;
      sublocality=placeMark.subLocality;
      street=placeMark.street;
      state=placeMark.administrativeArea;
      country=placeMark.country;
    });
  }
  currentLocation()  async {
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      double lat=position.latitude;
      double lng=position.longitude;
      data.clear();
      data.add(lat);
      data.add(lng);
      saveLoc(lat, lng);
      return data;
    }
}

