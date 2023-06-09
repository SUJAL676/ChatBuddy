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
      constraints: const BoxConstraints(
        minWidth: 60,
        maxWidth: 150,
        // minHeight: 60,
        // maxHeight: 100
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(right: 6,top: 6.5 ,left: 6),
      height: 50,
      decoration: BoxDecoration(
        color:isuser? Colors.deepOrangeAccent : Colors.redAccent,
        borderRadius:isuser ?BorderRadius.circular(10).copyWith(bottomRight: const Radius.circular(0)) :
        BorderRadius.circular(10).copyWith(bottomLeft: const Radius.circular(0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(username , style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
           ),

          // RichText(
          //     text: TextSpan(text: username,
          //                    style: TextStyle(color: Colors.white,
          //                                      decoration: TextDecoration.underline)),
          //
          //
          // ),

          const SizedBox(height: 2,),
          Text(chat , style: const TextStyle(
            color: Colors.white,
          ), textAlign:isuser? TextAlign.right : TextAlign.start
            ,),
        ],
      )
    );

  }
}
