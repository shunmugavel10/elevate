import 'package:farm_direct/pages/common/google_map.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    var orientation =MediaQuery.of(context).orientation;
    TextStyle _styleHeader1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeaderXL),
        fontWeight: FontWeight.w900, color:Color(colorText1));
    TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w600, color:Color(colorText2));
    TextStyle _styleBody1_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w700,color:Color(colorText3));
    TextStyle _styleBody1_3 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
        fontWeight: FontWeight.w600, color:Color(colorText1));
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w600,color:Color(colorText2));


    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom:10),
        child: SizedBox(height: ResponsiveFlutter.of(context).verticalScale(22),
            child: Center(child: Image.asset("assets/images/nav_bar_logo/bottom_sheet.png"))),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,bottom: 40,),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: orientation==Orientation.portrait?70:0,),
                Icon(Icons.location_on,color: Color(secondary),
                  size: ResponsiveFlutter.of(context).verticalScale(60),),
                SizedBox(height: ResponsiveFlutter.of(context).verticalScale(20),),
                Text(tr("fd_language_selection_hi")+" Raghunath"+tr("fd_location_title"),
                  style: _styleHeader1,),
                SizedBox(height: ResponsiveFlutter.of(context).verticalScale(20),),
                Text("fd_location_msg",style: _styleBody1_1,).tr(),
                SizedBox(height:ResponsiveFlutter.of(context).verticalScale(50),),
                // ignore: deprecated_member_use
                FlatButton(child: Text("fd_location_currentLocation_button",style: _styleBody1_2,).tr(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(secondary))),
                  minWidth:MediaQuery.of(context).size.width,
                  height: ResponsiveFlutter.of(context).verticalScale(45),
                  color: Color(secondary),
                  onPressed: () async {
                    List coordinates = await GoogleMapDisplay().createState().currentLocation();
                    List<String> address=[];
                   if(coordinates!=null){
                       List<Placemark> placemarks = await placemarkFromCoordinates(coordinates[0], coordinates[1]);
                       setState(() {
                         Placemark placeMark  = placemarks[0];
                         address.add(placeMark.locality);
                         address.add(placeMark.street);
                         address.add(placeMark.subLocality);
                         address.add(placeMark.subAdministrativeArea);
                       });
                       saveAddress(address);
                         Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
                         (context)=>LandingPage(address:address,)), (route) => false);
                   }
                  },),
                SizedBox(height: ResponsiveFlutter.of(context).verticalScale(10),),
                Text("fd_location_msg_2",style: _styleBody2,).tr(),
                SizedBox(height:ResponsiveFlutter.of(context).verticalScale(50),),
                GestureDetector(child: Text("fd_location_manually_selection_button",style: _styleBody1_3,).tr(),
                onTap:()async{
                  double lat = await getLat();
                  double lng =await getLng();
                  List coordinates=await Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>GoogleMapDisplay(latt: lat,lngg: lng,)));
                  if(coordinates!=null){
                    List<String> address = await getAddress();
                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
                        (context)=>LandingPage(address:address,)), (route) => false);
                  }
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
