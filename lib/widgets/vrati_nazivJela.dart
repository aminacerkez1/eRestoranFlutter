import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/jelo.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

class VratiJelo extends StatelessWidget {
  int JeloID;

  VratiJelo(this.JeloID);

  @override
  Widget build(BuildContext context) {
    Future<Jelo> getSWData() async {
      final response = await http.get(Uri.parse('$url/api/Jelo/$JeloID'));

      if (response.statusCode == 200) {
        return Jelo.fromJson(jsonDecode(response.body));
      } else {
        print('greska');
      }
    }

    return Container(
      child: FutureBuilder<Jelo>(
        future: getSWData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.naziv.toString(),
                style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: 'RobotoMedium',
                    color: Colors.black,
                    height: 1.3));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator(color: Colors.red);
        },
      ),
    );
  }
}
