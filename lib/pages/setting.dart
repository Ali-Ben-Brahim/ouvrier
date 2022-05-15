import 'package:flutter/material.dart';
import 'package:test/pages/profile.dart';
import 'package:test/pages/resetPassword.dart';
import 'package:test/pages/signup.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(

          backgroundColor: const Color(0xFF196f3d),
          title: Center(
            child: const Text("Profile",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                )),
          )),
      body: Center(child: Column( crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [


ElevatedButton.icon(
  style: ElevatedButton.styleFrom(

              fixedSize:  Size(300, 50),
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
  onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => Profile()),
                        ));
  },
  icon: Icon( // <-- Icon
    Icons.account_circle_rounded,
    size: 24.0,
  ),
  label: Text('Mes information'), // <-- Text
),
ElevatedButton.icon(
style: ElevatedButton.styleFrom(

              fixedSize:  Size(300, 50),
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
  onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ResetPassword()),
                        ));
  },
  icon: Icon( // <-- Icon
    Icons.lock_reset,
    size: 24.0,

  ),
  label: Text('Changer mot de passe'), // <-- Text
),
ElevatedButton.icon(
  style: ElevatedButton.styleFrom(

              fixedSize:  Size(300, 50),
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
  onPressed: () {},
  icon: Icon( // <-- Icon
    Icons.info,
    size: 24.0,
  ),
  label: Text('A propos'), // <-- Text
),
ElevatedButton.icon(
  style: ElevatedButton.styleFrom(

              fixedSize:  Size(300, 50),
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
  onPressed: () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => Login()),
                        ));
  },
  icon: Icon( // <-- Icon
    Icons.logout,
    size: 24.0,
  ),
  label: Text('Déconnecter'), // <-- Text
),
    ],)),);
  }
}