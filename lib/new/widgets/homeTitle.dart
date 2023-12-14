import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homeTitle extends StatefulWidget {
  final Map map;
  const homeTitle({super.key, required this.map});

  @override
  State<homeTitle> createState() => _homeTitleState();
}

class _homeTitleState extends State<homeTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Container(
            padding: EdgeInsets.all(5),
              child: Image.network(widget.map["photoUrl"],)),
        ),
        title: Text(widget.map["name"],style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 20
        ),),
        subtitle: Text(widget.map["newmessage"],style: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          fontSize: 12,
          color: Color.fromRGBO(121, 124, 123, 1)
        ),),
      ),
    );
  }
}
