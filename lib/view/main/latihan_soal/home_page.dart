import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edspert_fp_learning_app/helper/preference_helper.dart';
import 'package:flutter_edspert_fp_learning_app/models/banner_list.dart';
import 'package:flutter_edspert_fp_learning_app/models/mapel_list.dart';
import 'package:flutter_edspert_fp_learning_app/models/user_by_email.dart';
import 'package:flutter_edspert_fp_learning_app/repository/latihan_soal_api.dart';
import 'package:flutter_edspert_fp_learning_app/view/main/latihan_soal/mapel_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/r.dart';
import '../../../models/network_response.dart';
import 'paket_soal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
// 02.37 vid 31
class _HomePageState extends State<HomePage> {
  
  MapelList? mapelList;
  getMapel() async {
    final mapelResult = await LatihanSoalApi().getMapel();
    if (mapelResult.status == Status.success){
      mapelList = MapelList.fromJson(mapelResult.data!);
      setState(() {});
    }
  }

  BannerList? bannerList;
  getBanner() async{
    final banner = await LatihanSoalApi().getBanner();
    if (banner.status == Status.success){
      bannerList = BannerList.fromJson(banner.data!);
      setState(() {});
    }
  }
  
    UserData? dataUser;
  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {
      
    });
  }

  setupFcm() async {
    final tokenFcm = await FirebaseMessaging.instance.getToken();
    print("token fcm: $tokenFcm");

    RemoteMessage? initialMessage = 
      await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      print('Got a message while in the foreground');
      print('message a data: ${message.data}');

      if (message.notification != null){
        print('Message also contained a notification: ${message.notification} ');
      }
    });


  }

  @override
  void initState(){
    super.initState();
    getMapel();
    getBanner();
    setupFcm();
    getUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: R.colors.grey,
      body: SafeArea(
        child: ListView(
          children: [
            _buildUserHomeProfile(),
            _builtTopBanner(context),
            _builtHomeListMapel(mapelList),
            Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Terbaru",
                    style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                ),
                SizedBox(height:10),

                bannerList == null
                ? Container(
                  height: 70, 
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: 150,
                    child: ListView.builder(
                      itemCount: bannerList!.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context,index){
                        final currentBanner = bannerList!.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(left : 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              currentBanner.eventImage!,),
                          ),
                        );
                    })),
                  ),
                SizedBox(height: 35,),
                 
              ],
            )
          ),
          ],
        ),
      ),
    );
    
  }

  Container _builtHomeListMapel(MapelList? list) {
    return Container(
            margin : EdgeInsets.symmetric(horizontal:20,vertical: 21),
            child:Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Pilih Pelajaran",
                      style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),),
                    Spacer(),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                            return MapelPage(mapel: mapelList!);
                          }));
                      }, 
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: R.colors.primary,
                            ),
                          ),
                      )
                  ],
                ),

                list == null 
                  ? Container(
                      height: 70, 
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                        ),
                  ) 
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 
                      list.data!.length >3 
                      ? 3: list.data!.length,
                    itemBuilder: (BuildContext context,int index){
                      final currentMapel = list.data![index];
                      print("isi mapel done");
                      print(currentMapel.jumlahDone!);
                      
                      return GestureDetector(
                        onTap: (){
                            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => 
                              PaketSoalPage(id: currentMapel.courseId!),
                            ),
                          );
                        },
                        child: MapelWIdget(
                          title: currentMapel.courseName!,
                          totalDone: currentMapel.jumlahDone!,
                          totalPackage: currentMapel.jumlahMateri!,
                        ),
                      );
                      
                },),
              ],
            )
          );
  }

  Container _builtTopBanner(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              // vertical: 15,
            ),
            
            decoration: BoxDecoration(
              color: R.colors.primary,
              borderRadius: BorderRadius.circular(20)
            ),
            height: 147,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width : MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15,
                  ),
                  child: Text(
                    "Mau Kerjain Latihan Soal Apa Hari ini ?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    R.assets.imgHome,
                    width: MediaQuery.of(context).size.width *0.5,
                  ),
                ),
              ],
            ),
          );
  }



  Padding _buildUserHomeProfile() {
    return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15,
              ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, " + (dataUser?.userName ?? "Nama User"),
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12, fontWeight: FontWeight.w700
                        ),
                        ),
                      Text(
                        "Selamat Datang",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12, fontWeight: FontWeight.w700
                        ),
                        ),
                      
                    ],
                  ),
                ),
                Image.asset(
                  R.assets.imgUser,
                  width: 35,
                  height: 35,
                  ),
              ],
            ),
          );
  }
}

class MapelWIdget extends StatelessWidget {
  const MapelWIdget({
    Key? key, 
    required this.title, 
    required this.totalDone, 
    required this.totalPackage,
  }) : super(key: key);

  final String title;
  final int totalDone;
  final int totalPackage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              
            ),
      margin: EdgeInsets.only(bottom: 10,),
      padding: EdgeInsets.symmetric(horizontal:20,vertical: 21),
      child: Row(
        children: [
          Container(
            height: 53,
            width: 53,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: R.colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Image.asset(R.assets.icAtom),
          ),
          SizedBox(width: 6,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                ),
                ),
              Text(
                "$totalDone/$totalPackage Paket Latihan Soal",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                ),
              SizedBox(height: 5,),
              Stack(
                children: [
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: R.colors.grey,
                      borderRadius: BorderRadius.circular(10)  
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: totalDone,
                        child: Container(
                          height: 5,
                          // width: MediaQuery.of(context).size.width *0.4,
                          decoration: BoxDecoration(
                            color: R.colors.primary,
                            borderRadius: BorderRadius.circular(10)  
                          ),
                        ),
                      ),
                      Expanded(
                        flex: totalPackage - totalDone,
                        child: Container(
                          // height: 5,
                          // width: MediaQuery.of(context).size.width *0.4,
                          // decoration: BoxDecoration(
                          //   color: R.colors.primary,
                          //   borderRadius: BorderRadius.circular(10)  
                          // ),
                        ),
                      ),
                    ],
                  ),
                  
                ],
              )
            ],),
          )
        ],
      ),
    );
  }
}