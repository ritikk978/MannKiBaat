import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mannkibaat/screens/loginpage.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book, size: 40,color: Colors.black,),
                Text('Me Time', style: TextStyle(fontSize: 24)),

                Text('GlooMe Se GleeMe', style: TextStyle(fontSize: 16)),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

    // Navigator.pushNamed(context, LoginPage.id);


  }
}
