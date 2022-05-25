import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/signup.dart';
import 'package:test/provider/conversation_provider.dart';
import 'package:test/provider/locator.dart';

import 'package:test/services/user_service.dart';

import 'provider/auth_provider.dart';

void main() {
  setupLocator();
  return runApp(
    MultiProvider(
      providers: [
        //recherche ChangeNotifierProvider sans <ConversationProvider>
       ChangeNotifierProvider(create: (_) => locator<ConversationProvider>()),
        ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

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
