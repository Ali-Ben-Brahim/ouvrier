import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/reclamation/camion.dart';
import 'package:test/pages/reclamation/poubelle.dart';
import 'package:test/pages/signup.dart';

import '../models/conversations_model.dart';
import '../provider/conversation_provider.dart';
import '../services/user_service.dart';
import 'chat.dart';

class Signaler extends StatefulWidget {
  const Signaler({Key? key}) : super(key: key);

  @override
  State<Signaler> createState() => _SignalerState();
}

class _SignalerState extends State<Signaler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Réclamation'),
        backgroundColor: Color.fromRGBO(75, 174, 79, 1),
      ),
      body: InkWell(
        onTap: () async {
          dynamic token = Provider.of<Auth>(context, listen: false).token;

          var conversations =
              await Provider.of<ConversationProvider>(context, listen: false)
                  .addConversation(token);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Chat(
                      conversation:
                          ConversationModel.fromJson(conversations))));
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
          children: const [
            SizedBox(
              height: 250,
              child: Image(
                image: AssetImage('image/service.png'),
              ),
            ),
            Center(
                child: Text(
              "Messages",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
