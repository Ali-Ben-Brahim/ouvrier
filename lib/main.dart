import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/GoogleMaps.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/signup.dart';
import 'package:test/pages/test.dart';
import 'package:test/services/test.dart';
import 'package:test/services/try.dart';
import 'package:test/services/user_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return Auth();
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reschool',
          home: Login(),
        ));
  }
}
