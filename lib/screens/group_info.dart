import 'package:chat_buddy/Widgets/group_info_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupIfo extends StatefulWidget {
  final String groupId;
  const GroupIfo({Key? key, required this.groupId}) : super(key: key);

  @override
  State<GroupIfo> createState() => _GroupIfoState();
}

class _GroupIfoState extends State<GroupIfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: Text(""),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("groups").doc(widget.groupId).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot)
        {
          if(snapshot.hasData)
            {
              if(snapshot.connectionState==ConnectionState.waiting)
              {
                return CircularProgressIndicator();
              }
              else
                {
                  return ListView.builder(
                    itemCount: snapshot.data["members"].length,
                    itemBuilder: (context,index)
                    {
                      return Group_Ifo_Tile();
                    },
                  );
                }
            }
          else
            {
              return Text("");
            }

        },
      ),

    );
  }
}
