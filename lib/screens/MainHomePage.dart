import 'dart:convert';

import 'package:chat_buddy/firebase/group_auth.dart';
import 'package:chat_buddy/new/add_person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  // @override
  // void initState() {
  //   Group_Auth().bot_message();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("asset/background.png"),
          SafeArea(
            child: Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 60,
                    child: appbar(),
                  ),
                  status(),
                  chat(context)
                ],
              ),
            ),
          )
        ],
      ),

    );

  }

  appbar()
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(child: CircleAvatar(
          backgroundColor: Color.fromRGBO(54, 58, 77, 1),
          radius: 22,
          child: Center(child: Image.asset("asset/search.png"),),
        ),),
        Center(child: Text("HOME" , style: GoogleFonts.poppins(
            color: Colors.white,fontSize: 22,fontWeight: FontWeight.w400
        ),)),
        InkWell(
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Add_Person())),
          child: Center(child: CircleAvatar(backgroundColor: Color.fromRGBO(54, 58, 77, 1),
            radius: 22,
            child: Center(child: SvgPicture.asset("asset/add.svg")),
          )),
        )
      ],
    );
  }

  status()
  {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 100,
      // color: Colors.white,
    );
  }

  chat(BuildContext context)
  {
    return Expanded(child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> snapshot)
        {
          if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
          else{
            // print(snapshot.data.docs());
            print(snapshot.data!["username"]);
            return ListView.builder(
              itemCount: snapshot.data!["chatlist"].length,
              itemBuilder: (context,index)
              {
                return Text("");
              },
            );
          }
        },
        ),
      ),
    );
  }

}
