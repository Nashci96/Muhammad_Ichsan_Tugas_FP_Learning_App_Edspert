import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/helper/user_email.dart';
import 'package:flutter_edspert_fp_learning_app/repository/auth_api.dart';
import 'package:flutter_edspert_fp_learning_app/view/main_page.dart';

import '../../../constants/r.dart';
import '../../../helper/preference_helper.dart';
import '../../../models/network_response.dart';
import '../../../models/user_by_email.dart';
import '../../login_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  static String route = "register_page";

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

enum Gender{
  lakilaki , perempuan
}

class _EditProfilePageState extends State<EditProfilePage> {

  List<String> classSlta = ["10","11","12"];

  String gender = "Laki - laki";
  String selectedClass = "10";
  final emailController = TextEditingController();
  final schoolNameController = TextEditingController();
  final fullNameController = TextEditingController();

  onTapGender(Gender genderInput){
    if(genderInput == Gender.lakilaki){
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {
      
    });
  }

  initDataUser() async {
    emailController.text = UserEmail.getUserEmail()!;
    // fullNameController.text = UserEmail.getUserDisplayName()!;
    final dataUser = await PreferenceHelper().getUserData();
    fullNameController.text = dataUser!.userName! ;
    schoolNameController.text = dataUser!.userAsalSekolah! ;
    gender = dataUser.userGender!;
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff0f3f5),
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(25.0),
        //     bottomRight: Radius.circular(25.0),
        //   )),
        elevation: 0,
        // backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Account",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white
            ),
          ),
      ),
      bottomNavigationBar: 
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
                    radius: 8,
                    onTap: () async {
                      final json = {
                        "email" : emailController.text,
                        "nama_lengkap" : fullNameController.text,
                        "nama_sekolah" : schoolNameController.text,
                        "kelas" : selectedClass,
                        "gender" : gender,
                        "foto"  : UserEmail.getUserPhotoUrl(),
                      };
                      print(json);
                      final result = await AuthApi().postRegister(json);
                      if (result.status == Status.success) {
                        final registerResult = UserByEmail.fromJson(result.data!);
                        if (registerResult.status == 1) {
                          await PreferenceHelper().setUserData(registerResult.data!);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            MainPage.route,(context)=>false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(registerResult.message!),
                            ),
                          );
                        }
                      } 
                    },
                    backgroundColor: R.colors.primary, 
                    borderColor: R.colors.primary, 
                    child: Text(
                      R.strings.perbaruiAkun,
                      style: const TextStyle(
                        fontSize:16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),
                      ),
                  ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileTextField(
                controller: emailController,
                hintText: 'Email Anda', 
                title: 'Email',
                enabled: false,
                ),
              SizedBox(height: 5),
              EditProfileTextField(
                hintText: 'Nama Lengkap Anda', 
                title: 'Nama Lengkap',
                controller: fullNameController,
                ),
              SizedBox(height: 5),             
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: R.colors.greySubtitle 
                  ),
                ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender=="Laki-laki" ? R.colors.primary : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: R.colors.greyBorder,
                            ),
                          ), 
                        ),
                        onPressed: (){
                          onTapGender(Gender.lakilaki);
                        }, 
                        child: 
                          Text("Laki-laki",
                            style: TextStyle(
                            fontSize: 14,
                            color: gender =="Laki-laki" ? Colors.white : Colors.black,
                          ),
                          ),
                        ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender=="Perempuan" ? R.colors.primary : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: R.colors.greyBorder,
                            ),
                          ), 
                        ),
                        onPressed: (){
                          onTapGender(Gender.perempuan);
                        }, 
                        child: 
                          Text("Perempuan",
                            style: TextStyle(
                            fontSize: 14,
                            color: gender =="Perempuan" ? Colors.white : Colors.black,
                          ),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Kelas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                color: R.colors.greySubtitle 
                  ),
                ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: R.colors.greyBorder,
                  ),
                ),
                child:DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedClass,
                    items: classSlta
                    .map(
                      (e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                        ),)
                    .toList(), 
                    onChanged: (String? val){
                      selectedClass = val!;
                      setState(() {
                         
                      });
                    }),
                ),
              ),
              SizedBox(height: 5),
              EditProfileTextField(
                hintText: 'Nama Sekolah Anda', 
                title: 'Nama Sekolah',
                controller: schoolNameController,
                ),
              
                ],
              ),
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    Key? key, 
    required this.title, 
    required this.hintText, 
    this.controller, 
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: R.colors.greySubtitle 
            ),
           ),
           SizedBox(height: 5),
           TextField(
             enabled: enabled,
             controller: controller,
             decoration: InputDecoration(
               // border: InputBorder.none,
               hintText: hintText,
               hintStyle: TextStyle(
                 color: R.colors.greyHintText,
               ),
             ),
           )
        ],
      ),
    );
  }
}