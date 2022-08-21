import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/helper/preference_helper.dart';
import 'package:flutter_edspert_fp_learning_app/models/user_by_email.dart';
import 'package:flutter_edspert_fp_learning_app/view/main/profile/edit_profile_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/r.dart';
import '../../login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData? user;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    print(user);
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akun Saya"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return EditProfilePage();
              }));

              if (result == true){
                getUserData();
              }

            }, 
            child: Text(
              "Edit",
              style: TextStyle(
                color: Colors.white),
              ),
            ),
        ],
      ),
      body:
      user == null
      ? Center(child: CircularProgressIndicator(),)
      : Column(
        children: [
          Container( 
            padding: EdgeInsets.only(
              top: 28,
              bottom: 60,
              right: 15,
              left: 15,
              ),
            decoration: BoxDecoration(
              color: R.colors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              )
            ),
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     user!.userName!,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                     user!.userAsalSekolah!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                ),
                Image.asset(
                  R.assets.imgUser,
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 13),
            margin: EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Identitas Diri"),
                SizedBox(height:15),
                Text("Nama Lengkap User",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(user!.userName!,
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height:15),
                Text("Email",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(user!.userEmail!,
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height:15),
                Text("Jenis Kelamin",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(user!.userGender!,
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height:15),
                Text("Kelas",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(user!.kelas!,
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height:15),
                Text("Asal Sekolah",
                  style: TextStyle(
                    color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
                Text(user!.userAsalSekolah!,
                  style: TextStyle(
                    // color: R.colors.greySubtitleHome,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 15,),
          GestureDetector(
            onTap: () async {
              

              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                // vertical: 18,
                horizontal: 13),
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
              ),
              child: Row(
                children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.red,),
                SizedBox(width: 10,),
                Text(
                  "Keluar",
                  style: TextStyle(
                    color: Colors.red,
                    // fontSize: 13
                  ),
                ),
                
                  ],
              ),
            ),
          )
        ],
      ),
    );
   
  }
}