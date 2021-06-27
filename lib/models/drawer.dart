import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Color specialColor = Color(0xFF233549);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: specialColor),
            accountName: Text("Muhammed Fatih AKTAŞ"),
            accountEmail: Text("Muhammed Fatih AKTAŞ"),
            currentAccountPicture: Image.network(
                "https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_960_720.png"),
          ),
          Expanded(
              child: Container(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Ana Sayfa"),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profil"),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Çıkış"),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
