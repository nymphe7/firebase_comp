import 'package:firebase_complete/homepage.dart';
import 'package:firebase_complete/login_page.dart';
import 'package:firebase_complete/services/auth.dart';
import 'package:firebase_complete/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     home: AuthService().handleAuth(),
     initialRoute: '/loginpage',
     routes: {
       '/loginpage':(context) => LoginPage(),
       '/landingpage':(context) => MyApp(),
       '/signup':(context) => SignupPage(),
       '/homepage' :(context) => HomePage(),
     },
    );
  }
}
