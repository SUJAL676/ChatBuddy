import 'package:flutter/material.dart';

class Group_Chat_Bubble extends StatelessWidget
{
  final String chat;
  final bool isuser;
  final String username;
  const Group_Chat_Bubble({Key? key, required this.chat, required this.isuser, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(right: 6,top: 6.5 ,left: 6),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Text(username , style: TextStyle(
          //   color: Colors.white,
          //
          //
          // ),
          //   textAlign:isuser? TextAlign.left : TextAlign.start,),

          RichText(
              text: TextSpan(text: username,
                             style: TextStyle(color: Colors.white,
                                               decoration: TextDecoration.underline)),


          ),

          SizedBox(height: 2,),
          Text(chat , style: TextStyle(
            color: Colors.white,
          ), textAlign:isuser? TextAlign.right : TextAlign.start
            ,),
        ],
      )
    );

  }
}
