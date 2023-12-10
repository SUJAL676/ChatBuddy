import 'package:chat_buddy/Widgets/text_field.dart';
import 'package:chat_buddy/firebase/Auth.dart';
import 'package:chat_buddy/screens/homepage.dart';
import 'package:chat_buddy/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:chat_buddy/Widgets/colors.dart';
import 'package:chat_buddy/Widgets/text_field.dart';

import 'MainHomePage.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController email_controller=TextEditingController();
  TextEditingController pass_controller=TextEditingController();
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 70,right: 20,left: 20),
          child: Center(
            child: Column(
              children: [
                const Text("Chat Buddy",style: TextStyle(fontWeight: FontWeight.bold,
                                                    fontSize: 40),),
                const SizedBox(height: 10,),
                const Text("Login now to see what they are talking about!",
                  style: TextStyle(fontWeight: FontWeight.bold,
                                   fontSize:14, color: Colors.black54 ),),

                const SizedBox(height: 70,),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset("asset/login.jpg")
                ),
                const SizedBox(height: 60,),

                // TextField(
                //   decoration: InputDecoration(
                //     hintText: "Email",
                //     hintStyle: TextStyle(color: primary)
                //   ),
                // )

                Text_Field_Icon(hint_text: 'Email', icon: Icon(Icons.email), controller: email_controller,),

                Text_Field_Icon(hint_text: 'Password', icon: Icon(Icons.lock), controller: pass_controller,),

                ElevatedButton(onPressed: () async {

                  setState(() { _isloading=true;});
                  String a=await Auth().login(email: email_controller.text, pass: pass_controller.text);
                  setState(() { _isloading=false;});

                  if(a=="Sucess")
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainHomePage()));
                  }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a)));
                    }

                },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(100, 30)),
                      backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                    ),
                    child:_isloading ? CircularProgressIndicator(
                      strokeWidth: 2,
                    )
                        :Text("Sign In" ,  style: TextStyle(
                      fontSize: 17
                    ),) ),

                SizedBox( height: 90,),

                InkWell(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Sign_Up()));
                  },
                  child: Text("Dont have account! Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize:14, color: Colors.black54 ),),
                )

              ],
            ),
          )
        ),
      ),
    );
  }
}
