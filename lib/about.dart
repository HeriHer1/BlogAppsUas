import 'package:flutter/material.dart';
import 'package:uas_flutter/main.dart';
import 'package:uas_flutter/home_page.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Text("About Us"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  (new Color(0xFF4CAF50)),
                  (new Color(0xFF2E7D32)),
                ])),
          )),
      body: Center(
        child: Text(
          'Kelompok 4 : Ilham, Sava, Deden, Ahyar, Heri, Dio, Sopian',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
