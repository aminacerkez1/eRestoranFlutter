import 'package:flutter/material.dart';
import 'package:my_app/widgets/kontaktmapa.dart';
import 'package:my_app/widgets/size_config.dart';

class Kontakt extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Kontakt> {
  @override
  Widget build(BuildContext context) {
      SizeConfig().init(context);
    return Container(
     color: Colors.white,
      child: Column(children: [
         Maps(),
         Padding(padding: EdgeInsets.only(left:20,right: 20,top:20),
           child:
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           Text('Tel:', style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoBold'),),
            Text('+3876 228 961098'),
         ],
         ),
         ),
         Padding(padding: EdgeInsets.all(10),
           child:
         Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           Text('Fax:',style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoBold'),),
            Text('+3876 227 961098'),
         ],
         ),
         ),
          Padding(padding: EdgeInsets.all(10),
           child:
         Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           Text('Email:',style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoBold'),),
            Text('erestoran@outlook.com'),
         ],
         ),
          ),
          Padding(padding: EdgeInsets.all(10),
           child:
         Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           Text('Adresa:',style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoBold'),),
            Text('Kujundžiluk 4, Mostar 88000'),
         ],
         ),
          )
         
      ]
         
    ));
      
  }
}
