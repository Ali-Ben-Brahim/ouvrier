
import 'package:http/http.dart' as http;
import 'package:test/services/url_db.dart';

class AuthService{

  Future getUser(token) async{
    try{
      http.Response response =await http.get(
        Uri.parse(profileURL),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'}
        ) ;
      return response;

    }catch(_){}
  }

  Future login(creeds) async{
      try{
        http.Response response =await http.post(
          Uri.parse(loginURL),

          body: creeds
          );
        return response;

      }catch(_){}
  }

  Future<void> logout(String? token) async{
    try{
      http.Response response = await http.post(
        Uri.parse(logoutURL),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        },
      );

    }catch(_){}
  }

  Future update(id , creeds ,token)async{
    try{
      http.Response response = await http.post(
        Uri.parse(updateUserURL+'/$id'),
        body :creeds,
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        }
      );

      return response;

    }catch(_){}
  }

}