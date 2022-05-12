import 'dart:convert';
import 'package:http/http.dart' as http;
import '/services/url_db.dart';


//Bloc Poubelle
Future <List<dynamic>> allBloc(dynamic id) async{
      var response = await http.get(Uri.parse(searchblocPoubelleURL+'/$id'));
      var datajson = jsonDecode(response.body);

      return datajson;

  }
// Poubelle

Future <List <dynamic>> allPoubelle(dynamic id) async{
  var response = await http.get(Uri.parse(searchBlocPoubelleURL+'/$id'));
  var datajson = jsonDecode(response.body) as List < dynamic>;
  return datajson;
}


Future <void> viderPoubelle(dynamic idOuvrier ,dynamic idPoubelle) async{
  var response = await http.get(Uri.parse(viderPoubelleURL + '/$idOuvrier/$idPoubelle'));
}



