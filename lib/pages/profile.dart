import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';
import 'package:test/services/user_service.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController prenom = TextEditingController();
    final TextEditingController cin = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController NumeroTel = TextEditingController();
  User _user =Provider.of<Auth>(context,listen: false).user;
  name.text = _user.nom! +" "+_user.prenom!;

  cin.text = _user.cin!;
  email.text = _user.email!;
  NumeroTel.text = _user.numeroTelephone!;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title: Center(
            child: const Text("Mes informations",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                )),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Image(
                width: 120,
                image: AssetImage("Image/user.png"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Changer photo"),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  fixedSize: Size(120, 30),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Supprimer image"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  onPrimary: Colors.white,
                  fixedSize: Size(120, 30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller:name,
                decoration: InputDecoration(
                  label: Text("Nom et prénom"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller:cin,
                decoration: InputDecoration(

                  label: Text("CIN"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller:email,
                decoration: InputDecoration(
                  label: Text("E-mail"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: NumeroTel,
                decoration: InputDecoration(
                  label: Text("Numéro de téléphone"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),

                onPressed: () {},

                child: Text('Valider'), // <-- Text
              ),
          ],
        ),
            )),
      ),
    );
  }
}
