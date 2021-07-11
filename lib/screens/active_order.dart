import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/narudzba.dart';
import 'package:my_app/models/rezervacija.dart';
import 'package:my_app/services/narudzba.dart';
import 'package:my_app/services/rezervacija.dart';

import 'order_detail.dart';

class AktivnaNarudzba extends StatefulWidget {
  @override
  _HistorijaRezervacijaState createState() => _HistorijaRezervacijaState();
}

class _HistorijaRezervacijaState extends State<AktivnaNarudzba> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
        child: Column(children: [
          FutureBuilder<List<Narudzba>>(
            future: getAllOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Narudzba> data = snapshot.data;
                return Expanded(
                    child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                            backgroundColor: Colors.white,
                            body: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                if (data[index].naCekanju == true) {
                                  return Card(
                                      color: Colors.red,
                                      child: ListTile(
                                          onTap: () {
                                           
                                          },
                                          subtitle: Container(
                                              child: Column(children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text('Datum narudžbe: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'RobotoMedium',
                                                                color: Colors
                                                                    .white,
                                                                height: 1.3)),
                                                    Text(
                                                        DateTime.parse(data[index]
                                                                    .datumNarudzbe)
                                                                .day
                                                                .toString() +
                                                            "." +
                                                            DateTime.parse(data[
                                                                        index]
                                                                    .datumNarudzbe)
                                                                .month
                                                                .toString() +
                                                            "." +
                                                            DateTime.parse(data[
                                                                        index]
                                                                    .datumNarudzbe)
                                                                .year
                                                                .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'RobotoMedium',
                                                                color: Colors
                                                                    .white,
                                                                height: 1.3))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text('Vrijeme: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'RobotoMedium',
                                                                color: Colors
                                                                    .white,
                                                                height: 1.3)),
                                                    Text(
                                                        data[index]
                                                            .vrijemeNarudzbe,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'RobotoMedium',
                                                                color: Colors
                                                                    .white,
                                                                height: 1.3))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text('Cijena narudžbe: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'RobotoMedium',
                                                                color: Colors
                                                                    .white,
                                                                height: 1.3)),
                                                    Text(
                                                        data[index]
                                                            .cijenaNarudzbe
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'RobotoMedium',
                                                                color: Colors
                                                                    .white,
                                                                height: 1.3))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]))));
                                } else {
                                  return Container();
                                }
                              },
                            ))));
              }
              return CircularProgressIndicator(color: Colors.red);
            },
          ),
        ]));
  }
}
