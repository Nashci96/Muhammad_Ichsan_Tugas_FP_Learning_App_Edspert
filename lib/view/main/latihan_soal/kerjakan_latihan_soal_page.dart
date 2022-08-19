import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_edspert_fp_learning_app/models/kerjakan_soal_list.dart';
import 'package:flutter_edspert_fp_learning_app/repository/latihan_soal_api.dart';

import '../../../models/network_response.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<KerjakanLatihanSoalPage> createState() => _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage> {
  KerjakanSoalList? soalList;
  getQuestionList() async {
    final result = await LatihanSoalApi().postQuestionList(widget.id);
    if (result.status == Status.success){
      soalList = KerjakanSoalList.fromJson(result.data!);
      setState(() {
        
      });
      }
    }
    @override
    void initState(){
      super.initState();
      getQuestionList();
    }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Soal")
      ),
      bottomNavigationBar: Container(),
      body: 
        soalList == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
          children: [
            Container(),
            Expanded(child: Container())
        ],
      ),
    );
  }
}