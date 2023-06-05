import 'package:chat_buddy/Widgets/group_chat_title.dart';
import 'package:chat_buddy/firebase/group_auth.dart';
import 'package:chat_buddy/screens/group_info.dart';
import 'package:chat_buddy/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Group_chat extends StatefulWidget {
  final String groupid;
  final String user;
  final String userId;
  const Group_chat({Key? key, required this.groupid, required this.user, required this.userId}) : super(key: key);

  @override
  State<Group_chat> createState() => _Group_chatState();
}

TextEditingController message_sender=TextEditingController();
final _uid=FirebaseAuth.instance.currentUser!.uid;

class _Group_chatState extends State<Group_chat> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: const Text("CHATS" , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GroupIfo())) ;
          }, icon: const Icon(Icons.info_outline))
        ],
      ),

      body: Stack(
        children: [
          Container(
            child: chats(widget.groupid),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5,left: 3),
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                            color: Colors.deepOrangeAccent,
                          width: 2
                        ),

                      ),
                      child: TextField(
                        controller: message_sender,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15 ,right: 15 ,bottom: 4),
                          border: InputBorder.none,
                        ),
                      )
                    ),
                  ),

                  FloatingActionButton(onPressed: () async {
                    String result=await Group_Auth().chat_send(groupId: widget.groupid, message: message_sender.text, sender: widget.user, SenderId: widget.userId);
                    if(result!="Sucess")
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                      }
                    message_sender.clear();
                    },
                  backgroundColor: Colors.deepOrangeAccent,
                  child: const Icon(Icons.send),)
                ],
              ),
            ),
          )

        ],
      ),



    );

  }
}

chats(
    String groupId
    )
{
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("groups").doc(groupId).collection("messages").orderBy("time").snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot)
    {
      if(snapshot.hasData)
        {
          if (snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          else
            {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index)
                {

                  if(snapshot.data!.docs[index]["sender_id"]==_uid)
                    {
                      return Align(
                        alignment: Alignment.centerRight,
                          child: Group_Chat_Bubble(chat: snapshot.data!.docs[index]["message"], isuser: true, username: snapshot.data!.docs[index]["sender"], ));
                    }
                  else
                    {
                      return Align(
                          alignment: Alignment.centerLeft,
                          child: Group_Chat_Bubble(chat: snapshot.data!.docs[index]["message"], isuser: false,username: snapshot.data!.docs[index]["sender"]));
                    }
                },

              );
            }
        }
      else
        {
          return Center(child: Text(""),);
        }
    },
  );
}
