import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mannkibaat/screens/listingPage.dart';

class NearestPlace extends StatefulWidget {
  static const String id = 'nearestplace';
  @override
  _NearestPlaceState createState() => _NearestPlaceState();
}

class _NearestPlaceState extends State<NearestPlace> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, ListingPage.id, (route) => false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
                mapController = controller;
              },
            ),
            
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      )
                    )
                  ],

                ),
                child: Column(
                  children: [
                    SizedBox(height: 5,),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
