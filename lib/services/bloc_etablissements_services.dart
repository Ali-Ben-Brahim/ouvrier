import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/services/url_db.dart';

Future<Map<String, dynamic>> googleMapId(id) async {
 Map<String, dynamic> data = {};
  http.Response res = await http
      .get(Uri.parse(regionmap+'/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[0]);
  }
  return data;
}
Future<Map<String, dynamic>> plastique(id) async {
 Map<String, dynamic> data = {};
  http.Response res = await http
      .get(Uri.parse(regionmap+'/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[1]);
  }
  return data;
}
Future<Map<String, dynamic>> papier(id) async {
 Map<String, dynamic> data = {};
  http.Response res = await http
      .get(Uri.parse(regionmap+'/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[2]);
  }
  return data;
}
Future<Map<String, dynamic>> canette(id) async {
 Map<String, dynamic> data = {};
  http.Response res = await http
      .get(Uri.parse(regionmap+'/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[3]);
  }
  return data;
}
Future<Map<String, dynamic>> composte(id) async {
 Map<String, dynamic> data = {};
  http.Response res = await http
      .get(Uri.parse(regionmap+'/$id'));
  if (res.statusCode == 200) {
    data = (jsonDecode(res.body)[4]);
  }
  return data;
}
