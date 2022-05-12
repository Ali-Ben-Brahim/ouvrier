import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/pages/reclamation/camion.dart';
import 'package:test/pages/reclamation/poubelle.dart';
import 'package:test/pages/signup.dart';


class Signaler extends StatelessWidget {
  Signaler({Key? key}) : super(key: key);
  List menu = [
    {"name": "Panne Poubelle", "page":  PannePoubelle()},
    {"name": "Panne Camion", "page": PanneCamion()},
    {"name": "Signaler accident", "page": const PannePoubelle()},
    {"name": "Signaler incident", "page": Login()},
    {"name": "Autres", "page": const PannePoubelle()},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          backgroundColor: const Color(0xFF196f3d),
          title: const Text("Récalamtion",
              style: TextStyle(
                fontFamily: "hindi",
                fontSize: 30,
              )),
        ),
        body: ListView.separated(
          itemCount: menu.length,
          itemBuilder: (context, i) {
            return InkWell(
              child: SizedBox(
                height: 125,
                child: Center(
                  child: ListTile(
                    title: Text("${menu[i]['name']}",
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    trailing: Image.asset("Image/arrow-right.png"),
                  ),
                ),
              ),
              onTap: () {
                Get.to(menu[i]['page']);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(thickness: 2);
          },
        ),
      ),
    );
  }
}
