import 'package:chatting_app/screens/auth_screen.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:chatting_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(builder: (ctx, userSnapShot){
        if(userSnapShot.connectionState == ConnectionState.waiting){
          return SplashScreen();
        }
        if(userSnapShot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      }, stream: FirebaseAuth.instance.onAuthStateChanged,),
    );
  }
}
