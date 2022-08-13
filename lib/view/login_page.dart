import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/view/register_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/r.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xfff0f7f8),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                R.strings.login,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Image.asset(R.assets.imgLogin),
            const SizedBox(height: 35,),
            Text(
              R.strings.welcome,
              style: const TextStyle(
                fontSize:22,
                fontWeight: FontWeight.w500,
                ),
            ),
            Text(
              R.strings.loginDescription,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontSize:14,
                fontWeight: FontWeight.w500,
                color: R.colors.greySubtitle,
              ),
               
            ),
            Spacer(),
            ButtonLogin(
              onTap: (){
                Navigator.of(context).pushNamed(RegisterPage.route);
              },
              backgroundColor: Colors.white, 
              borderColor: R.colors.primary, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  SizedBox(width: 15,),
                  Text(
                    R.strings.loginWithGoogle,
                    style: TextStyle(
                      fontSize:17,
                      fontWeight: FontWeight.w500,
                      color: R.colors.blackLogin,
                      ),
                    ),
                ],
              ),
            ),
            ButtonLogin(
              onTap: (){},
              backgroundColor: Colors.black, 
              borderColor: Colors.black, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icApple),
                  SizedBox(width: 15,),
                  Text(
                    R.strings.loginWithApple,
                    style: TextStyle(
                      fontSize:17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key, 
    required this.backgroundColor, 
    required this.child, 
    required this.borderColor, 
    required this.onTap,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          fixedSize: Size(MediaQuery.of(context).size.width*0.8, 50),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: borderColor,
              )
          )
        ),
        onPressed: onTap, 
        child: child 
      ),   
    );
  }
}