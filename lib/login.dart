import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/global_url.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/cover.jpeg"),
            fit: BoxFit.fill,
          ),),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                  buttonRegistration()
                ],
              ),
      ),
    );
  }

  signIn(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'pass': pass};
    var jsonResponse = null;
    var response = await http.get(Uri.parse(
        "$url/api/Klijent/LoginCheck/$username/$pass"));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setInt("klijentId", jsonResponse['klijentId']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed:
            usernameController.text == "" || passwordController.text == ""
                ? null
                : () {
                    setState(() {
                      _isLoading = true;
                    });
                    signIn(usernameController.text, passwordController.text);
                  },
        elevation: 0.0,
        color: Colors.red,
        child: Text("Prijavi se", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container buttonRegistration() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed:(){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FakturaPost()),
  );
        },
        elevation: 0.0,
        color: Color.fromRGBO(139,0,0,1),
        child: Text("Registruj se", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }



  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: usernameController,
            cursorColor: Color.fromRGBO(139,0,0,1),
            style: TextStyle(color: Color.fromRGBO(139,0,0,1)),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Color.fromRGBO(139,0,0,1),),
              hintText: "Korisničko ime",
                border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2)
            ),
          ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
             cursorColor: Color.fromRGBO(139,0,0,1),
            style: TextStyle(color: Color.fromRGBO(139,0,0,1)),
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Color.fromRGBO(139,0,0,1),),
              hintText: "Lozinka",
              border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Color.fromRGBO(139,0,0,1),width: 2)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.red,width: 2),
              
            ),
          ),
          )
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Image(
              image: AssetImage("lib/images/restoo.png"),
              fit: BoxFit.scaleDown,
              alignment: Alignment.center),
        ])
    );
  }
}
