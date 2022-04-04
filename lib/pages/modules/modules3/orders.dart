import 'package:farm_direct/pages/tab2/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/images/nav_bar_logo/homeal.png",
            height: ResponsiveFlutter.of(context).verticalScale(28),
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        title: Text(
          "fd_app_title8",
        ).tr(),
      ),
        body: OrderPage(),
    );
  }
}