import 'dart:convert';

import 'package:my_app/models/ocjena.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../global_url.dart';

Future<Ocjena> addStars(int ocjena, int jelo) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int KlijentId = sharedPreferences.get('klijentId');

  final http.Response response = await http.post(
    Uri.parse('$url/api/Ocjena'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "KlijentId": "$KlijentId",
      "Ocjena1": "$ocjena",
      "JeloId": "$jelo"
    }),
  );
}
