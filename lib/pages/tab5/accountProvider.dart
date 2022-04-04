import 'dart:io';
import 'package:flutter/cupertino.dart';

class AccountNotifier extends ChangeNotifier{
  File _image;
  bool _imageEdit;
  bool _imageLoading;

  File get image=> _image;
   bool get imageEdit=> _imageEdit;
  bool get imageLoading=> _imageLoading;

  AccountNotifier(this._imageLoading,this._imageEdit,this._image);

  updateImage(File val){
    _image =val;
    notifyListeners();
  }

  updateImageEdit(bool val){
    _imageEdit=val;
    notifyListeners();
  }

  updateImageLoading(bool val){
    _imageLoading=val;
    notifyListeners();
  }
}