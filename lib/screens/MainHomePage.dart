import 'package:chat_buddy/firebase/group_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  @override
  void initState() {
    Group_Auth().bot_message();
    super.initState();
  }

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
                  chat()
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
        Center(child: CircleAvatar(backgroundColor: Color.fromRGBO(54, 58, 77, 1),
          radius: 22,
          child: Image.asset("asset/avatar.png",),))
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

  chat()
  {
    return Expanded(child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
    ));
  }

}
