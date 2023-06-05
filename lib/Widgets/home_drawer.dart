import 'package:chat_buddy/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_Drawer extends StatelessWidget {
  const Home_Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 82),
      child: Drawer(
        width: 240,
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Container(
                    height: 300,
                    child: Column(
                      children: [
                        Icon(Icons.account_circle , size: 130,),
                        SizedBox(height: 8,),
                        Text("Sujal" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )),


              SizedBox( height: 20,),
              ListTile(
                leading: Icon(Icons.group , color : Colors.deepOrangeAccent),
                title: Text("Groups"),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.account_circle , color: Colors.black87,),
                title: Text("Profile"),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.login_outlined , color: Colors.black, ),
                title: Text("Logout"),
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Login_Screen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
