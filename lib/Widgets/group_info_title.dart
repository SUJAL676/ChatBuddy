import 'package:flutter/material.dart';

class Group_Ifo_Tile extends StatelessWidget {
  const Group_Ifo_Tile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.deepOrange,
          width: 2
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.deepOrangeAccent,
          )
        ],
      ),
    );
  }
}
