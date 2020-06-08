import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend_commerce/custom/prefProfile.dart';

import 'package:frontend_commerce/screen/menu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool login = false;

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      login = pref.getBool(Pref.login) ?? false;
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(Pref.namaLengkap);
    pref.remove(Pref.id);
    pref.remove(Pref.login);
    pref.remove(Pref.level);
    pref.remove(Pref.createdDate);
    pref.remove(Pref.kode);
    _auth.signOut();
    googleSignIn.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Menu()));
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("User Account"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          login
              ? IconButton(
                  icon: Icon(Icons.lock_open),
                  onPressed: signOut,
                )
              : SizedBox()
        ],
      ),
      body: login
          ? Container(
              child: Center(
                child: Text("Account"),
              ),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Login Your Account",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
    );
  }
}
