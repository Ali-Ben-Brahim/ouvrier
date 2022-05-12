import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/services/url_db.dart';




Future<List<dynamic>> etablissement() async{
  Map datajson ;
  List<dynamic> data = [];
  var response = await http.get(Uri.parse(etablissment));
    datajson = jsonDecode(response.body);
    data = datajson['data'];
  return data;
}

