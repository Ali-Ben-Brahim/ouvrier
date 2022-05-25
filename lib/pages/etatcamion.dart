import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../services/function.dart';

import '../services/url_db.dart';
import '../services/user_service.dart';

class EtatCamion extends StatefulWidget {
  const EtatCamion({Key? key}) : super(key: key);

  @override
  State<EtatCamion> createState() => _EtatCamionState();
}

class _EtatCamionState extends State<EtatCamion> {
  Check check = Check();

  Map<String, dynamic> info = {};
  Future<Map<String, dynamic>> camionData() async {
    Map<String, dynamic> data = {};
    http.Response res = await http.get(Uri.parse(camion), headers: {
      'Authorization':
          'Bearer ${Provider.of<Auth>(context, listen: false).token}',
      'Accept': 'application/json'
    });
    if (res.statusCode == 200) {
      data = jsonDecode(res.body)[1];
    }
    setState(() {
      info = data;
    });
    return data;
  }

  @override
  void initState() {
    camionData();
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
        body: info['volume_maximale_camion'] == null
            ? Center(child: const CircularProgressIndicator())
            : GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                childAspectRatio: 1,
                crossAxisSpacing:10,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.25,
                crossAxisCount: 2,
                children: <Widget>[
                  Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        color: Colors.teal[100],
                        child: Column(
                          children: [
                             const Text("Plastique"),

                            Padding(padding: EdgeInsets.all(5)),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("Image/2.png"
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
                              percent: (info["volume_actuelle_plastique"]/info['volume_maximale_camion']) ,
                              progressColor: check.check(info["volume_actuelle_plastique"]/info['volume_maximale_camion'] ),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center:Text("${info["volume_actuelle_plastique"]/info['volume_maximale_camion']*100} %"),
                              ),
                            ),
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
                        ),
                      ),
                    ],
                  ),
                  Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        color: Colors.teal[100],
                        child: Column(

                          children: [
                             Text("Papier"),

                            Padding(padding: EdgeInsets.all(5)),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("Image/2.png"
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
                              percent: (info["volume_actuelle_papier"]/info['volume_maximale_camion']) ,
                              progressColor: check.check(info["volume_actuelle_papier"]/info['volume_maximale_camion'] ),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center:Text("${info["volume_actuelle_papier"]/info['volume_maximale_camion']*100} %"),
                              ),
                            ),
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
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        color: Colors.teal[100],
                        child: Column(
                          children: [
                             Text("Composte"),

                            Padding(padding: EdgeInsets.all(5)),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("Image/2.png"
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
                              percent: (info["volume_actuelle_composte"]/info['volume_maximale_camion']) ,
                              progressColor: check.check(info["volume_actuelle_composte"]/info['volume_maximale_camion']),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center:Text("${info["volume_actuelle_composte"]/info['volume_maximale_camion']*100} %"),
                              ),
                            ),
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
                        ),
                      ),
                    ],
                  ),
                  Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        color: Colors.teal[100],
                        child: Column(
                          children: [
                             Text("Canette"),

                            Padding(padding: EdgeInsets.all(5)),
                        Stack(alignment: Alignment.center, children: [
                          Image.asset("Image/2.png"
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
                              percent: (info["volume_actuelle_canette"]/info['volume_maximale_camion']) ,
                              progressColor: check.check(info["volume_actuelle_canette"]/info['volume_maximale_camion'] ),
                              backgroundColor: Colors.grey,
                              circularStrokeCap: CircularStrokeCap.round,
                              center:Text("${info["volume_actuelle_canette"]/info['volume_maximale_camion']*100} %"),
                              ),
                            ),
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
                        ),
                      ),
                    ],
                  ),


                ],
              ));
  }
}
