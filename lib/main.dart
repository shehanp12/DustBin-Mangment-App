import 'package:dustbin_mangment/SplashScreen.dart';




import 'package:dustbin_mangment/screens/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,

            ),
            home: SplashScreen(),
          );
        }
        return HomeScreen();
      },
    );









  }
}

