import 'package:chat_buddy/firebase/group_auth.dart';
import 'package:chat_buddy/screens/group_chat.dart';
import 'package:flutter/material.dart';


class Random_Groups_Title extends StatefulWidget {
  final String group_name;
  final String username;
  final String admin;
  final String uid;
  final snap;
  final index;
  const Random_Groups_Title({Key? key, required this.group_name, required this.username, required this.admin, required this.uid, required this.snap, required this.index}) : super(key: key);

  @override
  State<Random_Groups_Title> createState() => _Random_Groups_TitleState();
}

bool _bool=false;
var button_index;



class _Random_Groups_TitleState extends State<Random_Groups_Title> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.deepOrangeAccent,
          width: 2
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepOrangeAccent,
            radius: 40,
            child: Text(widget.group_name[0]),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.group_name , style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                SizedBox(
                  height: 5,
                ),
                Text("Created by ${widget.admin}"),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: button(widget.snap, widget.index),
            ),
          )
        ],
      ),
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
        setState(() { _bool=true;
          button_index=index;
        });
        String result = await Group_Auth().add_to_group(groupid: (snap.data! as dynamic).docs[index]["group_id"],
            uid: widget.uid, username: widget.username,
            groupname: (snap.data! as dynamic).docs[index]["group_name"]);

        if(result=="Sucess")
        {
          setState(() {_bool=false;});
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
        child:_bool && button_index==index ? CircularProgressIndicator() : Text("Tap to Join"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
        ),);
    }
  }
}
