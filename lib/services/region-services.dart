import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/services/url_db.dart';

Future region() async {
  List<dynamic> datajson;
  List<dynamic> data = [];
  try {
    var response = await http.get(Uri.parse(regionmap));
    data = datajson = jsonDecode(response.body);
    return data;
  } catch (_) {}
}

Future<List<dynamic>> searchblocPoubelleurl(id) async {
  List<dynamic> datajson;
  List<dynamic> data = [];
  var response = await http.get(Uri.parse(searchblocPoubelle + "$id"));
  data = datajson = jsonDecode(response.body);
  print(data);

  return data;
}
