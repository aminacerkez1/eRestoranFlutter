import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/narudzba_jela.dart';
import 'package:my_app/models/ocjena.dart';
import 'package:my_app/services/ocjena.dart';
import 'package:my_app/widgets/size_config.dart';
import 'package:my_app/widgets/vrati_nazivJela.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../global_url.dart';

class NarudzbaDetalji extends StatelessWidget {
  int NarudzbaIdDetalji;

  NarudzbaDetalji(this.NarudzbaIdDetalji);

  Future<List<NarudzbaJela>> getAllOrderFood() async {
    var address = "$url/api/NarudzbaJelo/GetByNarudzbe/$NarudzbaIdDetalji";
    final response = await http.get(Uri.parse(Uri.encodeFull(address)));

    var body = json.decode(response.body) as List<Object>;

    return body.map((p) => NarudzbaJela.fromJson(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                title: GestureDetector(
                  onTap: () {},
                  child: Text('Detalji narudžbe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontFamily: 'RobotoMedium')),
                )),
            body: Container(
                color: Colors.white,
                constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
                child: Column(children: [
                  FutureBuilder<List<NarudzbaJela>>(
                    future: getAllOrderFood(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<NarudzbaJela> data = snapshot.data;
                        return Expanded(
                            child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                home: Scaffold(
                                    backgroundColor: Colors.white,
                                    body: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return Column(children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Naručeno jelo: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                5,
                                                            fontFamily:
                                                                'RobotoMedium',
                                                            color: Colors.red,
                                                            height: 1.3)),
                                                VratiJelo(data[index].jeloId)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Količina jela: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                5,
                                                            fontFamily:
                                                                'RobotoMedium',
                                                            color: Colors.red,
                                                            height: 1.3)),
                                                Text(
                                                    data[index]
                                                        .kolicinaJela
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                4,
                                                            fontFamily:
                                                                'RobotoMedium',
                                                            color: Colors.black,
                                                            height: 1.3)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(top: 30),
                                              child: RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  addStars(
                                                    rating.toInt(),
                                                    data[index].jeloId
                                                  );
                                                  print(rating);
                                                },
                                              ))
                                        ]);
                                      },
                                    ))));
                      }
                      return CircularProgressIndicator(color: Colors.red);
                    },
                  ),
                ]))));
  }
}
