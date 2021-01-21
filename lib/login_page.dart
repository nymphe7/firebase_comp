import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final formKey = GlobalKey < FormState>();
  String _email;
  String _password;

  // // phone authentication
  // String phoneNo;
  // String verificationId;

  // Future<void> verifyPhone(phoneNo) async {

  //   final PhoneVerificationCompleted verified = (AuthCredential authResult){
  //     // To Do
  //     AuthService().signIn(authResult);
  //   };

  //   final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException){
  //     print('{authException.message}');
  //   };

  //   final PhoneCodeSent smsSent = (String verId,[int forceResend]){
  //       verificationId = verId;
  //   };

  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
  //     verificationId = verId;
  //   };

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNo,
  //     timeout: Duration(seconds:5),
  //     verificationCompleted: verified,
  //     verificationFailed: verificationFailed,
  //     codeSent: smsSent,
  //     codeAutoRetrievalTimeout: autoTimeout);
  // }

  //google sign in
  GoogleSignIn googleAuth = GoogleSignIn();

  //Facebook signin
  FacebookLogin fblogin = FacebookLogin();

  // FirebaseAuth _auth = FirebaseAuth.instance;

  // void _signInFacebook() async{
  //   FacebookLogin fblogin = FacebookLogin();

  //   final result = await fblogin.logIn(['email']);
  //   final token = result.accessToken.token;
  //   final graphResponse = await http.get(
  //               'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  //   // final profile = JSON.decode(graphResponse.body);
  //   print(graphResponse.body);
  //   if(result.status == FacebookLoginStatus.loggedIn){
  //     _auth.signInWithCredential(
  //       FacebookAuthProvider.credential(token),
  //     );
  //   }

  // }

  // anonymous login : Anonymous authentication is like allowing the
  //user without any credentials i.e without any email or password but login with simply tap a button
  // Anonymous authentication are use usually when u want to some demo of your tutorial but not a complete tutorial
  Future<void> anomLogin() async{
    await FirebaseAuth.instance.signInAnonymously().then((user){
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e)=> print(e));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Email or phone'),
                  onChanged: (val) {
                    setState(() => _email = val);
                  },
                ),
                SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (val) {
                    setState(() => _password = val);
                  },
                ),
                SizedBox(height: 15),
                RaisedButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((auth) {})
                          .then((User user) {
                        Navigator.of(context).pushReplacementNamed('/homepage');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    color: Colors.green,
                    child: Text('Login')),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: RaisedButton(
                    onPressed: () {
                      googleAuth.signIn().then((result) {
                        result.authentication.then((googleKey) {
                          FirebaseAuth.instance
                              .signInWithCredential(
                                  GoogleAuthProvider.credential(
                                      idToken: googleKey.idToken,
                                      accessToken: googleKey.accessToken))
                              .then((signedInUser) {
                            print(
                                'Signed in as ${signedInUser.user.displayName}');
                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
                          }).catchError((e) => print(e));
                        }).catchError((e) {
                          print(e);
                        });
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    color: Colors.indigo,
                    child: Text(
                      'sign in with google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    fblogin.logIn(['email', 'public_profile']).then((result) {
                      switch (result.status) {
                        case FacebookLoginStatus.loggedIn:
                          FirebaseAuth.instance
                              .signInWithCredential(
                                  FacebookAuthProvider.credential(
                                      result.accessToken.token))
                              .then((signedInUser) {
                            print(
                                'Signed in as ${signedInUser.user.displayName}');
                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
                          }).catchError((e) => print(e));
                      }
                    }).catchError((e) => print(e));

                    // _signInFacebook();
                  },
                  color: Colors.green,
                  child: Text('Login with Facebook'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PhoneAuth();
                      }));
                    },
                    color: Colors.cyan,
                    child: Text('Sign in using phone no.')),
                SizedBox(height: 15),

                RaisedButton(onPressed: (){
                  // FirebaseAuth.instance.signInAnonymously()
                  // .then((user){
                  //   Navigator.of(context).pushReplacementNamed('/homepage');

                  // }).catchError((e)=> print(e));
                  anomLogin();
                },
                color: Colors.green,
                child:Text('Sign in with anonymous user')
                ),

                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Don\'t have an account? Sign up here!',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
