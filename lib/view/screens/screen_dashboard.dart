import 'package:careno_admin_pannel_app/view/screens/screen_mobile_home_page.dart';
import 'package:flutter/material.dart';

class ScreenDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
     return   ScreenMobileHomePage();
      },
    );

  }
}
