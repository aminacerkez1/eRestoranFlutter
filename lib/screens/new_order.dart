import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/klijent.dart';
import 'package:my_app/models/narudzba.dart';
import 'package:my_app/models/narudzba_jela.dart';
import 'package:my_app/models/rezervacija.dart';
import 'package:my_app/screens/new_order_food.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_url.dart';

class NovaNarudzba extends StatefulWidget {
  NovaNarudzba({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

bool enabled = true;

class _MyAppState extends State<NovaNarudzba> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  Future<Narudzba> createOrder(DateTime datum, String vrijeme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int KlijentId = sharedPreferences.get('klijentId');

    print(KlijentId.toString());
    double cijena = 0;
    final http.Response response = await http.post(
      Uri.parse('$url/api/Narudzba'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "KlijentId": "$KlijentId",
        "DatumNarudzbe": "$datum",
        "VrijemeNarudzbe": "$vrijeme",
        "CijenaNarudzbe": "$cijena"
      }),
    );
    Map<String, dynamic> neki = jsonDecode(response.body);
    NarudzbaId = neki["narudzbaId"];

    if (response.statusCode == 200) {
      return Narudzba.fromJson(jsonDecode(response.body));
    } else {
      print('nije uspjesno');
    }
  }

  TextEditingController _controllerTime;

  @override
  void initState() {
    super.initState();
    _controllerTime = TextEditingController();
  }

  @override
  void dispose() {
    _controllerTime.dispose();
    super.dispose();
  }

  Narudzba model = Narudzba();

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
                text: _time.hour.toString() + ":" + _time.minute.toString());
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
            child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  Column(
                    children: [
                      Container(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text('Nova narudžba',
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
                              controller: _date,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Unesite datum narudžbe';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelText: 'Datum narudžbe',
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
                              controller: _controllerTime,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Unesite vrijeme narudžbe';
                                }
                                return null;
                              },
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        margin: EdgeInsets.only(top: 15.0),
                        child: RaisedButton(
                          onPressed: () {
                            final FormState form1 = _formKey.currentState;
                            if (form1.validate()) {
                              createOrder(selectedDate, _controllerTime.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NovaNarudzbaHrana()));
                            } else {
                              print('Form is invalid');
                            }
                          },
                          elevation: 0.0,
                          color: Color.fromRGBO(139, 0, 0, 1),
                          child: Icon(
                            FontAwesomeIcons.longArrowAltRight,
                            size: SizeConfig.blockSizeHorizontal * 10,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ],
                  )
                ]))));
  }
}
