import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/jelo.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:my_app/widgets/vrati_nazivJela.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

class JeloDetalji extends StatelessWidget {
  String prosjecnaOcjena;
  int jeloId;

  JeloDetalji(this.prosjecnaOcjena, this.jeloId);

  Future<List<Jelo>> getRecommendedJelo() async {
    var address = "$url/api/Jelo/getRecommendedJelo/$jeloId";
    final response = await http.get(Uri.parse(Uri.encodeFull(address)));

    var body = json.decode(response.body) as List<Object>;

    return body.map((p) => Jelo.fromJson(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                title: GestureDetector(
                  onTap: () {},
                  child: Text('Detalji jela',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontFamily: 'RobotoMedium')),
                )),
            body: Container(
                child: Column(children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
                    child:Container(
  child: (prosjecnaOcjena!=null)
  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ocjena jela: ',
                            style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                fontFamily: 'RobotoMedium',
                                color: Colors.red,
                                height: 1.3)),
                                Text(prosjecnaOcjena)
                      ])
  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ocjena jela: ',
                            style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                fontFamily: 'RobotoMedium',
                                color: Colors.red,
                                height: 1.3)),
                                Text('jelo nije ocjenjeno')
                      ])
)
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Predložena jela: ',
                            style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                fontFamily: 'RobotoMedium',
                                color: Colors.red,
                                height: 1.3)),
                      ],
                    ),
                  ),
                 FutureBuilder<List<Jelo>>(
                    future: getRecommendedJelo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<Jelo> data = snapshot.data;
                        return Expanded(
                            child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                home: Scaffold(
                                    backgroundColor: Colors.white,
                                    body: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    VratiJelo(
                                                        data[index].jeloId),
                                                    Text(data[index]
                                                        .prosjecnaOcjena)
                                                  ],
                                                )));
                                      },
                                    ))));
                      }
                      return CircularProgressIndicator(color: Colors.red);
                    },
                  ),
                ]))));
  }
}
