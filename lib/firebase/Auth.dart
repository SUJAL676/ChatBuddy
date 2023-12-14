import 'dart:typed_data';

import 'package:chat_buddy/screens/group_chat.dart';
import 'package:chat_buddy/utils/imageStorage.dart';
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
    required Uint8List profilePic,
    required List group
  })
  async{
    var result="Failed";
    // Map<String,dynamic> map=;
    try
    {
      UserCredential cred= await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);

      String downloadLink =await image_storage().upload_image("profilepics", profilePic);

      await _firebaseFirestore.collection('user').doc(cred.user!.uid).set(
          {
            'username':username,
            'email':email,
            'pass':pass,
            'profilepic':downloadLink,
            'groups':group,
            'uid':cred.user!.uid
          }
      );

      await _firebaseFirestore.collection('chats').doc(cred.user!.uid).set({
        "chatlist" : [{
          "name" : "Chatbuddy",
          "uid" : 0,
          "newmessage" : "Say Hello",
          "photoUrl": "https://firebasestorage.googleapis.com/v0/b/chatbuddy-6519e.appspot.com/o/bot%2Fbot.png?alt=media&token=fd8e243f-4454-4ed6-a91c-d67df788659e"
        },],
        "username" : username,
        "userUid" : cred.user!.uid
      });

      await _firebaseFirestore.collection('status').doc(cred.user!.uid).set(
        {
          "statusList" : [
            {
              "name": username,
              "uid" : cred.user!.uid,
              "photoUrl": downloadLink
            },
            {
            "name" : "Chatbuddy",
            "uid" : 0,
            "photoUrl" : "https://firebasestorage.googleapis.com/v0/b/chatbuddy-6519e.appspot.com/o/bot%2Fbot.png?alt=media&token=fd8e243f-4454-4ed6-a91c-d67df788659e"
          }],
          "username" : username,
          "userUid" : cred.user!.uid
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

  Future<String> addUser
      (
         {
            required String uid,
            required Map chatMap,
            required Map statusMap,
            required String useruid,
         }
      )
  async{
    var result="Failed";
    try{
      await _firebaseFirestore.collection("chats").doc(uid).update({
        "chatlist" : FieldValue.arrayUnion([chatMap])
      });
      await _firebaseFirestore.collection("status").doc(uid).update({
        "statusList" : FieldValue.arrayUnion([statusMap])
      });

      await _firebaseFirestore.collection("chats").doc(useruid).update({
        "chatlist" : FieldValue.arrayUnion([chatMap])
      });
      await _firebaseFirestore.collection("status").doc(useruid).update({
        "statusList" : FieldValue.arrayUnion([statusMap])
      });


      result="Sucess";
    }
    catch(e)
    {
      result=e.toString();
    }
    return result;
  }
}