import 'package:charts_flutter/flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mannkibaat/screens/diarypage.dart';
import 'dart:io';
import 'package:mannkibaat/screens/homepage.dart';
import 'package:mannkibaat/screens/listingPage.dart';
import 'package:mannkibaat/screens/loginpage.dart';
import 'package:mannkibaat/screens/nearestplace.dart';
import 'package:mannkibaat/screens/recommendation.dart';
import 'package:mannkibaat/screens/registerationpage.dart';
import 'package:mannkibaat/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.get('email');
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: '1:827518037455:android:6837ea740a94e7933736ba',
      apiKey: 'AIzaSyAT-V_Kff36noOYz4LQt12sCMivcf444QA',
      projectId: 'mannkibaat-1f1ef',
      messagingSenderId: '266062607428',
      databaseURL: 'https://mannkibaat-1f1ef-default-rtdb.firebaseio.com/',
    )
        : FirebaseOptions(
      appId: '1:827518037455:android:6837ea740a94e7933736ba',
      apiKey: 'AIzaSyAT-V_Kff36noOYz4LQt12sCMivcf444QA',
      messagingSenderId: '266062607428',
      projectId: 'mannkibaat-1f1ef',
      databaseURL: 'https://mannkibaat-1f1ef-default-rtdb.firebaseio.com/',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MannKiBaat',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      initialRoute: Splash.id,
      routes: {
        RegisterationPage.id: (context) => RegisterationPage(),
        LoginPage.id: (context) => LoginPage(),
        ListingPage.id: (context) => ListingPage(),
        NearestPlace.id: (context) => NearestPlace(),
        DiaryPage.id: (context) => DiaryPage(),
        RecommendationPage.id: (context) => RecommendationPage(),
        Splash.id : (context)=>Splash(),
      },
    );
  }
}


