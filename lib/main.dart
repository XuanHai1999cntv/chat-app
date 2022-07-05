import 'dart:io';

import 'package:demo/pages/home_page/home_screen.dart';
import 'package:demo/pages/login_page/login_screen.dart';
import 'package:demo/routes/app_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isIOS || Platform.isAndroid){

  await Firebase.initializeApp();
  }
  // else {
  // await Firebase.initializeApp(
  //   // Replace with actual values
  //   options: const FirebaseOptions(
  //       apiKey: "AIzaSyDU29LraNHxkzW-UcqqzM5PW6mBLZUetMc",
  //       authDomain: "demoapp-c13f1.firebaseapp.com",
  //       projectId: "demoapp-c13f1",
  //       storageBucket: "demoapp-c13f1.appspot.com",
  //       messagingSenderId: "538722951132",
  //       appId: "1:538722951132:web:1748bf3f28219710447919"
  //   ),
  // );
  //
  // }



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute:
          (_auth.currentUser != null) ? AppPage.currentLogin : AppPage.initial,
      getPages: AppPage.routes,
    );
  }
}
