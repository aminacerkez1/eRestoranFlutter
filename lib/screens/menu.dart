import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:my_app/models/jelo.dart';
import 'package:my_app/services/jelo.dart';
import 'package:my_app/widgets/jelo_detalji.dart';
import 'package:my_app/widgets/size_config.dart';
class Jelovnik extends StatefulWidget {
  //const Jelovnik({ Key? key }) : super(key: key);

  @override
  _JelovnikState createState() => _JelovnikState();
}

class _JelovnikState extends State<Jelovnik> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
                  children: [
                    FutureBuilder<List<Jelo>>(
                        future: getAllDish(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            List<Jelo> data1 =
                                snapshot.data;
                            return Expanded(
                                child: MaterialApp(
                              debugShowCheckedModeBanner: false,
                              home: Scaffold(
                                body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/cover.jpeg"),
                fit: BoxFit.fill,
              ),
            ),      
                            child: GroupedListView<Jelo,
                                    String>(
                                  elements: data1,
                                  groupBy: (element) =>
                                      element.vrstaJela, //grupisanje po kasama
                                  groupComparator: (value1,
                                          value2) => //poredjenje vrijednosti
                                      value1.toUpperCase().toString().compareTo(
                                          value2.toUpperCase().toString()),
                                  itemComparator: (item1, item2) =>
                                      item1.naziv.compareTo(item2.naziv),
                                  sort: true,
                                  useStickyGroupSeparators: false,
                                  groupSeparatorBuilder: (String value) =>
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 1.0, bottom: 1.0),
                                          child: Container(
                                            color:
                                               Color.fromRGBO(139,0,0,1),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 1, right: 1),
                                                  child: Text(
                                                    value, //vrijednost naziv
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3.5,
                                                        fontFamily:
                                                            'RobotoBold',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              
                                              ],
                                            ),
                                          )),
                                  itemBuilder: (c, element) {
                                    return Container(
                                       child: Card(
                                         
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JeloDetalji(element.prosjecnaOcjena, element.jeloId)));
          },
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical*8,
            child:Padding(
              padding: EdgeInsets.all(5),
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(element.naziv.toString(),style: TextStyle(fontSize: SizeConfig.blockSizeVertical*2),),
                Text(element.cijena.toString()+" KM",style: TextStyle(fontSize: SizeConfig.blockSizeVertical*2),)
            ],)
            )
          ),
        ),
      ),
                                    );
                                  },
                                ),
                              ),
                            )));
                          } else {
                            return Container(
                                child: Center(child:CircularProgressIndicator(   
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red,
                              ),
                                )
                            ));
                          }
                        }),
                  ]));
  }
}