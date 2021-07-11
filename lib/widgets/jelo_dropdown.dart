import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/global_url.dart';
import 'package:my_app/models/jelo.dart';
import 'package:my_app/widgets/size_config.dart';

class JeloDropdown extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<JeloDropdown> {
  String _mySelection;

  final String address = "$url/api/Jelo";

  List data = List(); //edited line

  Future<Jelo> getSWData() async {
    var res = await http.get(Uri.parse(Uri.encodeFull(address)));
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    print(resBody);
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: new DropdownButtonFormField(
         validator: (value) => value == null
                    ? 'Odaberi jelo' : null,
                     decoration: InputDecoration(
                       enabledBorder: UnderlineInputBorder(      
                         borderSide: BorderSide(color:      
                       Colors.red))),
        isExpanded: true,
        hint: Text(
          'Odaberi jelo',
          style: TextStyle(
            fontFamily: 'RobotoMedium',
            fontSize: SizeConfig.safeBlockHorizontal * 3,
            color: Colors.black,
          ),
        ),
        items: data.map((item) {
          return new DropdownMenuItem(
            child: new Text(
              item['naziv'],
              style: TextStyle(fontSize: 13),
            ),
            value: item['jeloId'].toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _mySelection = newVal;
            for (int i = 0; i < data.length; i++) {
              if (data[i]['jeloId'].toString() == _mySelection) {
                jeloCijena = data[i]['cijena'];
                
              }
            }
            jeloId_global = int.parse(_mySelection);
          });
        },
        value: _mySelection,
      ),
    );
  }
}
