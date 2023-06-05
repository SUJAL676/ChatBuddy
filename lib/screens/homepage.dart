import 'package:chat_buddy/Widgets/home_drawer.dart';
import 'package:chat_buddy/Widgets/home_list_tile.dart';
import 'package:chat_buddy/Widgets/text_field.dart';
import 'package:chat_buddy/firebase/group_auth.dart';
import 'package:chat_buddy/screens/homepage.dart';
import 'package:chat_buddy/screens/login_screen.dart';
import 'package:chat_buddy/screens/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController create_controller=TextEditingController();
String username="";
String uid="";

class _HomePageState extends State<HomePage> {

  bool _loading = false;
  bool _Loading=false;

  @override

  Widget build(BuildContext context) {
    return _loading ? const Center(child: CircularProgressIndicator(),): Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Groups", style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 23),),
        actions: [
          Padding(padding: EdgeInsets.only(right: 10),
              child: InkWell(onTap :(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search_Screen(username: username, uid: uid,)) );
              },child: Icon(Icons.search)))
        ],
        backgroundColor: Colors.deepOrange,
      ),

      drawer: Home_Drawer(),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dialog(context);
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').doc(
            FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          else {

            username=snapshot.data["username"];
            uid=snapshot.data["uid"];

            if (snapshot.data['groups'].length != 0)
            {
              return ListView.builder(
                itemCount: snapshot.data["groups"].length,
                itemBuilder: (context,index)
                {
                  return Home_List_Title(group: snapshot.data["groups"][index], user_name: snapshot.data["username"], userId: uid , );
                },
              );
            }
            else {
              return NoWidget(context);
            }
          }
        },),


    );
  }


NoWidget(BuildContext context)
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25).copyWith(left: 30),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(child: Icon(Icons.add_circle , size: 100, ),
          onTap: (){
            dialog(context);
          } ,highlightColor: Colors.white,),
          SizedBox(height: 20,),
          Text("You've not joined any groups, tap on the add icon to create group"
              "or also search from top search button" ,
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize:14, color: Colors.black54 ),)
        ],
      ),
    ),
  );
}

dialog(BuildContext context)
{
  return showDialog(context: context, builder: (context)
  {
    return AlertDialog(
      title: Text("Create a group" , style: TextStyle(fontWeight: FontWeight.bold),),

      content: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepOrangeAccent,
            width: 2
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        child: TextField(
          controller: create_controller,
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10)
          ),
          maxLength: 25,
        ),
      ),


      actions: [
        ElevatedButton(onPressed: ()
        async {
          setState(() { _Loading=true;});

          String result = await Group_Auth().create_group(create_controller.text, uid, username);

          setState(() {_Loading=false;});
          if(result=="Sucess")
            {

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Group Created")));
              Navigator.of(context).pop();
              create_controller.clear();
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
            }

          },

          child:_Loading ?Center(child: CircularProgressIndicator(),) :Text("Create") ,
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),),

        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Cancel") ,
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)),)
      ],
    );
  });
}
}


