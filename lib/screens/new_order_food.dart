import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/global_url.dart';
import 'package:my_app/models/narudzba.dart';
import 'package:my_app/models/narudzba_jela.dart';
import 'package:my_app/widgets/jelo_dropdown.dart';
import 'package:my_app/widgets/prilog_dropdown.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'new_order.dart';

class NovaNarudzbaHrana extends StatefulWidget {
  //const NovaNarudzbaHrana({ Key? key }) : super(key: key);

  @override
  _NovaNarudzbaHranaState createState() => _NovaNarudzbaHranaState();
}

final _formKey = GlobalKey<FormState>();

class _NovaNarudzbaHranaState extends State<NovaNarudzbaHrana> {
  Future<NarudzbaJela> createOrderFood(
      int kolicinaJela, int KolicinaPriloga) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int KlijentId = sharedPreferences.get('klijentId');

    final http.Response response = await http.post(
      Uri.parse('$url/api/NarudzbaJelo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "NarudzbaId": "$NarudzbaId",
        "JeloId": "$jeloId_global",
        "KolicinaJela": "$kolicinaJela",
        "PrilogJelaId": "$prilogId_global",
        "KolicinaPriloga": "$KolicinaPriloga"
      }),
    );


    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) =>
              new AlertDialog(content: Text('Uspješno spremljeno!'), actions: [
                new FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ]));
    } else {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                  content: Text('Niste dobro unijeli podatke!'),
                  actions: [
                    new FlatButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ]));
    }
  }

  TextEditingController _controllerKolicina;
  TextEditingController _controllerKolicinaPriloga;

  @override
  void initState() {
    super.initState();
    _controllerKolicina = TextEditingController();
    _controllerKolicinaPriloga = TextEditingController();
  }

  @override
  void dispose() {
    _controllerKolicina.dispose();
    _controllerKolicinaPriloga.dispose();
    super.dispose();
  }

  Future<Narudzba> updatePrice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double cijenaKonacna = jeloCijena * int.parse(_controllerKolicina.text);
    final http.Response response = await http.put(
      Uri.parse('$url/api/Narudzba/UpdateCijena/$NarudzbaId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "CijenaNarudzbe": "$cijenaKonacna",
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                  content:
                      Text('Cijena vase narudžbe je: $cijenaKonacna ' + 'KM'),
                  actions: [
                    new FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ]));
    } else {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                  content: Text('Niste dobro unijeli podatke!'),
                  actions: [
                    new FlatButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
                backgroundColor: Color.fromRGBO(139, 0, 0, 1),
                title: new GestureDetector(
                  onTap: () {},
                  child: Text('Odaberi jelo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontFamily: 'RobotoMedium')),
                )),
            body: Container(
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/cover.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Form(
                        key: _formKey,
                        child: ListView(children: <Widget>[
                          Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: JeloDropdown()),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: PrilogDropdown()),
                              Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Unesite količinu jela';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(fontSize: 13),
                                    controller: _controllerKolicina,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10.0),
                                        labelText: 'Količina jela',
                                        fillColor: Colors.white,
                                        focusColor:
                                            Color.fromRGBO(139, 0, 0, 1),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  3,
                                        ),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    139, 0, 0, 1),
                                                width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2))),
                                  )),
                              Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Unesite količinu priloga';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 13),
                                    controller: _controllerKolicinaPriloga,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10.0),
                                        labelText: 'Kolicina priloga',
                                        fillColor: Colors.white,
                                        focusColor:
                                            Color.fromRGBO(139, 0, 0, 1),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  3,
                                        ),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    139, 0, 0, 1),
                                                width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2))),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                margin: EdgeInsets.only(top: 15.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    final FormState form1 =
                                        _formKey.currentState;
                                    if (form1.validate()) {
                                      createOrderFood(
                                    int.parse(_controllerKolicina.text),
                                    int.parse(_controllerKolicinaPriloga.text));
                                     updatePrice();
                                    } else {
                                      print('Form is invalid');
                                    }
                                  },
                                  elevation: 0.0,
                                  color: Color.fromRGBO(139, 0, 0, 1),
                                  child: Text("Spasi",
                                      style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ],
                          )
                        ]))))));
  }
}
