import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/klijent.dart';
import 'package:my_app/models/rezervacija.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_url.dart';

class NovaRezervacija extends StatefulWidget {
  NovaRezervacija({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

bool enabled = true;
final _formKey = GlobalKey<FormState>();

class _MyAppState extends State<NovaRezervacija> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  //TextEditingController _time = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(139, 0, 0, 1),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: Container(
            height: 450,
            width: 100,
            child: child,
          ),
        );
      },
      initialDate: selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(
            text: picked.year.toString() +
                "-" +
                picked.month.toString() +
                "-" +
                picked.day.toString());
      });
  }

  Future<Klijent> createReservation(
      DateTime datum, String vrijeme, int brojOsoba) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int KlijentId = sharedPreferences.get('klijentId');

    print(KlijentId.toString());
    final http.Response response = await http.post(
      Uri.parse('$url/api/Rezervacija'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "KlijentId": "$KlijentId",
        "DatumRezervacije": "$datum",
        "VrijemeRezervacije": "$vrijeme",
        "BrojOsoba": "$brojOsoba"
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

  TextEditingController _controllerTime;
  TextEditingController _controllerPersonNumber;

  @override
  void initState() {
    super.initState();
    _controllerTime = TextEditingController();
    _controllerPersonNumber = TextEditingController();
  }

  @override
  void dispose() {
    _controllerTime.dispose();
    _controllerPersonNumber.dispose();
    super.dispose();
  }

  Rezervacija model = Rezervacija();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    TimeOfDay _time = TimeOfDay(hour: 00, minute: 00);

    Future<Null> _selectTime(BuildContext context) async {
      {
        final TimeOfDay newTime = await showTimePicker(
          context: context,
          initialTime: _time,
        );
        if (newTime != null) {
          setState(() {
            _time = newTime;
             _controllerTime.value = TextEditingValue(
            text: _time.hour.toString() +
                ":" +
                _time.minute.toString()
               );
      });
        }
      }
    }
      return Container(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/cover.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
              child:Form(
               key:_formKey,
               child:ListView(children: <Widget>[
                Column(
                  children: [
                    Container(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text('Nova rezervacija',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Color.fromRGBO(139, 0, 0, 1),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 3.0),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                             validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Unesite datum rezervacije';
                                      }
                                      return null;
                                    },
                            controller: _date,
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                labelText: 'Datum rezervacije',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(139, 0, 0, 1),
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2))),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 3.0),
                      child: GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                             validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Unesite vrijeme rezervacije';
                                      }
                                      return null;
                                    },
                            controller:_controllerTime ,
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                labelText: 'Vrijeme rezervacije',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(139, 0, 0, 1),
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2))),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: TextFormField(
                           validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Unesite broj osoba';
                                      }
                                      return null;
                                    },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          style: TextStyle(fontSize: 13),
                          controller: _controllerPersonNumber,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: 'Broj osoba',
                              fillColor: Colors.white,
                              focusColor: Color.fromRGBO(139, 0, 0, 1),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(139, 0, 0, 1),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2))),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        onPressed: () {
                          final FormState form2 =
                                        _formKey.currentState;
                                    if (form2.validate()) {
                                     createReservation(selectedDate, _controllerTime.text,
                              int.parse(_controllerPersonNumber.text));
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
              ]))));
    }
  }

