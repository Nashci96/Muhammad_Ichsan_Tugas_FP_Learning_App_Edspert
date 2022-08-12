import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/view/main_page.dart';

import '../constants/r.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String route = "register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender{
  lakilaki , perempuan
}

class _RegisterPageState extends State<RegisterPage> {

  String gender = "Laki - laki";
  List<String> classSlta = ["10","11","12"];
  String selectedClass = "10";

  onTapGender(Gender genderInput){
    if(genderInput == Gender.lakilaki){
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Yuk isi data diri",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black
            ),
          ),
      ),
      bottomNavigationBar: 
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
                    onTap: (){
                      Navigator.of(context).pushNamed(MainPage.route);
                    },
                    backgroundColor: R.colors.primary, 
                    borderColor: R.colors.primary, 
                    child: Text(
                      R.strings.daftar,
                      style: const TextStyle(
                        fontSize:17,
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
              RegisterTextField(
                hintText: 'Nama Lengkap Anda', 
                title: 'Nama Lengkap',
                ),
              SizedBox(height: 5),
              RegisterTextField(
                hintText: 'Email Anda', 
                title: 'Email',
                ),
              SizedBox(height: 5),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
                  )
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
              RegisterTextField(
                hintText: 'Nama Sekolah Anda', 
                title: 'Nama Sekolah',
                ),
              
                ],
              ),
        ),
      ),
    );
  }
}

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    Key? key, required this.title, required this.hintText,
  }) : super(key: key);
  final String title;
  final String hintText;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
          ),
         ),
         SizedBox(height: 5),
         Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(
              color: R.colors.greyBorder,
            )
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: R.colors.greyHintText,
              ),
            ),
          ),
         )
      ],
    );
  }
}