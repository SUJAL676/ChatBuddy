import 'package:chat_buddy/Widgets/random_groups_title.dart';
import 'package:chat_buddy/firebase/group_auth.dart';
import 'package:chat_buddy/screens/group_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search_Screen extends StatefulWidget {
  final String username;
  final String uid;
  const Search_Screen({Key? key, required this.username, required this.uid}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}


class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController controller=TextEditingController();
  bool _isbool=false;
  bool _bool=false;

  @override
  void initState() {
    controller=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white)
          ),
          onSubmitted: (String _)
          {
            setState(() {
              _isbool=true;
            });
          },
        ),
      ),
      body:_isbool ?FutureBuilder(
        future: FirebaseFirestore.instance.collection("groups").where("group_name",isEqualTo: controller.text).get(),
        builder: (context,snapshot)
        {
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          else
          {
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context,index)
              {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Text((snapshot.data! as dynamic).docs[index]["group_name"][0],
                    ),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]["group_name"] ,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  subtitle: Text("Created by ${(snapshot.data! as dynamic).docs[index]["admin"].toString().substring((snapshot.data! as dynamic).docs[index]["admin"].toString().indexOf("_")+1)}"),


                  trailing: button(snapshot,index),


                );
              },
            );
          }
        },
      ) : random_group()
    );
  }

  button(snap,index)
  {
    if((snap.data! as dynamic).docs[index]["members"].contains("${widget.uid}_${widget.username}"))
      {
        return ElevatedButton(onPressed: (){},
        child: Text("Joined" , style: TextStyle(color: Colors.deepOrangeAccent),),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),

        ),);
      }
    else
      {
        return ElevatedButton(onPressed: () async {
          setState(() { _bool=true; });
          String result = await Group_Auth().add_to_group(groupid: (snap.data! as dynamic).docs[index]["group_id"],
              uid: widget.uid, username: widget.username,
              groupname: (snap.data! as dynamic).docs[index]["group_name"]);

          if(result=="Sucess")
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Joined")));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Group_chat(groupid: (snap.data! as dynamic).docs[index]["group_id"],
                  user: widget.username, userId: widget.uid)));

            }
          else
            {
              setState(() {_bool=false;});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Joined")));
            }
        },
        child:_bool ? CircularProgressIndicator() : Text("Tap to Join"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
        ),);
      }
  }

  random_group()
  {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("groups").snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot)
      {
        if(snapshot.hasData)
          {
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator(),);
              }
            else
              {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index)
                  {
                    return Random_Groups_Title(group_name: snapshot.data!.docs[index]["group_name"],
                      username: widget.username,
                      admin: snapshot.data!.docs[index]["admin"].toString().substring(snapshot.data!.docs[index]["admin"].toString().indexOf("_")+1),
                      uid: widget.uid, snap: snapshot, index: index,);
                  },
                );
              }
          }
        else
          {
            return Text("");
          }
      },
    );
  }
}