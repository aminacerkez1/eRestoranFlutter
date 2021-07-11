import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/klijent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_url.dart';

class FakturaPost extends StatefulWidget {
  FakturaPost({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

bool enabled = true;
final _formKey = GlobalKey<FormState>();

class _MyAppState extends State<FakturaPost> {
  Future<Klijent> createRegistration(String ime, String prezime, String telefon,
      String adresa, String username, String pass, String passconf) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final http.Response response = await http.post(Uri.parse(
      '$url/api/Klijent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Ime": "$ime",
        "Prezime": "$prezime",
        "BrojTelefona": "$telefon",
        "Adresa": "$adresa",
        "Username": "$username",
        "Password": "$pass",
        "PasswordConfirmation": "$passconf"
      }),
    );


    if (response.statusCode == 200) {
     showDialog(
                    context: context,
                    builder: (_) =>  new AlertDialog(
                        content: Text('Uspješno spremljeno!'),
                        actions: [
                new FlatButton(
                  child: Text('Ok'),
                  onPressed:(){ 
                    Navigator.of(context, rootNavigator: true).pop();},
                )
                        ]
                      ));
    } else {
      showDialog(
                      context: context,
                     builder: (_) =>  new AlertDialog(
                        content: Text('Niste dobro unijeli podatke!'),
                        actions: [
                new FlatButton(
                  child: const Text("Ok"),
                  onPressed:(){ 
                    Navigator.of(context, rootNavigator: true).pop();},
                )
                        ]
                      ));
    }
  }

  TextEditingController _controllerIme;
  TextEditingController _controllerPrezime;
  TextEditingController _controllerTel;
  TextEditingController _controllerAdresa;
  TextEditingController _controllerKorIme;
  TextEditingController _controllerLozinka;
  TextEditingController _controllerLozinkaPot;

  @override
  void initState() {
    super.initState();
    _controllerIme = TextEditingController();
    _controllerPrezime = TextEditingController();
    _controllerTel = TextEditingController();
    _controllerAdresa = TextEditingController();
    _controllerKorIme = TextEditingController();
    _controllerLozinka = TextEditingController();
    _controllerLozinkaPot = TextEditingController();
  }

  @override
  void dispose() {
    _controllerIme.dispose();
    _controllerPrezime.dispose();
    _controllerTel.dispose();
    _controllerAdresa.dispose();
    _controllerKorIme.dispose();
    _controllerLozinka.dispose();
    _controllerLozinkaPot.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(139,0,0,1),
          title: const Text('Registracija'),
        ),
        body: Container(
       decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/cover.jpeg"),
            fit: BoxFit.fill,
          ),),
       child:Form(
             key: _formKey,
             child:ListView(children: <Widget>[
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child:
                   TextFormField(
                     validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite ime';
              }
              return null;
            },
                    style: TextStyle(fontSize: 13),
                    controller: _controllerIme,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                     contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Ime',
                      fillColor: Colors.white,
                      focusColor: Colors.purple,
                      labelStyle: TextStyle(
                        color: Colors.black,
                       fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)),
                    ),
                  
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite prezime';
              }
              return null;
            },
                     style: TextStyle(fontSize: 13),
                    controller: _controllerPrezime,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Prezime',
                      fillColor: Colors.white,
                      focusColor: Color.fromRGBO(139,0,0,1),
                      labelStyle: TextStyle(
                        color: Colors.black,
                       fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2))
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite broj telefona';
              }
              return null;
            },
                    controller: _controllerTel,
                     style: TextStyle(fontSize: 13),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Broj telefona',
                      fillColor: Colors.white,
                      focusColor:Color.fromRGBO(139,0,0,1),
                      labelStyle: TextStyle(
                        color: Colors.black,
                       fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite adresu';
              }
              return null;
            },
                    controller: _controllerAdresa,
                     style: TextStyle(fontSize: 13),
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Adresa',
                      fillColor: Colors.white,
                      focusColor: Color.fromRGBO(139,0,0,1),
                      labelStyle: TextStyle(
                        color: Colors.black,
                       fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite korisničko ime';
              }
              return null;
            },
                    controller: _controllerKorIme,
                     style: TextStyle(fontSize: 13),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Korisničko ime',
                      fillColor: Colors.white,
                      focusColor:Color.fromRGBO(139,0,0,1),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite lozinku';
              }
              return null;
            },
                     style: TextStyle(fontSize: 13),
                    obscureText: true,
                    controller: _controllerLozinka,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Lozinka',
                      fillColor: Colors.white,
                      focusColor: Color.fromRGBO(139,0,0,1),
                      labelStyle: TextStyle(
                        color: Colors.black,
                       fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite potvrdu';
              }
              return null;
            },
                     obscureText: true,
                     style: TextStyle(fontSize: 13),
                    controller: _controllerLozinkaPot,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Lozinka potvrda',
                      fillColor: Colors.white,
                      focusColor: Color.fromRGBO(139,0,0,1),
                      labelStyle: TextStyle(
                        color: Colors.black,
                       fontSize: 13.0,
                      ),
                      border: OutlineInputBorder(                        
                      ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)),
                    ),
                  )),
              Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
           onPressed: () {
             final FormState form4 = _formKey.currentState;
                    if(_controllerLozinka.text==_controllerLozinkaPot.text && form4.validate())
                    {
                       createRegistration(_controllerIme.text,_controllerPrezime.text,_controllerTel.text,_controllerAdresa.text,_controllerKorIme.text,_controllerLozinka.text,_controllerLozinkaPot.text);
                    }
                    else
                    {
                      if(_controllerLozinka.text!=_controllerLozinkaPot.text)
                      {
                          showDialog(
                      context: context,
                     builder: (_) =>  new AlertDialog(
                        content: Text('Lozinka i potvrda lozinke nisu dobro uneseni!'),
                        actions: [
                new FlatButton(
                  child: const Text("Ok"),
                  onPressed:(){ 
                    Navigator.of(context, rootNavigator: true).pop();},
                )
                        ]
                      ));
                      }
                      else
                      {
                        showDialog(
                      context: context,
                     builder: (_) =>  new AlertDialog(
                        content: Text('Podaci nisu uneseni!'),
                        actions: [
                new FlatButton(
                  child: const Text("Ok"),
                  onPressed:(){ 
                    Navigator.of(context, rootNavigator: true).pop();},
                )
                        ]
                      ));
                      }
                      }
                      
                    },
        elevation: 0.0,
        color: Color.fromRGBO(139,0,0,1),
        child: Text("Spasi", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),),
            ],
          )
        ]))));
  }
}
 
