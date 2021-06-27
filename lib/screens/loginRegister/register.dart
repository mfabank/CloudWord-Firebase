import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();
  String username, email, password;
  bool isRegister = false;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("img/logo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isRegister)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (snapshotUsername) {
                      username = snapshotUsername;
                    },
                    validator: (snapshotUsername) {
                      return snapshotUsername.isEmpty
                          ? "Enter a username"
                          : null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      labelText: "Username  ",
                      labelStyle: new TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (snapshotEmail) {
                    email = snapshotEmail;
                  },
                  validator: (snapshotEmail) {
                    return snapshotEmail.contains("@")
                        ? null
                        : "Enter a E - Mail";
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    labelText: "E - Mail  ",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (snapshotPassword) {
                    password = snapshotPassword;
                  },
                  validator: (snapshotPassword) {
                    return snapshotPassword.length >= 6
                        ? null
                        : "Required 6 character";
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    labelText: "Password  ",
                    labelStyle: new TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isRegister = !isRegister;
                    });
                  },
                  child: isRegister
                      ? Text("I don't have an Account",style: TextStyle(color: Colors.white))
                      : Text("Are you already a member, SignIn",style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: isRegister
                        ? Text("Login")
                        : Text("Register"),
                    onPressed: () {
                      registerMethod();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent, shadowColor: Colors.black),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),);
  }

  void registerMethod() {
    if(_formKey.currentState.validate()) {
      testForm(username,email,password,isAdmin);
    }
  }

  void testForm(String username, String email, String password, bool isAdmin) async{
    final role = FirebaseAuth.instance;
    AuthResult roleResult;

    if(isRegister) {
      roleResult = await role.signInWithEmailAndPassword(email: email, password: password);
    }
    else {
      roleResult = await role.createUserWithEmailAndPassword(email: email, password: password);
      String getEmail = roleResult.user.email;
      await Firestore.instance.collection("users").document(getEmail).setData(
        {
          "username" : username, "email" : email, "password" : password, "isAdmin" : isAdmin
        }
      );
    }
  }


}
