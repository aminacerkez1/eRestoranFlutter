import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/widgets/size_config.dart';

class MyDrawer extends StatelessWidget {
  final Function onTap;

  MyDrawer({this.onTap});

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Container(
                    child: Text(''),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("lib/images/restoo.png"),
                          fit: BoxFit.contain,
                          alignment: Alignment.topLeft))),
                           Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 0.0),
                    leading: ClipOval(
                      child: Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        color: Colors.white70,
                        child: InkWell(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 7.0),
                          child: Icon(
                            FontAwesomeIcons.utensils,
                              color: Color.fromRGBO(139,0,0,1),
                            size: SizeConfig.safeBlockHorizontal * 5,
                          ),
                        )),
                      ),
                    ),
                    title: Text(
                      "JELOVNIK",
                      style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoMedium'),
                    ),
                    onTap: () => onTap(context, 0),
                  )),
                           Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: ExpansionTile(
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: 4, vertical: 0.0),
                  leading: ClipOval(
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      color: Colors.white70,
                      child: InkWell(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 7.0),
                        child: Icon(
                          FontAwesomeIcons.calendarAlt,
                           color: Color.fromRGBO(139,0,0,1),
                          size: SizeConfig.safeBlockHorizontal * 5,
                        ),
                      )),
                    ),
                  ),
                  title: Text(
                    "REZERVACIJA",
                    style: TextStyle(
                        color: Color.fromRGBO(139,0,0,1),
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                        fontFamily: 'RobotoMedium'),
                  ),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 45),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              child: ListTile(
                                title: Text(
                                  'Nova rezervacija',
                                  style: TextStyle(
                                      color: Color.fromRGBO(139,0,0,1),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      fontFamily: 'RobotoMedium'),
                                ),
                                onTap: () => onTap(context, 1),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              child: ListTile(
                                title: Text(
                                  'Historija rezervacija',
                                  style: TextStyle(
                                      color: Color.fromRGBO(139,0,0,1),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      fontFamily: 'RobotoMedium'),
                                ),
                                onTap: () => onTap(context, 2),
                              ),
                            ),
                          ]))])),
                            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: ExpansionTile(
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: 4, vertical: 0.0),
                  leading: ClipOval(
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      color: Colors.white70,
                      child: InkWell(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 7.0),
                        child: Icon(
                          FontAwesomeIcons.shoppingCart,
                           color: Color.fromRGBO(139,0,0,1),
                          size: SizeConfig.safeBlockHorizontal * 5,
                        ),
                      )),
                    ),
                  ),
                  title: Text(
                    "NARUDŽBA",
                    style: TextStyle(
                        color: Color.fromRGBO(139,0,0,1),
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                        fontFamily: 'RobotoMedium'),
                  ),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 45),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              child: ListTile(
                                title: Text(
                                  'Nova narudžba',
                                  style: TextStyle(
                                      color: Color.fromRGBO(139,0,0,1),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      fontFamily: 'RobotoMedium'),
                                ),
                                onTap: () => onTap(context, 3),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              child: ListTile(
                                title: Text(
                                  'Historija narudžbi',
                                  style: TextStyle(
                                      color: Color.fromRGBO(139,0,0,1),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                      fontFamily: 'RobotoMedium'),
                                ),
                                onTap: () => onTap(context, 4),
                              ),
                            ),
                          ]))])),
                            Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 0.0),
                    leading: ClipOval(
                      child: Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        color: Colors.white70,
                        child: InkWell(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 7.0),
                          child: Icon(
                            FontAwesomeIcons.user,
                              color: Color.fromRGBO(139,0,0,1),
                            size: SizeConfig.safeBlockHorizontal * 5,
                          ),
                        )),
                      ),
                    ),
                    title: Text(
                      "PROFIL",
                      style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoMedium'),
                    ),
                    onTap: () => onTap(context, 5),
                  )),
                           Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 0.0),
                    leading: ClipOval(
                      child: Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        color: Colors.white70,
                        child: InkWell(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 7.0),
                          child: Icon(
                            FontAwesomeIcons.phone,
                              color: Color.fromRGBO(139,0,0,1),
                            size: SizeConfig.safeBlockHorizontal * 5,
                          ),
                        )),
                      ),
                    ),
                    title: Text(
                      "KONTAKT",
                      style: TextStyle(
                          color: Color.fromRGBO(139,0,0,1),
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          fontFamily: 'RobotoMedium'),
                    ),
                    onTap: () => onTap(context, 6),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
