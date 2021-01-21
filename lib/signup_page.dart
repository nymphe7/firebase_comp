import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/services/usermanagement.dart';
import 'package:flutter/material.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:40,horizontal:20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
              onChanged: (val){
                setState(()=> _email = val);
              },
            ),
            SizedBox(height:20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
              onChanged: (val){
                setState(() => _password= val);
              },
            ),
            SizedBox(height:40),
              RaisedButton(onPressed: (){
              FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _email, password: _password)
                .then((signedInUser){
                  UserManagement().storeNewUser(signedInUser.user, context);
                })
                .catchError((e)=> print(e));              },
              color:Colors.green,
              child:Text('Sign up')),
            ],
          ),
      ),
     
      
    );
  }
}