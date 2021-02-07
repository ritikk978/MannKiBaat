import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mannkibaat/screens/listingPage.dart';

class NearestPlace extends StatefulWidget {
  static const String id = 'nearestplace';
  final String nameOfActivity;

  const NearestPlace({Key key, this.nameOfActivity}) : super(key: key);
  @override
  _NearestPlaceState createState() => _NearestPlaceState();
}

class _NearestPlaceState extends State<NearestPlace> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.9716, 77.5946),
    zoom: 12.9716,
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 812), allowFontScaling: false);

    var useArray = [];
    var bar = [
      {"Name" : "English Cafe", "Distance": "1.5 Km Away"},
      {"Name" : "Delux Cafe", "Distance": "3 Km Away"},
      {"Name" : "Super Cafe", "Distance": "4.5 Km Away"},
    ];
    var theatres = [
      {"Name" : "Indox", "Distance": "1.5 Km Away"},
      {"Name" : "Cinepolis", "Distance": "3 Km Away"},
      {"Name" : "PVR", "Distance": "4.5 Km Away"},
    ];
    var wifihub = [
      {"Name" : "Deluxe Wifi Hub", "Distance": "1.5 Km Away"},
      {"Name" : "Kundun Wifi Hub", "Distance": "3 Km Away"},
      {"Name" : "Ramesh Wifi Hub", "Distance": "4.5 Km Away"},
    ];
    var yogaCenters = [
      {"Name" : "Mitali Yoga", "Distance": "1.5 Km Away"},
      {"Name" : "Surya Fitness", "Distance": "3 Km Away"},
      {"Name" : "Rohan Yoga Classes", "Distance": "4.5 Km Away"},
    ];
    var cricketClub = [
      {"Name" : "Rohan Academy", "Distance": "1.5 Km Away"},
      {"Name" : "Rahul Academy", "Distance": "3 Km Away"},
      {"Name" : "Satwik Sport's Academy", "Distance": "4.5 Km Away"},
    ];
    var gym = [
      {"Name" : "O3 Gym", "Distance": "1.5 Km Away"},
      {"Name" : "Raju Gym", "Distance": "3 Km Away"},
      {"Name" : "Super Body", "Distance": "4.5 Km Away"},
    ];
    var library = [
      {"Name" : "National Library", "Distance": "1.5 Km Away"},
      {"Name" : "Shyam Library", "Distance": "3 Km Away"},
      {"Name" : "Gupta Library", "Distance": "4.5 Km Away"},
    ];
    var mentalhealth = [
      {"Name" : "Avinash Pharmacy", "Distance": "1.5 Km Away"},
      {"Name" : "Raju Clinic", "Distance": "3 Km Away"},
      {"Name" : "Gk Clinic", "Distance": "4.5 Km Away"},
    ];
    if(widget.nameOfActivity == 'WifiHub'){
      useArray = wifihub;
    } else if(widget.nameOfActivity == 'Theatres'){
      useArray = theatres;
    }
    else if(widget.nameOfActivity == 'Yoga Centers'){
      useArray = yogaCenters;
    }else if(widget.nameOfActivity == 'Sports Club'){
      useArray = cricketClub;
    }else if(widget.nameOfActivity == 'Bars'){
      useArray = bar;
    }else if(widget.nameOfActivity == 'Gym'){
      useArray = gym;
    }else if(widget.nameOfActivity == 'Library'){
      useArray = library;
    }else if(widget.nameOfActivity == 'Mental Health Checkup'){
      useArray = mentalhealth;
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, ListingPage.id, (route) => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
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
                  height: 260.h,
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
                      SizedBox(height: 5.h,),
                      Text("${widget.nameOfActivity}", style: TextStyle(color: Colors.orange, fontSize: 20, ),),

                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: 3,
                        itemBuilder: (context, int index) {


                          return Container(

                              child: ListTile(
                                title: Text(
                                  "${index+1}. ${useArray[index]["Name"]}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                trailing: Text(
                                    useArray[index]["Distance"], style: TextStyle(color: Colors.blue),

                                ),
                              ));
                        },
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
