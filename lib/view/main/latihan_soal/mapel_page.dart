import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_edspert_fp_learning_app/view/main/latihan_soal/home_page.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({Key? key}) : super(key: key);
  static String route = "mapel_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical :8.0,
          horizontal: 20,
        ),
        child: ListView.builder(itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){

            },
            child: MapelWIdget()); 
        }),
      ),
    );
    
  }
}