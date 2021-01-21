import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/login_page.dart';
import 'package:flutter/cupertino.dart';

import '../homepage.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
          

        } else {
          return LoginPage();
        }
      },
    );
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign In (AuthCredential)
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  // If you are not using Google play Service
  signInWithOTP(smsCode, verId){
     AuthCredential authCreds = PhoneAuthProvider.credential(
       verificationId: verId, smsCode: smsCode);
       signIn(authCreds);
  }
}
