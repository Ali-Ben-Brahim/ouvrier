import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../services/poubelle_service.dart';
import '../services/region-services.dart';
import '../services/url_db.dart';
import '../services/user_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> poubelles = [];
  dynamic id;
  remplirEtablissement() async {
    List<dynamic> dataetab;
    dataetab = await searchblocPoubelleurl(id);
    if (mounted) {
      setState(() {
        poubelles = dataetab;
      });
    }
  }

  String qrData = '';
  Future _scan() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              "#000000", "cancel", true, ScanMode.BARCODE)
          .then((value) {
        setState(() {
          qrData = value.toString().trim();
        });
        print("qrData : $qrData");
        qrCode(qrData);
      });
    } catch (_) {}
  }

  alert(nom_etablissement, nom_etage_etablissement, nbr_personnes,
      nom_bloc_etablissement, nom, Etat, type, temps_remplissage) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Column(
                  children: [
                    Text('Nom etablissement : $nom_etablissement'),
                    Text('Nom etage etablissement : $nom_etage_etablissement'),
                    Text(
                        'Nombres des personnes etablissement : $nbr_personnes'),
                    Text('Nom bloc etablissement : $nom_bloc_etablissement'),
                    Text('Nom du poubelle: $nom'),
                    Text('Etat : $Etat'),
                    Text('type : $type'),
                    Text('temps : $temps_remplissage'),
                  ],
                ),
                content: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFc60001)),
                    fixedSize: MaterialStateProperty.all(const Size(150, 40)),
                  ),
                  onPressed: () {
                    viderPoubelle(2, id);
                    if (mounted) {
                      setState(() {
                        remplirEtablissement();
                      });
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Pubelle est vide'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK')),
                              ],
                            );
                          });
                    }
                  },
                  child: const Text('Vider la poubelle'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ]));
  }

  Future qrCode(String data) async {
    try {
      print(
          'qrCode Function ${Provider.of<Auth>(context, listen: false).token}');
      http.Response response =
          await http.post(Uri.parse(viderQr + data), headers: {
        'Authorization':
            'Bearer ${Provider.of<Auth>(context, listen: false).token}',
        'Accept': 'application/json'
      });
      print("RESPONSEqrCode : ${response.body}");
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        print("$list");
        print("${list['nom_etablissement']}");
        id = list['id'];
        alert(
          list['nom_etablissement'],
          list['nom_etage_etablissement'],
          list['nbr_personnes'],
          list['nom_bloc_etablissement'],
          list['nom'],
          list['Etat'],
          list['type'],
          list['temps_remplissage'],
        );
        print(
          "list: ${list['nom_etablissement']}",
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title: Center(
            child: const Text("Scan poubelle",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                )),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  "Veuillez scanner le code QR de la poubelle devant vous en cliquant au-dessous : ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    size: 250,
                  ),
                ),
                onTap: () => _scan(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
