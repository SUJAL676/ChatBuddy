import 'package:chat_buddy/Widgets/text_field.dart';
import 'package:chat_buddy/firebase/Auth.dart';
import 'package:chat_buddy/screens/homepage.dart';
import 'package:flutter/material.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}


class _Sign_UpState extends State<Sign_Up> {
  @override

  TextEditingController username=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  bool _isLoading=false;

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    email.dispose();
    pass.dispose();
  }

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

                  const SizedBox(height: 30,),
                  SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2bKtNCv9MOsnzgWHBT27E5lq5yTjlkO9-vw&usqp=CAU"),)
                  ),
                  const SizedBox(height: 60,),

                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: "Email",
                  //     hintStyle: TextStyle(color: primary)
                  //   ),
                  // )

                  Text_Field_Icon(hint_text: 'Full Name', icon: Icon(Icons.person), controller: username,),

                  Text_Field_Icon(hint_text: 'Email', icon: Icon(Icons.email), controller: email,),

                  Text_Field_Icon(hint_text: 'Password', icon: Icon(Icons.lock), controller: pass,),

                  ElevatedButton(onPressed: () async {

                    {
                      setState(() {_isLoading=true;});

                      String a =await Auth().signUp(email: email.text, pass: pass.text, username: username.text, profilePic: " ", group: []);

                      setState(() {_isLoading=false;});

                      if (a=="Sucess")
                      {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a.toString())));
                      }
                    }

                  },
                      style:_isLoading?
                      ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(120, 50)),
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                      )
                          : ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(100, 30)),
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                      ),
                      child:_isLoading? const CircularProgressIndicator()
                          :Text("Sign Up" ,  style: TextStyle(
                          fontSize: 17
                      ),) )

                ],
              ),
            )
        ),
      ),
    );;
  }
}
