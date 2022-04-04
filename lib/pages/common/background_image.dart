import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class BackgroundImage extends StatelessWidget {
  /// The image to display.
  final ImageProvider image;

  const BackgroundImage({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        image: this.image);
  }
}
