import 'package:flutter/material.dart';
import 'package:uas_flutter/about.dart';
import 'package:uas_flutter/login.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.person,
              text: 'My Profile',
              onTap: () => print('Tap My Files')),
          _drawerItem(
              icon: Icons.info,
              text: 'About Us',
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new About()));
              }),
          Divider(height: 25, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Other",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Login.statusLogin = 0;
              Navigator.of(context).pushReplacementNamed(Login.tag);
            },
          ),
        ],
      ),
    );
  }
}

Widget _drawerHeader() {
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(
      color: new Color(0xFF4CAF50),
      gradient: LinearGradient(
        colors: [(new Color(0xFF4CAF50)), new Color(0xFF2E7D32)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    currentAccountPicture: ClipOval(
      child: Image(image: AssetImage('images/logo.png'), fit: BoxFit.cover),
    ),
    accountName: Text('Kelompok 4'),
    accountEmail: Text('kelompok4@poltektedc.ac.id'),
  );
}

Widget _drawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
