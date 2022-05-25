import 'dart:async';

import 'package:flutter/material.dart';
import '../services/bloc_etablissements_services.dart';
import '../services/function.dart';
import '../services/region-services.dart';
import '/services/poubelle_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EtatPoubelle extends StatefulWidget {
  final dynamic id;
  const EtatPoubelle({Key? key, required this.id}) : super(key: key);

  @override
  State<EtatPoubelle> createState() => _EtatPoubelleState();
}

class _EtatPoubelleState extends State<EtatPoubelle> {
  late dynamic timer;
  Check check = Check();
  List<dynamic> poubelle = [];
  List<dynamic> etablissementData = [];
  List<dynamic> blocEtablissementsData = [];
  List<dynamic> etageEtablissementsData = [];
  List<dynamic> blocPoubelles = [];
  List<dynamic> poubelles = [];
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    if (mounted) {
      remplirEtablissement();
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => remplirEtablissement());
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  remplirEtablissement() async {
    List<dynamic> dataetab;
    dataetab = await searchblocPoubelleurl(widget.id);
    if (mounted) {
      setState(() {
        poubelles = dataetab;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: poubelles.isEmpty
          ? const Center(
              child: Text("Bloc vide"),
            )
          : GridView.count(
scrollDirection: Axis.vertical,
childAspectRatio: 0.5 ,
              crossAxisCount:2,

              crossAxisSpacing: 4,
              padding: const EdgeInsets.all(10),
              children: List.generate(poubelles.length ,(index) {
                return  Column(
                                  children: [
                                    Column(children: [Text(
                                      poubelles[index]['type'],

                                      style: const TextStyle(
                                        fontFamily: "hindi",
                                        fontSize: 28,
                                      ),
                                    ),

                                    const Padding(padding: EdgeInsets.all(5)),
                                    Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "images/${poubelles[index]['type']}.png"),
                                            width: 220.0,
                                            height: 230.0,

                                          ),
                                          Container(
                                            width: 80,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(40),
                                                )),
                                            height: 80,
                                            child: CircularPercentIndicator(
                                              animation: true,
                                              radius: 40,
                                              lineWidth: 12,
                                              percent: (poubelles[index]
                                                      ['Etat']) /
                                                  100,
                                              progressColor: check.check(
                                                  (poubelles[index]['Etat']) /
                                                      100),
                                              backgroundColor: Colors.grey,
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              center: Text(
                                                '${poubelles[index]['Etat']} %',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),


                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xFFc60001)),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(150, 40)),
                                      ),
                                      onPressed: () {
                                        viderPoubelle(
                                            2, poubelles[index]['id']);
                                        if (mounted) {
                                          setState(() {
                                            remplirEtablissement();
                                          });
                                        }
                                      },
                                      child: const Text('Vider la poubelle'),
                                    ),],),

                                  ],
                );
              })




            ),
    );
  }
}
