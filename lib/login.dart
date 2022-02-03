import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_flutter/home_page.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  static String tag = 'login-page';
  static int statusLogin = 0;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('admin');

  Future<void> login([DocumentSnapshot? documentSnapshot]) async {
    final String? varuser = _username.text;
    final String? varpwd = _password.text;
    var result = await _newsCollection
        .where("user", isEqualTo: varuser)
        .where("pwd", isEqualTo: varpwd)
        .get();
    if (result.docs.length == 1) {
      Login.statusLogin = 1;
      Navigator.of(context).pushReplacementNamed(HomePage.tag);
    } else {
      var snackBar = const SnackBar(
        content: Text('Username atau Password Salah'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    Future(() {
      if (Login.statusLogin == 1) {
        Navigator.of(context).pushReplacementNamed(HomePage.tag);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(60)),
            color: new Color(0xFF4CAF50),
            gradient: LinearGradient(
              colors: [(new Color(0xFF4CAF50)), new Color(0xFF2E7D32)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "images/logo.png",
                  height: 100,
                ),
              ),
            ],
          )),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 70),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: _username,
            cursorColor: Color(0xFF4CAF50),
            decoration: InputDecoration(
              icon: Icon(
                Icons.account_circle,
                color: Color(0xFF4CAF50),
              ),
              hintText: "Masukkan Username",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: _password,
            obscureText: true,
            cursorColor: Color(0xFF4CAF50),
            decoration: InputDecoration(
              focusColor: Color(0xFF4CAF50),
              icon: Icon(
                Icons.vpn_key,
                color: Color(0xFF4CAF50),
              ),
              hintText: "Masukkan Password",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // Write Click Listener Code Here
            },
            child: Text("Lupa Password?"),
          ),
        ),
        GestureDetector(
          onTap: () {
            login();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 100),
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [(new Color(0xFF4CAF50)), new Color(0xFF2E7D32)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: Text(
              "MASUK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    )));
  }
}
