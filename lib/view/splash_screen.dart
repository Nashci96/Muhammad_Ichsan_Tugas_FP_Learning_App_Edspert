import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/helper/user_email.dart';
import 'package:flutter_edspert_fp_learning_app/view/login_page.dart';

import '../constants/r.dart';
import '../models/network_response.dart';
import '../repository/auth_api.dart';
import '../models/user_by_email.dart';
import '../repository/auth_api.dart';
import 'main_page.dart';
import 'register_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();
       
                 if (user != null){
                  final dataUser = await AuthApi().getUserByEmail();
                  if (dataUser.status == Status.success) {
                    final data = UserByEmail.fromJson(dataUser.data!);
                    if (data.status == 1 ) {
                      Navigator.of(context).pushNamed(MainPage.route);
                    } else {
                      Navigator.of(context).pushNamed(RegisterPage.route);
                    }
                  } 
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }


      // Navigator.of(context).pushReplacementNamed(LoginPage.route);
    });

    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(R.assets.icSplash)
        ),
    );
  }
}