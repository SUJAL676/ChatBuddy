import 'package:chat_buddy/firebase/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTile extends StatefulWidget {
  final String profilepic;
  final String username;
  final String bio;
  final String uid;
  const SearchTile({super.key, required this.profilepic, required this.username, required this.bio, required this.uid});

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {

  String our_uid = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    Map our_chatMap={
      "name": widget.username,
      "newmessage" : "Say Hello",
      "photoUrl": widget.profilepic,
      "uid": widget.uid
    };

    Map our_statusMap={
      "name": widget.username,
      "photoUrl": widget.profilepic,
      "uid": widget.uid
    };

    Map user_chatMap={
      "name": widget.username,
      "newmessage" : "Say Hello",
      "photoUrl": widget.profilepic,
      "uid": our_uid
    };

    Map user_statusMap={
      "name": widget.username,
      "photoUrl": widget.profilepic,
      "uid": our_uid
    };



    return SizedBox(
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(widget.profilepic),
          // child: Container(
          //     padding: EdgeInsets.all(5),
          //     child: Image.network(widget.profilepic,fit: BoxFit.fill,)),
        ),
        title: Text(widget.username,style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20
        ),),
        subtitle: Text(widget.bio,style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Color.fromRGBO(121, 124, 123, 1)
        ),),
       trailing: GestureDetector(
         onTap: () async{
           String a = await Auth().addUser(uid: our_uid, chatMap: our_chatMap, statusMap: our_statusMap, useruid: widget.uid,);
           if(a=="Sucess")
             {
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a)));
             }
           else
             {
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a)));
             }
         },
         child: Container(
           width: 50,
           height: 38,
           decoration: BoxDecoration(
               color: Color.fromARGB(50,140, 148, 148),
             borderRadius: BorderRadius.all(Radius.circular(13))
           ),
           child: Center(child: SvgPicture.asset("asset/add.svg",color: Colors.black,),),
         ),
       ),
      ),
    );
  }
}
