import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusTile extends StatefulWidget {
  final Map map;
  final index;
  const StatusTile({super.key, required this.map, this.index});

  @override
  State<StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  @override
  Widget build(BuildContext context) {
    return widget.index ==0  ? mystatus() :
    Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.yellow,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(54, 58, 77, 1),
              backgroundImage: NetworkImage(widget.map["photoUrl"]),
              radius: 30,
            ),
          ),

          SizedBox(height: 8,),

          Text(widget.map["name"],style: GoogleFonts.lato(
            color: Colors.white
          ),)
        ],
      ),
    );

    // return Container(
    //   margin: EdgeInsets.all(10),
    //   width: 30,
    //   height: 30,
    //   decoration: BoxDecoration(
    //       color: Color.fromRGBO(54, 58, 77, 1),
    //     borderRadius: BorderRadius.all(Radius.circular(10000))
    //   ),
    // );
  }

  mystatus()
  {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(54, 58, 77, 1),
              backgroundImage: NetworkImage(widget.map["photoUrl"]),
              radius: 30,
            ),
          ),

          SizedBox(height: 8,),

          Text(widget.map["name"],style: GoogleFonts.lato(
              color: Colors.white
          ))
        ],
      ),
    );
  }
}
