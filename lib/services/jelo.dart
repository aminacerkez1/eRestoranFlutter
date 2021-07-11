import 'dart:convert';
import 'package:my_app/models/jelo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

Future<List<Jelo>> getAllDish() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var address =
      "$url/api/Jelo";
  final response = await http.get(Uri.parse(Uri.encodeFull(address)));
    
  var body = json.decode(response.body) as List<Object>;

  return body.map((p) => Jelo.fromJson(p)).toList();
}




