import 'package:chat_buddy/screens/group_chat.dart';
import 'package:flutter/material.dart';

class Home_List_Title extends StatelessWidget {
  final String group;
  final String user_name;
  final String userId;
  const Home_List_Title({Key? key, required this.group, required this.user_name, required this.userId}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    String group_id= group.substring(0,group.indexOf("_"));
    String group_name=group.substring(group.indexOf("_")+1);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: GestureDetector(
        onTap: ()
          {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Group_chat(groupid: group_id, user: user_name, userId: userId,)) );
          },
        child: ListTile(
          leading: CircleAvatar(backgroundColor: Colors.deepOrangeAccent,
          radius: 25,
          child: Text(group_name[0]),),

          title: Text(group_name ,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

          subtitle: Text("Join the conversion as ${user_name}"),
        ),
      ),
    );
  }
}
