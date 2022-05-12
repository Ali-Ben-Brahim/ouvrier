import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/pages/GoogleMaps.dart';
import 'package:test/pages/etatcamion.dart';
import 'package:test/pages/reclamation.dart';
import 'package:test/pages/test.dart';
import 'package:test/pages/zoneDeDepot.dart';
import 'package:test/pages/signup.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
   int currentIndex = 1;
    List pages = [
     MapSample(),
     EtatCamion(),
     ZoneDepot(),
     Signaler(),
     MyHomePage(),
     Signaler(),

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        
        currentIndex: currentIndex ,
        onTap: (index)=> setState(() =>currentIndex = index

        ), //bottom navigation bar on scaffold
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "état poubelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: "état camion",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: "Zone de dépôt",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem),
            label: "Réclamtion",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: "Scan Poubelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),

        ],
      ),
        body: pages[currentIndex],
    );
  }
}
