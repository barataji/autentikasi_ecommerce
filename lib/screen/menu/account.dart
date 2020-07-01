import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend_commerce/custom/prefProfile.dart';
import 'package:frontend_commerce/screen/login.dart';

import 'package:frontend_commerce/screen/menu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool login = false;
  String namaLengkap, email, phone, id;

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      login = pref.getBool(Pref.login) ?? false;
      namaLengkap = pref.getString(Pref.namaLengkap) ?? false;
      email = pref.getString(Pref.email) ?? false;
      phone = pref.getString(Pref.phone) ?? false;
      id = pref.getString(Pref.id) ?? false;
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
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text("$namaLengkap"),
                    accountEmail: new Text("$email"),
                    currentAccountPicture: new GestureDetector(
                      onTap: () {},
                      child: new CircleAvatar(
                        backgroundImage: new NetworkImage(
                            'https://mahasiswa.undiksha.ac.id/data/foto/c38d1df4090fe0c1b7c82e024a4d6e7720180826030824.jpg'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/wallpaper.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  new ListTile(
                    title: new Text('Notifications'),
                    trailing: new Icon(Icons.notifications_none),
                  ),
                  new ListTile(
                    title: new Text('setting'),
                    trailing: new Icon(Icons.settings),
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.all(16),
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
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
