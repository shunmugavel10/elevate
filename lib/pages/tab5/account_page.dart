import 'dart:io';
import 'package:farm_direct/model/user_model.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/pages/authentication/onboarding_screens.dart';
import 'package:farm_direct/pages/common/shared_preference.dart';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/pages/common/textField.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:farm_direct/pages/common/upload_doc.dart';
import 'package:farm_direct/pages/tab4/Notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shimmer/shimmer.dart';
import 'add_edit address.dart';
import 'change_password.dart';
import 'accountProvider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  var selectedLan=0;
  Future<UserModel> profileData;
  String userId;
  String profileImage;
  final picker = ImagePicker();
  List languages=[
    "fd_language_selection_EN",
    "fd_language_selection_TL",
    "fd_language_selection_MA",
    "fd_language_selection_KN",
    "fd_language_selection_TN",
    "fd_language_selection_ML"
  ];

   getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<UserModel> getProfileData() async {
    Response response;
    try {
      userId= await getStoreId();
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.get("$url_get_userProfile/$userId",);
        if (response.statusCode == 200) {
          print("hii");
         // profileImage=await getDocument1(id:UserModel.fromJson(response.data).id,type: "PROFILE");
          return UserModel.fromJson(response.data);
        } else {
          showtoast("Failed");
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }

  signOutNetwork() async {
    Response response;
    try {
      final _dio = signoutClient();
      _dio.then((value) async {
      response =await value.delete(url_delete_signOut,);
      if (response.statusCode == 200) {
        saveLoginStatus(0);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OnBoardScreen()), (route) => false);
      } else {
        showtoast("Failed");
      }
      });
    } catch (e) {
      showtoast("Failed");
    }
  }

  Future<bool> postProfileData(UserModel userData) async {
    Response response;
    try {
      String userId= await getStoreId();
      final _dio = apiClient();
      var data= _dio.then((value) async {
        response =await value.put("$url_get_userProfile/$userId",data: {
          "id":userData.id,
          "name": nameController.text,
          "email":emailController.text,
          "phone":userData.phone,
          "pwdHash":userData.pwdHash
        });
        if (response.statusCode == 200) {
          print(userData.pwdHash);
          return true;
        } else {
          showtoast("Failed");
          return true;
        }
      });
      return data;
    } catch (e) {
      showtoast("Failed");
    }
  }

  void setRadioFunction(int val){
    if(selectedLan==0){
      setState(() {
        // ignore: deprecated_member_use
        context.locale= Locale('en', 'US');
      });
    }else if(selectedLan==1){
      setState(() {
        // ignore: deprecated_member_use
        context.locale= Locale('ta', 'IN');
      });
    }else if(selectedLan==2){
      setState(() {
        // ignore: deprecated_member_use
        context.locale= Locale('mr', 'IN');
      });
    }else if(selectedLan==3){
      setState(() {
        // ignore: deprecated_member_use
        context.locale= Locale('kn', 'IN');
      });
    }else if(selectedLan==4){
      setState(() {
        // ignore: deprecated_member_use
        context.locale= Locale('te', 'IN');
      });
    }else if(selectedLan==5){
      setState(() {
        // ignore: deprecated_member_use
        context.locale= Locale('ml', 'IN');
      });
    }
    saveLanguage(selectedLan);
  }

  getLan()async{
    selectedLan =await getLanguage();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLan();
    // profileData=getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    var _width= MediaQuery.of(context).size.width;
    TextStyle _styleHeader =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontHeader1),
        fontWeight: FontWeight.w700, color:Color(colorText1));
    TextStyle _styleBody2_2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Colors.white);
    TextStyle _styleBody2 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody2_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody2),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody1_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1_1),
        fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleBody1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody1),
      fontWeight: FontWeight.w500,color:Color(colorText1));
    TextStyle _styleButton1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody3),
        fontWeight: FontWeight.w500,color:Color(secondary));

    return ChangeNotifierProvider(
        create: (context) =>AccountNotifier(false,false,null),
      child: Scaffold(
        body: FutureBuilder(
        future: profileData,
        builder: (context,AsyncSnapshot<UserModel> snapshot){
          if (snapshot.hasData){
            nameController.text=snapshot.data.name;
            emailController.text=snapshot.data.email;
            double length;int length1;
            try{
              length =snapshot.data.addressList.length.toDouble();
              length1 =snapshot.data.addressList.length;
            }catch(e){
              length1=0;
              length=0.0;
            }
            return Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    height:ResponsiveFlutter.of(context).scale(105),
                    width: _width,
                    color: Color(0xffF9F9F9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:16,right:16),
                          child: Container(
                            height:ResponsiveFlutter.of(context).scale(80),
                            width: ResponsiveFlutter.of(context).scale(80),
                            margin: EdgeInsets.only(top: ResponsiveFlutter.of(context).scale(10)),
                            child: Consumer<AccountNotifier>(
                                builder:(context,data,child){
                                  return Stack(children:[
                                    Container(
                                      width:ResponsiveFlutter.of(context).scale(75),
                                      height: ResponsiveFlutter.of(context).scale(75),
                                      child: ClipRRect(borderRadius: BorderRadius.circular(100),
                                        child:data.imageEdit?
                                        data.image==null?CircleAvatar(
                                          radius: ResponsiveFlutter.of(context).scale(75),):
                                        Image.file(data.image,fit: BoxFit.cover,)
                                            : data.imageLoading?CircularProgressIndicator():
                                        CachedNetworkImage(
                                          useOldImageOnUrlChange: true,fit: BoxFit.cover,
                                          placeholder:(context, url)=>Shimmer.fromColors(
                                            baseColor: Color(0xffE0E0E0),
                                            highlightColor: Color(0xffF1F1F1),
                                            child: Container(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          imageUrl:"https://cdn.downtoearth.org.in/library/large/2019-07-24/0.37377100_1563954075_gettyimages-498281885.jpg",
                                        ),
                                      ),
                                    ),
                                    Align(alignment: AlignmentDirectional.bottomEnd,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8,right: 2),
                                        child: GestureDetector(
                                          onTap: ()async{
                                            context.read<AccountNotifier>().updateImageEdit(true);
                                            context.read<AccountNotifier>().updateImage(await getImage());
                                          },
                                          child: CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(14),
                                            backgroundColor: Color(secondary),
                                            child: Icon(FeatherIcons.edit2,color: Colors.white,
                                              size:ResponsiveFlutter.of(context).verticalScale(14),),),
                                        ),
                                      ),
                                    ),
                                    data.imageEdit?Align(alignment: AlignmentDirectional.topEnd,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8,right: 2),
                                        child: GestureDetector(
                                          onTap: ()async{
                                            context.read<AccountNotifier>().updateImageEdit(false);
                                            context.read<AccountNotifier>().updateImageLoading(true);
                                            bool result=await uploadDocument1(file: data.image,title: "PROFILE",
                                                itemId:userId,itemType: "PROFILE" ,category: "DOCUMENT" );
                                            if(result==true){
                                              context.read<AccountNotifier>().updateImageLoading(false);
                                            }
                                          },
                                          child: CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(14),
                                            backgroundColor: Color(secondary),
                                            child: Icon(FeatherIcons.save,color: Colors.white,
                                              size:ResponsiveFlutter.of(context).verticalScale(14),),),
                                        ),
                                      ),
                                    ):SizedBox(),
                                    data.imageEdit?Align(alignment: AlignmentDirectional.topStart,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8,right: 2),
                                        child: GestureDetector(
                                          onTap: ()async{
                                            context.read<AccountNotifier>().updateImageEdit(false);
                                          },
                                          child: CircleAvatar(radius: ResponsiveFlutter.of(context).verticalScale(14),
                                            backgroundColor: Color(secondary),
                                            child: Icon(FeatherIcons.x,color: Colors.white,
                                              size:ResponsiveFlutter.of(context).verticalScale(14),),),
                                        ),
                                      ),
                                    ):SizedBox(),
                                  ]);
                                }
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: _width/2.3,
                              child: Text(snapshot.data.name??snapshot.data.userName,style: _styleHeader,
                                maxLines: 2,overflow: TextOverflow.ellipsis,),
                            ),
                            SizedBox(height:6,),
                            SizedBox(width: _width/2.3,
                              child: Text(snapshot.data.email??"",style: _styleBody2,
                                maxLines: 2,overflow: TextOverflow.ellipsis,),
                            )
                          ],),
                        SizedBox(width: _width/5,
                          child: IconButton(icon: Icon(FeatherIcons.edit,
                            size:ResponsiveFlutter.of(context).scale(16),),
                              onPressed: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                                  builder: (context) => Container(height: 280,
                                  padding: EdgeInsets.all(16),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      textField(context, "fd_account_fullName","fd_account_fullName",
                                          "fd_account_fullName_error", nameController),
                                      textField(context, "fd_account_email","fd_account_email",
                                          "fd_account_email_error", emailController),
                                      SizedBox(height: 20,),
                                      // ignore: deprecated_member_use
                                      FlatButton(child: Text("fd_account_manage_savebutton",style: _styleBody2_2,).tr(),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: Color(secondary))),
                                        minWidth:MediaQuery.of(context).size.width*0.2,
                                        height: ResponsiveFlutter.of(context).verticalScale(45),
                                        color: Color(secondary),
                                        onPressed: () async {
                                          bool result= await postProfileData(snapshot.data);
                                          if(result==true) {
                                            Navigator.pop(context);
                                          }
                                        },),
                                    ],
                                  ),),
                                );
                          }),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Container(width: ResponsiveFlutter.of(context).scale(30),
                        height:ResponsiveFlutter.of(context).scale(30),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                            color: Color(0xff4F4F4),border: Border.all(color: Color(0xffE7E7E8),width:2)
                        ), child: Icon(FeatherIcons.lock,color: Color(secondary),
                          size:ResponsiveFlutter.of(context).scale(15),)),
                    title: Text("fd_account_change_password",style: _styleBody1_1,).tr(),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                    hoverColor: Colors.grey,
                    tileColor: Colors.white,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword(
                        username: snapshot.data.userName??"",
                      )));
                    },
                  ),
                  Divider(thickness:0.2,),
                  ListTile(
                    leading: Container(width: ResponsiveFlutter.of(context).scale(30),
                        height:ResponsiveFlutter.of(context).scale(30),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                            color: Color(0xff4F4F4),border: Border.all(color: Color(0xffE7E7E8),width:2)
                        ), child: Icon(FeatherIcons.bell,color: Color(secondary),
                          size:ResponsiveFlutter.of(context).scale(15),)),
                    title: Text("fd_account_notification",style: _styleBody1_1,).tr(),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                    hoverColor: Colors.grey,
                    tileColor: Colors.white,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationPage()));
                    },
                  ),
                  Divider(thickness:0.2,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,10,0,10),
                    child: Text("fd_account_manage_address",style: _styleBody1,).tr(),
                  ),
                  SizedBox(height: 50*length,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: length1,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("fd_account_work",style: _styleBody2,).tr(),
                              Text("Frank G. Wells Building 2nd Floor 500 Sout…",style: _styleBody2_1,)
                            ],),
                          trailing: Icon(Icons.arrow_forward_ios_sharp),
                          hoverColor: Colors.grey,
                          tileColor: Colors.white,
                          onTap: (){

                          },
                        );
                      },
                    ),
                  ),

                  Divider(thickness:0.2,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,16,0),
                    child: TextButton(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("fd_account_add_new_address",style:_styleButton1,).tr(),
                            Icon(Icons.add_circle_outlined,color: Color(secondary),
                              size:ResponsiveFlutter.of(context).verticalScale(20) ,)
                          ]),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress()));
                      },),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,10,0,10),
                    child: Text("fd_account_more_option",style: _styleBody1,).tr(),
                  ),
                  ListTile(
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("fd_account_currency",style: _styleBody1_1,).tr(),
                          Text(r"$ - USD",style: _styleBody2,)
                        ]),
                    trailing:
                    Icon(Icons.arrow_forward_ios_sharp),
                    hoverColor: Colors.grey,
                    tileColor: Colors.white,
                    onTap: (){
                      // showModalBottomSheet(
                      //   context: context,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                      //   builder: (context) => Container(height: 200,
                      //     padding: EdgeInsets.all(16),
                      //     child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         CountryListPick(
                      //           appBar: AppBar(
                      //             backgroundColor: Colors.amber,
                      //             title: Text('Pick your country'),
                      //           ),
                      //           // if you need custome picker use this
                      //           pickerBuilder: (context, CountryCode countryCode) {
                      //             return Row(
                      //               children: [
                      //                 Image.asset(
                      //                   countryCode.flagUri,
                      //                   package: 'country_list_pick',
                      //                 ),
                      //                 Text(countryCode.code),
                      //                 Text(countryCode.dialCode),
                      //               ],
                      //             );
                      //           },
                      //
                      //         ),
                      //         SizedBox(height: 20,),
                      //         FlatButton(child: Text("fd_account_manage_address_savebutton",style: _styleButton1,).tr(),
                      //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                      //               side: BorderSide(color: Color(secondary))),
                      //           minWidth:MediaQuery.of(context).size.width*0.2,
                      //           height: ResponsiveFlutter.of(context).verticalScale(45),
                      //           color: Color(secondary),
                      //           onPressed: () async {
                      //             bool result= await postProfileData();
                      //             result?Navigator.pop(context):null;
                      //           },),
                      //       ],
                      //     ),),
                      // );
                    },
                  ),
                  Divider(thickness:0.2,),
                  ListTile(
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("fd_account_language",style: _styleBody1_1,).tr(),
                          Text(languages[selectedLan],style: _styleBody2,).tr()
                        ]),
                    trailing:
                    Icon(Icons.arrow_forward_ios_sharp),
                    hoverColor: Colors.grey,
                    tileColor: Colors.white,
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState1 /*You can rename this!*/) {
                                  return Container(height: 400,
                                    padding: EdgeInsets.all(16),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height:280,
                                          child: ListView.builder(
                                              itemCount:languages.length,
                                              itemBuilder: (context,index){
                                                return ListTile(
                                                  title: Text(languages[index]).tr(),
                                                  trailing: Radio(
                                                    value: index,
                                                    groupValue: selectedLan,
                                                    onChanged: (val){
                                                      setState1(() {
                                                        selectedLan=val;
                                                      });
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                        SizedBox(height: 20,),
                                        // ignore: deprecated_member_use
                                        FlatButton(child: Text("fd_account_manage_savebutton",style: _styleBody2_2,).tr(),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                              side: BorderSide(color: Color(secondary))),
                                          minWidth:MediaQuery.of(context).size.width*0.2,
                                          height: ResponsiveFlutter.of(context).verticalScale(45),
                                          color: Color(secondary),
                                          onPressed: () async {
                                           setRadioFunction(selectedLan);
                                           Navigator.pop(context);
                                          },),
                                      ],
                                    ),);
                                });
                          });
                    },
                  ),
                  Divider(thickness:0.2,),
                  ListTile(
                    title: Text("fd_account_logout",style: _styleBody1_1,).tr(),
                    trailing:
                    Icon(Icons.arrow_forward_ios_sharp),
                    hoverColor: Colors.grey,
                    tileColor: Colors.white,
                    onTap: (){
                      //signOut_network();
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OnBoardScreen()), (route) => false);
                    },
                  ),
                  Divider(thickness:0.2,),
                ],
              ),
            );}
          else return LinearProgressIndicator();
        },
      ),
    )
    );
  }
}
