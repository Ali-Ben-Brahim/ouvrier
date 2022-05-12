import 'package:flutter/material.dart';
import 'dart:convert';
import '../pages/navbar.dart';
import '../services/url_db.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Auth with ChangeNotifier {
  bool _isLoggedIn = false;
  late User _user;
  late String _token;

  bool get authenticated => _isLoggedIn;
  User get user => _user;

  Future<void> login(Map creeds, context) async {
    print(creeds);
    try {
      http.Response response = await http.post(
        Uri.parse(loginURL),
        body: creeds,
      );
      if (response.statusCode == 200) {
        
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Menu()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 250, 17, 0),
          content: Text('invalid champs'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error from server'),
      ));
    }
  }

  Future<void> loginqr(String valeur, context) async {
    try {
      http.Response response =
          await http.post(Uri.parse(loginQrURL + '/$valeur'));
      if (valeur.isNotEmpty) {
        if (response.statusCode == 200) {
          _user = User.fromJson(jsonDecode(response.body));
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Menu()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 250, 17, 0),
            content: Text('incorrect qr'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 250, 17, 0),
          content: Text('empty qr'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error from server'),
      ));
    }
  }

  Future<void> update(id, Map creeds, context) async {
    try {
      http.Response response =
          await http.post(Uri.parse(updateUserURL + '/$id'), body: creeds);
      if (response.statusCode == 200) {
        _user = User.fromJson(jsonDecode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 58, 250, 0),
          content: Text('data updated'),
        ));
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error server'),
      ));
    }
  }

  Future<void> updatePassword(id, Map creeds, context) async {
    try {
      http.Response response =
          await http.post(Uri.parse(updatePasswordURL + '/$id'), body: creeds);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 58, 250, 0),
          content: Text('Password updated'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Error server'),
      ));
    }
  }
}
