import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget 
{
  IconData icon;
  String text;
  Function onTap;

  CustomListTitle(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context) 
  {
    return InkWell(
      onTap: onTap,
      child: Container(
     padding: EdgeInsets.all(10.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[ 
       Icon(
       icon,
       size: 27.0,
       color:Color.fromRGBO(151, 14, 198, 1),
       ),
       Text(
       '    ',
       ),
       Text(
       text,
       //textAlign: TextAlign.left,
       style: TextStyle(fontSize: 15.0,
       fontFamily: 'Roboto', 
       color: Colors.black,
       ),
       )
      ],
      ),
      ),
     
    );
  }
  
}