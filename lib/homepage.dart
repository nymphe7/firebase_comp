import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout page'),
      ),
      body: Column(
        children: [
          Text('You are now logged in'),
          RaisedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacementNamed('/landingpage');
                }).catchError((e) {
                  print(e);
                });
              },
              color: Colors.green,
              child: Text('Logout')),
        ],
      ),
    );
  }
}
