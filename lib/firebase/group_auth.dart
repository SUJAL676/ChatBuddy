import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Group_Auth
{
  final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  Future<String> create_group(String groupname , String uid , String name)
  async{
    String result="Error";
    try{
      DocumentReference documentReference =await firebaseFirestore.collection('groups').add({
        "group_name": groupname,
        "group_icon":"",
        "admin":"${uid}_${name}",
        "members":[],
        "group_id":"",
        "recent_message":"",
        "recent_message_sender":""
      });

      await documentReference.update({
        "members":FieldValue.arrayUnion(["${uid}_${name}"]),
        "group_id":documentReference.id
      });

      await firebaseFirestore.collection("user").doc(uid).update({
        "groups":FieldValue.arrayUnion(["${documentReference.id}_${groupname}"])
      });

      result="Sucess";
    }

    catch(e)
    {
      result=e.toString();
    }

    return result;

  }

  Future<String> bot_message()
  async{
    try{

      await firebaseFirestore.collection("chats").doc(firebaseAuth.currentUser!.uid).set(
        {
          "usename" : "Sujal",
          "chatList" : [0],
        }
      );
      return "Sucess";
    }
    catch(err)
    {
      return "Error";
    }


  }

  Future<String> chat_send({
      required String groupId,
      required String message,
      required String sender,
      required String SenderId,}
      )
  async{
    String result="Error";

    try
    {
      DocumentReference documentReference=await firebaseFirestore.collection("groups").doc(groupId).collection("messages").add({
        "message":message,
        "sender":sender,
        "sender_id":SenderId,
        "time":DateTime.now(),
        "message_id":""
      });

      await documentReference.update({
        "message_id":documentReference.id
      });

      await firebaseFirestore.collection("groups").doc(groupId).update({
        "recent_message":message,
        "recent_message_sender":sender
      });

      result="Sucess";
    }

    catch(e)
    {
      result=e.toString();
    }


    return result;
  }

  Future<String> add_to_group({
    required String groupid,
    required String uid,
    required String username,
    required String groupname
  })
  async {
    String result="Error";
     try
     {
       await firebaseFirestore.collection("groups").doc(groupid).update({
         "members":FieldValue.arrayUnion(["${uid}_${username}"])
       });

       await firebaseFirestore.collection("user").doc(uid).update({
         "groups":FieldValue.arrayUnion(["${groupid}_${groupname}"])
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