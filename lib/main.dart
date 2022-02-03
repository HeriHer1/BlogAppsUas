import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas_flutter/home_page.dart';
import 'package:uas_flutter/login.dart';
import 'package:uas_flutter/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      Login.tag: (context) => Login(),
      HomePage.tag: (context) => HomePage(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Flutter',
      home: SplashScreen(),
      routes: routes,
    );
  }
}
