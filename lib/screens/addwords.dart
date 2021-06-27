import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudword/models/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddWords extends StatefulWidget {
  @override
  _AddWordsState createState() => _AddWordsState();
}

class _AddWordsState extends State<AddWords> {
  Color specialColor = Color(0xFF233549);
  var getTrWord = TextEditingController();
  var getIngWord = TextEditingController();
  var getExampleSentence = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        actions: [IconButton(
          icon: Icon(Icons.backspace_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        )],
        backgroundColor: specialColor,
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: getTrWord,
                decoration: InputDecoration(
                  labelText: "TR Word",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: getIngWord,
                decoration: InputDecoration(
                  labelText: "ING Word",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: getExampleSentence,
                decoration: InputDecoration(
                  labelText: "Example Sentence",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Save"),
                onPressed: () {
                  saveWord();
                },
                style: ElevatedButton.styleFrom(
                  primary: specialColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveWord() async {
    FirebaseAuth role = FirebaseAuth.instance;
    final FirebaseUser currentUser = await role.currentUser();

    String getEmail = currentUser.email;
    String getKelimeAd = getIngWord.text;
    await Firestore.instance
        .collection("users")
        .document(getEmail)
        .collection("words")
        .document(getKelimeAd)
        .setData({
      "trWord": getTrWord.text,
      "ingWord": getIngWord.text,
      "exampleSentence": getExampleSentence.text
    });
    Fluttertoast.showToast(msg: "The Word was add succesfully.");
    Navigator.pop(context);
  }
}
