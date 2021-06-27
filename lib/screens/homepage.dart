import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudword/models/drawer.dart';
import 'package:cloudword/screens/addwords.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentUserEmail;
  Color specialColor = Color(0xFF233549);
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: specialColor,
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              }),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/wallpaper.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("users")
              .document(currentUserEmail)
              .collection("words")
              .snapshots(),
          builder: (context, getData) {
            if (getData.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SpinKitRipple(
                size: 100,
                color: Colors.deepPurpleAccent,
              ));
            } else {
              final getHasData = getData.data.documents;

              return ListView.builder(
                itemCount: getHasData.length,
                itemBuilder: (contex, index) {
                  return Card(
                    color: Colors.blueGrey,
                    child: ListTile(
                      title: Text(getHasData[index]["trWord"].toString()),
                      subtitle: Text(getHasData[index]["ingWord"].toString()),
                      trailing: InkWell(
                          onTap: () async {
                            await Firestore.instance
                                .collection("users")
                                .document(currentUserEmail)
                                .collection("words")
                                .document(
                                  getHasData[index]["ingWord"],
                                )
                                .delete();
                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: SpinKitRipple(
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddWords()));
        },
      ),
    );
  }

  void getCurrentUser() async {
    FirebaseAuth current = FirebaseAuth.instance;
    final FirebaseUser currentUser = await current.currentUser();
    setState(() {
      currentUserEmail = currentUser.email;
    });
  }
}
