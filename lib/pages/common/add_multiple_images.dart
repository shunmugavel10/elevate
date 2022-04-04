import 'dart:io';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class AddMultipleImages extends StatefulWidget {
final List<File> selectedImages;

  const AddMultipleImages({Key key, this.selectedImages}) : super(key: key);
  @override
  _AddMultipleImagesState createState() => _AddMultipleImagesState();
}

class _AddMultipleImagesState extends State<AddMultipleImages> {

  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        widget.selectedImages.add(File(pickedFile.path));
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children:[
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
              SizedBox(width: 10,),
              widget.selectedImages.length > 2 ? Text(
                  "fd_addProduct_hint").tr() :
              Text("fd_addProduct_button",).tr(),
              SizedBox(width: 10,),
              widget.selectedImages.length > 2 ? SizedBox(width: 30,height: 43,) : FlatButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Icon(
                    Icons.add_photo_alternate_outlined, size: 30, color: Theme
                      .of(context)
                      .secondaryHeaderColor,)),
            ],),
          SizedBox(height: 10,),
        SizedBox(height: 100, width: double.infinity, child: ListView.builder(
            itemCount: widget.selectedImages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Stack(
                  children: [
                    Container(margin: EdgeInsets.only(left: 5, right: 10),
                      width: 100, height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          widget.selectedImages[index], fit: BoxFit.cover,),
                      ),
                    ),
                    Align(alignment: Alignment.topRight, child: GestureDetector(
                      child: Icon(Icons.clear, size: 24,color: Color(secondary),), onTap: () {
                      setState(() {
                        widget.selectedImages.removeAt(index);
                      });
                    },
                    ),)
                  ]);
            }),
        ),
        ]),);
  }
}