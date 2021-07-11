import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:my_app/widgets/size_config.dart';

class Maps extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width:SizeConfig.screenWidth ,
      height: SizeConfig.screenHeight/2.1,
        child: Padding(padding: EdgeInsets.all(10),
          child:Stack(children: [
 GoogleMap(initialCameraPosition: CameraPosition(target:
      LatLng(43.33316900000002,17.8154473342795),
        zoom: 12,),
          )
          ]
        )
        )
    );
  }
}