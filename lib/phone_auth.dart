import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/services/auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final formKey = GlobalKey<FormState>();

  String phoneNo;
  String verificationId, smsCode;
  bool codeSent = false; // If you are not using Google play Service

  Future<void> verifyPhone(phoneNo) async{

    final PhoneVerificationCompleted verified = (AuthCredential authResult){
        //To Do
        AuthService().signIn(authResult);

    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException){
        print('{authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]){
        verificationId = verId;
        setState(() { // If you are not using Google play Service
          codeSent = true;
        });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
        verificationId = verId;
    };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo, 
        timeout: Duration(seconds: 50),
        verificationCompleted: verified,
        verificationFailed: verificationFailed, 
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Form(
              key: formKey, 
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration:InputDecoration(
                  hintText: 'Enter phone number'
                ),
                onChanged: (val){
                  setState(() {
                    phoneNo = val ;
                  });
                },
              ),
              
              ),
              SizedBox(height: 15,),

              // If the code is send    // If you are not using Google play Service
              codeSent ? TextFormField( 
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText:'Enter OTP Code'
                ),
                onChanged: (val){
                  setState((){
                    smsCode = val ;
                  });
                },
              ) : Container(),

              SizedBox(height: 20,),
              RaisedButton(onPressed: (){ // If you are not using Google play Service
                codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
              },
              color:Colors.cyan,
              child: Center(
                child: codeSent ? Text('Log in'):Text('Verify',
                style:TextStyle(fontSize:20,
                fontWeight:FontWeight.w600)),
              )),

              
          ],),
        )
      ),
      
    );
  }
}