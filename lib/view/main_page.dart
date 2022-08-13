import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/view/main/discussion/chat_page.dart';
import 'package:flutter_edspert_fp_learning_app/view/main/latihan_soal/home_page.dart';
import 'package:flutter_edspert_fp_learning_app/view/main/profile/profile_page.dart';

import '../constants/r.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String route = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pc = PageController();
  int index = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: BackButton(
      //     color: Colors.black, //change your color here
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          R.assets.icDiscuss,
          width: 30,
          ),

        onPressed: () { 
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatPage()));
         },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildBottomNavigation(),
      body: PageView(
        controller: _pc,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),//0
          ProfilePage()//1
        ],
      ),
    );
  }

  Container _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0,4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.06),
          )
        ]),
        child: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Material(
                      child: InkWell(
                        onTap: (){
                          index = 0;
                          _pc.animateToPage(
                            index, 
                            duration: Duration(milliseconds: 500), 
                            curve: Curves.bounceInOut
                            );
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              R.assets.icHome,
                              height: 30,),
                            Text("Home"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Material(
                      child: InkWell(
                        
                        child: Column(
                          children: [
                            Opacity(
                              opacity: 0,
                              child: Image.asset(
                                R.assets.icHome,
                                height: 30,),
                            ),
                            Text("Diskusi"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Material(
                      child: InkWell(
                        onTap: (){
                          index = 1;
                          _pc.animateToPage(
                            index, 
                            duration: Duration(milliseconds: 500), 
                            curve: Curves.easeInOut
                            );
                        },
                        child: Column(
                          children: const [
                            Icon(Icons.person),
                            Text("Profile"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),),
        ),
    );
  }
}