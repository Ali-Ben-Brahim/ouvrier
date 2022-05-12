import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:test/pages/reclamation.dart';

class PannePoubelle extends StatefulWidget {
  const PannePoubelle({Key? key}) : super(key: key);

  @override
  State<PannePoubelle> createState() => _PannePoubelleState();
}

class _PannePoubelleState extends State<PannePoubelle> {
  TextEditingController c = new TextEditingController();

  File? image;
  final imagepicker = ImagePicker();
  Future uploadImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print("failed to pick : $e");
    }
  }

  _Scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "cancel", true, ScanMode.BARCODE)
        .then((value) => setState(() => c.text = value));

  }

  @override
  Widget build(BuildContext context) {
    List<String> typePanne = [
      "Capteur en panne",
      "Poubelle",
      "panne 3",
      "panne 4"
    ];
    String? selectPanne = "Capteur en panne";
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.to(Signaler())
            ),
            backgroundColor: const Color(0xFF196f3d),
            title: const Text("Panne Poubelle",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                ))),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: uploadImage,
                        icon: const Icon(Icons.add_a_photo),
                        iconSize: 100,
                      )),
                  Container(
                      alignment: Alignment.center,
                      child: image == null
                          ? const Text("No Image")
                          : Image.file(image!)),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                            controller: c,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              labelText: "Nom de la poubelle",
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF196f3d))),
                            )),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _Scan();
                          },
                          child: const Icon(
                            Icons.qr_code,
                            color: Colors.white,
                            size: 25,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(17),
                            primary: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectPanne,
                    items: typePanne.map((e) {
                      return DropdownMenuItem(
                        child: Text("$e"),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {});
                      selectPanne = val;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 70, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF196f3d))),
                        border: OutlineInputBorder(),
                        hintText: "écrire ici",
                        labelText: "veuillez saisir votre probleme"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                      label: const Text("Envoyer"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        primary: const Color(0xFF196f3d),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
