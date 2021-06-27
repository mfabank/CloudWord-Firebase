import 'package:cloudword/screens/homepage.dart';
import 'package:cloudword/screens/loginRegister/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, usersData) {
        if(usersData.hasData){
          return HomePage();
        }
        else {
          return Register();
        }
      },
    ),
  ));
}

