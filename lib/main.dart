import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/login.dart';
import 'package:my_app/screens/contact.dart';
import 'package:my_app/screens/history_order.dart';
import 'package:my_app/screens/history_reservation.dart';
import 'package:my_app/screens/menu.dart';
import 'package:my_app/screens/new_order.dart';
import 'package:my_app/screens/new_reservation.dart';
import 'package:my_app/screens/profile.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:my_app/widgets/tabs.dart';
import 'package:my_app/widgets/tabs_order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'drawer.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(accentColor: Colors.white70),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  int index = 0;
  int _currentIndex = 0;
  String _title = 'Jelovnik';
  List<Widget> list = [
    Jelovnik(),
    NovaRezervacija(),
    Tabs(),
    NovaNarudzba(),
    TabsOrder(),
    Profil(),
    Kontakt()
  ];

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getInt('klijentId') == null){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(139,0,0,1),
         title: new GestureDetector(
              onTap: () {},
              child: Text(_title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      fontFamily: 'RobotoMedium')),
            ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
             child: Icon(FontAwesomeIcons.signOutAlt,
                      size: SizeConfig.safeBlockHorizontal * 5,
                      color: Colors.white),
          ),
        ],
      ),
      body: list[index],
          drawer: MyDrawer(
            onTap: (ctx, i) {
              setState(() {
                index = i;
                _currentIndex = i;
                switch (_currentIndex) {
                  case 0:
                    {
                      _title = 'Jelovnik';
                    }
                    break;
                  case 1:
                  case 2:
                    {
                      _title = 'Rezervacija';
                    }
                    break;
                    case 3:
                    case 4:
                      {
                      _title = 'Narudžba';
                    }
                     break;
                      case 5:
                      {
                      _title = 'Profil';
                    }
                     break;
                      case 6:
                      {
                      _title = 'Kontakt';
                    }
                     break;
                }
                Navigator.pop(ctx);
                print(index);
              });
            },
          ),
        );
  }
}
