import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth
{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  Future<String> signUp(
  {
    required String email,
    required String pass,
    required String username,
    required String profilePic,
    required List group
  })
  async{
    var result="Failed";
    try
    {
      UserCredential cred= await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);

      await _firebaseFirestore.collection('user').doc(cred.user!.uid).set(
          {
            'username':username,
            'email':email,
            'pass':pass,
            'profilepic':profilePic,
            'groups':group,
            'uid':cred.user!.uid
          }
      );
      result="Sucess";
    }
    catch(e)
    {
      result=e.toString();
    }
  return result;
  }



  Future<String> login
  (
    {
       required String email,
       required String pass
    })
  async {
    var result="Failed";
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      result="Sucess";
    }
    catch(e)
    {
      result=e.toString();
    }
    return result;
  }
}