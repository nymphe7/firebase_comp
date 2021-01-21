
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserManagement {

  storeNewUser(user,context){
    FirebaseFirestore.instance.collection('/user')
    .add({
      'email':user.email,
      'uid':user.uid
      
    })
    .then((value){
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/homepage');
    })
    .catchError((e)=> print(e));
  }
}