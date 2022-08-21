import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/helper/user_email.dart';
import 'package:flutter_edspert_fp_learning_app/view/login_page.dart';

import '../constants/r.dart';
import '../models/network_response.dart';
import '../repository/auth_api.dart';
import '../models/user_by_email.dart';
import 'main_page.dart';
import 'register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final user = UserEmail.getUserEmail();
       
                 if (user != null){
                  final dataUser = await AuthApi().getUserByEmail();
                  if (dataUser.status == Status.success) {
                    final data = UserByEmail.fromJson(dataUser.data!);
                    if (data.status == 1 ) {
                      Navigator.of(context).pushReplacementNamed(MainPage.route);
                    } 
                    else {
                      Navigator.of(context).pushReplacementNamed(RegisterPage.route);
                    }
                      // else {
                      //   Navigator.of(context).pushReplacementNamed(LoginPage.route);
                      // }
                  } 
                } 
                else {
                  Navigator.of(context).pushReplacementNamed(LoginPage.route);
                } 
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(R.assets.icSplash)
        ),
    );
  }
}