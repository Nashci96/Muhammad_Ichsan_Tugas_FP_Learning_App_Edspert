import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/view/login_page.dart';

import '../constants/r.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 5), (){
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
      Navigator.of(context).pushReplacementNamed(LoginPage.route);
    });

    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(R.assets.icSplash)
        ),
    );
  }
}