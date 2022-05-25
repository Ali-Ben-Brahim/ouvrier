import 'dart:convert';
import '../services/url_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
class AuthProvider extends ChangeNotifier {
  AuthService _authService = new AuthService();
  bool _busy = false ;
  String? _token ;
  UserModel? _user;
  List<UserModel> _allUsers =[];

  List<UserModel> get allUsers => _allUsers;
  String? get tokens => _token;
  bool get busy => _busy;
  UserModel? get user =>_user;

  setBusy(bool val){
    _busy = val;
    notifyListeners();
  }

  Future <bool> getUser()async{
      setBusy(true);
      bool tokenExist = await getToken();
      if(tokenExist){
        final prefs = await SharedPreferences.getInstance();
        String? prefsToken = prefs.getString('acces_token');
        http.Response response = await _authService.getUser(prefsToken);
        if(response.statusCode == 200){
          try{
            var data = jsonDecode(response.body);
            _token = prefs.getString('acces_token');
            _user = UserModel.fromJson(data['user']);
            Get.offAllNamed('/Accueil');
            return true;
          }catch(_){

          }
        }else{
          setBusy(false);
          return false;
        }
      }
      setBusy(false);
      return false;


  }

  Future <bool> getToken() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('acces_token');
    if(token != null){
      return true;
    }
    return false;
  }

  Future <void> saveToken(String token)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('acces_token');
    prefs.setString('acces_token', token);
  }



  Future <void> logout() async{
    await _authService.logout(_token);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('acces_token');

  }


  Future<void> login(Map creeds , context)async{

    try{
      http.Response response = await _authService.login(creeds);
      if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        String token = data['token'];
        _token = token;
        saveToken(token);
        var datauser = await _authService.getUser(token);
        data = jsonDecode(datauser.body);
        _user = UserModel.fromJson(data['user']);
        Get.offAllNamed('/Accueil');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 250, 17, 0),
            content: Text('coordonnées invalides'),
        ));
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 250, 17, 0),
            content: Text('Erreur serveur'),
        ));
    }
  }

  Future <void>loginqr(String valeur , context) async {
    try{
      http.Response response = await http.post(Uri.parse(loginQrURL + '/$valeur'));
      if(valeur.isNotEmpty){
        if(response.statusCode == 200){

          Get.offAllNamed('/Accueil');
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 250, 17, 0),
              content: Text('incorrect qr'),
          ));
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 250, 17, 0),
              content: Text('empty qr'),
          ));
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 250, 17, 0),
              content: Text('Error from server'),
      ));
    }
  }

  Future <void>update(id ,Map creeds ,context)async{
    try{
      http.Response response = await _authService.update(id ,creeds , _token);
      if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        _user = UserModel.fromJson(data['client']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 58, 250, 0),
            content: Text('données est changée avec succès'),
        ));
        notifyListeners();
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Erreur server'),
      ));
    }
  }

  Future <void>updatePassword (email, Map creeds,context) async{
    try{
      http.Response response = await http.post(Uri.parse(updatePasswordURL+'/$email') ,
      body: creeds ,
      headers: {
        'Authorization' : 'Bearer $_token',
        'Accept' : 'application/json'
      } );
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 58, 250, 0),
            content: Text('mot de passe est changée avec succès'),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('mot de passe incorrecte'),
      ));
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 250, 17, 0),
        content: Text('Erreur server'),
      ));
    }
  }




}