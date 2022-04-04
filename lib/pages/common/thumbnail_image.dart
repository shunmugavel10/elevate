import 'dart:io';
import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:farm_direct/providers/imageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ThumbnailImage extends StatefulWidget {
  final List<File> selectedImages;

  const ThumbnailImage({Key key, this.selectedImages}) : super(key: key);
  @override
  _ThumbnailImageState createState() => _ThumbnailImageState();
}

class _ThumbnailImageState extends State<ThumbnailImage> {

  final picker = ImagePicker();

  getImage() async {
    widget.selectedImages.clear();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        widget.selectedImages.add(File(pickedFile.path));
        return File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>AccountNotifier(false,false,null),
      child: Align(alignment: Alignment.center,
        child: Container(
          height:100,
          width: 100,
          margin: EdgeInsets.only(top: 10),
          child: Consumer<AccountNotifier>(
              builder:(context,data,child){
                return Stack(children:[
                  Container(
                    width:95,
                    height: 95,
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                        child:data.imageEdit?
                        data.image==null?CircleAvatar(
                          radius: 95,):
                        Image.file(data.image,fit: BoxFit.cover,)
                            : data.imageLoading?CircularProgressIndicator():
                        CircleAvatar(backgroundColor: Colors.grey.shade100,
                          radius: 95,child: Icon(Icons.person,size: 40,),)
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
                        child: CircleAvatar(radius: 14,
                          backgroundColor: Color(secondary),
                          child: Icon(Icons.edit,color: Colors.white,
                            size:14,),),
                      ),
                    ),
                  ),
                  data.imageEdit?Align(alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8,right: 2),
                      child: GestureDetector(
                        onTap: ()async{
                          context.read<AccountNotifier>().updateImageEdit(false);
                        },
                        child: CircleAvatar(radius: 14,
                          backgroundColor: Color(secondary),
                          child: Icon(Icons.clear,color: Colors.white,
                              size:14),),
                      ),
                    ),
                  ):SizedBox(),
                ]);
              }
          ),
        ),
      ),
    );
  }
}
