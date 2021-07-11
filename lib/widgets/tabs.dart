import 'package:flutter/material.dart';
import 'package:my_app/screens/active_reservation.dart';
import 'package:my_app/screens/history_reservation.dart';
import 'package:my_app/widgets/size_config.dart';


class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  _MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75))
              ], color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: TabBar(
                  controller: _controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 5.0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  tabs: <Widget>[
                    Tab(
                        icon: Text('Aktivne',
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                color: Colors.black,
                                fontFamily: 'RobotoBold'))),
                    Tab(
                        icon: Text('Prethodne',
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                                color:Colors.black,
                                fontFamily: 'RobotoBold'))),
                   
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  AktivnaRezervacija(),
                  HistorijaRezervacija(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
