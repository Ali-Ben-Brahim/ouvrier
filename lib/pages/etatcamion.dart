import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test/services/function.dart';

import '../services/url_db.dart';

class EtatCamion extends StatefulWidget {
  const EtatCamion({Key? key}) : super(key: key);

  @override
  State<EtatCamion> createState() => _EtatCamionState();
}

class _EtatCamionState extends State<EtatCamion> {
  Check check = Check();
  List<dynamic> data = [];

  List item = [
    {"image": "Image/2.png", "type": "Plastique", 'percent': 90.00},
    {"image": "Image/2.png", "type": "Composte", 'percent': 70.00},
    {"image": "Image/2.png", "type": "Autres", 'percent': 20.00},
    {"image": "Image/2.png", "type": "Cartoon", 'percent': 80.00}
  ];
  @override
  void initState() {
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title: const Text("Etat camion",
              style: TextStyle(
                fontFamily: "hindi",
                fontSize: 30,
              ))),
      body: GridView.count(
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1),
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 20,
        padding: const EdgeInsets.all(20),
        children: List.generate(
            item.length,
            (i) => Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text(
                      item[i]['type'],
                      style: const TextStyle(
                        fontFamily: "hindi",
                        fontSize: 28,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        item[i]['image'],
                        width: 220,
                        height: 230,
                        fit: BoxFit.contain,
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
                          percent: (item[i]['percent']) / 100,
                          progressColor: check.check(item[i]['percent'] / 100),
                          backgroundColor: Colors.grey,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            '${item[i]['percent']} %',
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
                            MaterialStateProperty.all(const Color(0xFFc60001)),
                        fixedSize:
                            MaterialStateProperty.all(const Size(150, 40)),
                      ),
                      onPressed: () {},
                      child: const Text('Vider la poubelle'),
                    ),
                  ],
                ))),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
