import 'package:farm_direct/pages/common/size_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPrivacyText extends StatelessWidget {
  final String _privacyDocLink = "https://www.google.com/";
  final String _termsAndCondsLink = "https://fast.com/";
  @override
  Widget build(BuildContext context) {
    TextStyle _styleBody4 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w500,color:Color(colorText2));
    TextStyle _styleBody4_1 =TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(fontBody4),
        fontWeight: FontWeight.w500,color:Colors.white);
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: 'By joining you agree to our ',
            style:_styleBody4,
          ),
          TextSpan(
            text: 'Terms of services',
            style: _styleBody4_1,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(_termsAndCondsLink)) {
                  await launch(
                    _termsAndCondsLink,
                    forceSafariVC: false,
                  );
                }
              },
          ),
          TextSpan(
            text: ' and ',
            style: _styleBody4,
          ),
          TextSpan(
            text: '\nPrivacy policy',
            style: _styleBody4_1,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(_privacyDocLink)) {
                  await launch(
                    _privacyDocLink,
                    forceSafariVC: false,
                  );
                }
              },
          )
        ]));
  }
}
