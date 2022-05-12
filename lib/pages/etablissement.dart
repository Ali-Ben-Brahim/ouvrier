import 'dart:async';
import 'package:flutter/material.dart';
import '../services/etablissment_service.dart';
import '../services/poubelle_service.dart';
import 'etat_poubelle.dart';

class Etablissements extends StatefulWidget {
  const Etablissements({Key? key}) : super(key: key);

  @override
  State<Etablissements> createState() => _EtablissementsState();
}

class _EtablissementsState extends State<Etablissements> {
  bool visible = false;
  List<dynamic> etablissementdata = [];
  List<dynamic> bloc = [];

  late dynamic timer;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      remplir();
      timer =
          Timer.periodic(const Duration(seconds: 5), (Timer t) => remplir());
    }
  }

  remplir() async {
    List<dynamic> data;
    data = await etablissement();
    if(mounted){
      setState(() {
        etablissementdata = data;
      });
    }
  }

  void affiche(id) async {
    List<dynamic> data = await allBloc(id);
    if(mounted){
      setState(() {
        bloc = data;
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: visible
          ? Drawer(
              child: bloc.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                if(mounted){
                                  setState(() {
                                      visible = false;
                                    });
                                }
                              },
                                child: const SizedBox(
                                    width: double.infinity,
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 25,
                                    ))),
                            const Text("Pas du bloc poubelle")
                          ]),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: (){
                                if(mounted){
                                  setState(() {
                                      visible = false;
                                    });
                                }
                              },
                              child: const SizedBox(
                                  width: double.infinity,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                  ))),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: bloc.length,
                              itemBuilder: (context, i) {
                                dynamic info = bloc[i];
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           EtatPoubelle(id: info['id'])),
                                    // );
                                  },
                                  child: Card(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title:
                                                Text("${info['emplacement']}"),
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
          : Drawer(
              child: ListView.builder(
                itemCount: etablissementdata.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic infos = etablissementdata[index];
                  return InkWell(
                    onTap: () {
                      if(mounted){
                        setState(() {
                        visible = true;
                        affiche(infos['id']);
                      });
                      }

                    },
                    child: Card(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        ListTile(
                          title: Text("${infos['nom_etablissement']}"),
                          subtitle: Text("${infos['id']}"),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
