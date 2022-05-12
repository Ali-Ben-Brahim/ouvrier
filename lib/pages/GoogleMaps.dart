import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/pages/etat_poubelle.dart';
import 'package:test/pages/reclamation.dart';
import 'package:test/services/test_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test/services/function.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:test/services/region-services.dart';
import '../services/poubelle_service.dart';
import 'package:test/services/bloc_etablissements_services.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  bool visible = false;
  List<dynamic> etablissementData = [];
  List<dynamic> blocEtablissementsData = [];
  List<dynamic> etageEtablissementsData = [];
  List<dynamic> blocPoubelles = [];
  List<dynamic> poubelles = [];
  List<dynamic> blocEtablissements = [];
  List<dynamic> etageEtablissements = [];
  List<dynamic> poubelle = [];
  double moyenPlastique = 0.0;
  double moyenPapier = 0.0;
  double moyenCanette = 0.0;
  double moyenComposte = 0.0;
  int nbrPlastique = 0;
  int nbrPapier = 0;
  int nbrCanette = 0;
  int nbrComposte = 0;
  int sommeEtab = 0;
  bool isEtablissement = true;
  bool isBlock = false;
  bool isEtaget = false;
  bool isPoubelle = false;
  bool isBlockPoubelle = false;
  Map<String, dynamic> data = {};
  Map<String, dynamic> dataPlastique = {};
  Map<String, dynamic> dataPapier = {};
  Map<String, dynamic> dataCanette = {};
  Map<String, dynamic> dataComposte = {};
  String url = '';
  late dynamic timer;
  @override
  void initState() {
    getPostion();

    super.initState();
    remplirEtablissement();

    if (mounted) {
      remplirEtablissement();
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => remplirEtablissement());
    }
  }

  remplirEtablissement() async {
    List<dynamic> dataetab;
    dataetab = await region();
    if (mounted) {
      setState(() {
        etablissementData = dataetab;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // timer.cancel();
  }

  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<Position> positionStream;
  String googleAPiKey = "AIzaSyC0au9FbVLUYFvC5gRFnmXtiNYUgzM8Rwc";
  Set<Marker> markers = {};

  Check check = Check();
  late final CameraPosition _Myplace = const CameraPosition(
      target: LatLng(36.842597, 10.204778), zoom: 14.151926040649414);

  Future<void> goToplace(LatLng place) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: place, zoom: 17)));
  }

  Future getPostion() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Activer la localisation'),
              content: Text(
                  "Pour continuer, activez la localisation de l'appareil, qui utlise le service de localisation de google"),
              actions: <Widget>[
                TextButton(
                    onPressed: () async {
                      await Geolocator.openLocationSettings();
                      Navigator.pop(context);
                    },
                    child: Text('Activer')),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); //close Dialog
                  },
                  child: Text('Annuler'),
                )
              ],
            );
          });
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      if (per == LocationPermission.always) {}
    }
  }

  String title = "";
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: const Radius.circular(24.0),
      topRight: const Radius.circular(24.0),
    );
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;
    final halfw = MediaQuery.of(context).size.width;
    final halfh = MediaQuery.of(context).size.height * 0.8;

    List.generate(etablissementData.length, (i) {
      dynamic infos = etablissementData[i];

      markers.add(
        Marker(
          onTap: () async {
            data = await googleMapId(etablissementData[i]["id"]);
            dataPlastique = await plastique(etablissementData[i]["id"]);
            dataPapier = await papier(etablissementData[i]["id"]);
            dataCanette = await canette(etablissementData[i]["id"]);
            dataComposte = await composte(etablissementData[i]["id"]);

            setState(() {
              moyenPlastique =
                  dataPlastique['moyenne_pourcentage_plastique'].toDouble();
              nbrPlastique = dataPlastique['nombre_poubelle_plastique'];
              nbrPapier = dataPapier['nombre_poubelle_papier'];
              nbrCanette = dataCanette['nombre_poubelle_canette'];
              nbrComposte = dataComposte['nombre_poubelle_composte'];
              moyenPapier = dataPapier['moyenne_pourcentage_papier'].toDouble();
              moyenCanette =
                  dataCanette['moyenne_pourcentage_canette'].toDouble();
              moyenComposte =
                  dataComposte['moyenne_pourcentage_composte'].toDouble();
              blocEtablissementsData = data['bloc_etablissements'];
              title = infos['nom_etablissement'];
              url = infos['url_map'];
              sommeEtab = nbrPlastique + nbrPapier + nbrCanette + nbrComposte;
            });
          },
          markerId: MarkerId(infos['nom_etablissement'].toString()),
          position: LatLng(
              infos['latitude'].toDouble(), infos['longitude'].toDouble()),
          infoWindow: InfoWindow(
              title: infos['nom_etablissement'],
              snippet:
                  'Etat poubelle : ${infos['quantite_dechets_plastique']} %'),
          icon: check.check2(infos['quantite_dechets_plastique'].toDouble()),
        ),
      );
    });

    return Scaffold(
        endDrawer: isBlock
            ? Drawer(
                child: blocEtablissements.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        isEtablissement = false;
                                        isEtaget = true;
                                        isPoubelle = false;
                                        isBlock = false;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isBlock = false;
                                              isEtablissement = true;
                                              isEtaget = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            size: 25,
                                          )))),
                              const Text("Pas du bloc poubelle")
                            ]),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      isEtablissement = false;
                                    });
                                  }
                                },
                                child: SizedBox(
                                    width: double.infinity,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isBlock = false;
                                            isEtablissement = true;
                                            isEtaget = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          size: 25,
                                        )))),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: blocEtablissements.length,
                                itemBuilder: (context, i) {
                                  dynamic info = blocEtablissements[i];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        isEtaget = true;
                                        isBlock = false;
                                        isEtablissement = false;
                                        etageEtablissements =
                                            blocEtablissements[i]
                                                ["etage_etablissements"];
                                      });
                                    },
                                    child: Card(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                  "${info['nom_bloc_etablissement']}"),
                                              subtitle: Text("${info['id']}"),
                                            ),
                                          ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
            : isEtablissement
                ? Drawer(
                    child: ListView.builder(
                      itemCount: etablissementData.length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic infos = etablissementData[index];
                        return InkWell(
                          onTap: () async {
                            data = await googleMapId(infos['id']);
                            if (mounted) {
                              setState(() {
                                isBlock = true;
                                isEtablissement = false;
                                isEtaget = false;

                                blocEtablissements =
                                    data['bloc_etablissements'];
                              });
                            }
                          },
                          child: Card(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title:
                                        Text("${infos['nom_etablissement']}"),
                                    subtitle: Text("${infos['id']}"),
                                  ),
                                ]),
                          ),
                        );
                      },
                    ),
                  )
                : isBlockPoubelle
                    ? Drawer(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 100,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isBlock = false;
                                          isEtablissement = false;
                                          isEtaget = true;
                                          isBlockPoubelle = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 25,
                                      ))),
                              SizedBox(
                                height: halfh,
                                child: ListView.builder(
                                  itemCount: blocPoubelles.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    dynamic infos = blocPoubelles[index];
                                    return InkWell(
                                      onTap: () async {
                                        if (mounted) {
                                          setState(() {
                                            isBlock = true;
                                            isEtablissement = false;
                                            isEtaget = false;
                                          });
                                        }
                                      },
                                      child: Card(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                    "${blocPoubelles[index]['id']}"),
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EtatPoubelle(
                                                                id: blocPoubelles[
                                                                        index]
                                                                    ['id']))),
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Drawer(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 100,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isBlock = true;
                                          isEtablissement = false;
                                          isEtaget = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 25,
                                      ))),
                              SizedBox(
                                height: halfh,
                                child: ListView.builder(
                                  itemCount: etageEtablissements.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    dynamic infos = etageEtablissements[index];
                                    return InkWell(
                                      onTap: () {
                                        if (mounted) {
                                          setState(() {
                                            blocPoubelles =
                                                etageEtablissements[index]
                                                    ["bloc_poubelles"];
                                            isBlock = false;
                                            isEtaget = false;
                                            isBlockPoubelle = true;
                                          });
                                        }
                                      },
                                      child: Card(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                    "${infos['nom_etage_etablissement']}"),
                                                subtitle:
                                                    Text("${infos['id']}"),
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
        appBar: AppBar(
          leading:
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
          backgroundColor: const Color(0xFF196f3d),
        ),
        body: _Myplace == null
            ? const CircularProgressIndicator()
            : Stack(children: [
                SlidingUpPanel(
                  header: Container(
                    width: halfw,
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "$title ($sommeEtab)",
                        style:
                            const TextStyle(fontSize: 24, color: Colors.blue),
                      ),
                    ),
                  ),
                  maxHeight: panelHeightOpen,
                  minHeight: panelHeightClosed,
                  parallaxEnabled: true,
                  parallaxOffset: .5,
                  borderRadius: radius,
                  collapsed: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: radius),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$title",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            icon: const Icon(
                              Icons.directions,
                              size: 50,
                              color: Colors.blue,
                            )),
                      ],
                    )),
                  ),
                  panel: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                            width: 300,
                            height: 400,
                            margin: EdgeInsets.only(top: 100),
                            child: GridView.builder(
                                itemCount: blocEtablissementsData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20),
                                itemBuilder: (context, i) {
                                  etageEtablissementsData =
                                      blocEtablissementsData[i]
                                          ["etage_etablissements"];

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${blocEtablissementsData[i]["nom_bloc_etablissement"]}",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red),
                                        ),
                                        Column(
                                          children: List.generate(
                                              etageEtablissementsData.length,
                                              (index) {
                                            blocPoubelles =
                                                etageEtablissementsData[index]
                                                    ["bloc_poubelles"];
                                            return Column(
                                              children: [
                                                Text(
                                                  "${etageEtablissementsData[index]["nom_etage_etablissement"]}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green),
                                                ),
                                                Column(
                                                  children: List.generate(
                                                      blocPoubelles.length,
                                                      (index) {
                                                    poubelles =
                                                        blocPoubelles[index]
                                                            ["poubelles"];
                                                    return Column(
                                                        children: List.generate(
                                                            poubelles.length,
                                                            (index) {
                                                      return Column(
                                                        children: [
                                                          Text(
                                                            "${poubelles[index]["type"]} ${poubelles[index]["Etat"]}% ",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      );
                                                    }));
                                                  }),
                                                )
                                              ],
                                            );
                                            // Text("${etageEtablissementsData[index]["nom_etage_etablissement"]}");
                                          }),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                        Text(
                            "famille plastique: ${moyenPlastique.toStringAsFixed(2)} % ($nbrPlastique)"),
                        Text(
                            "famille papier: ${moyenPapier.toStringAsFixed(2)} % ($nbrPapier)"),
                        Text(
                            "famille canette: ${moyenCanette.toStringAsFixed(2)} % ($nbrCanette)"),
                        Text(
                            "famille composte:${moyenComposte.toStringAsFixed(2)}  %  ($nbrComposte)"),
                      ],
                    ),
                  ),
                  body: GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: markers,
                    mapType: MapType.normal,
                    initialCameraPosition: _Myplace,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ]));
  }
}
//AIzaSyCM_y_hH1jw8ucuvhzfmGdKMloxPwBjbAo