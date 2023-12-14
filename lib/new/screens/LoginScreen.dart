import 'package:chat_buddy/firebase/Auth.dart';
import 'package:chat_buddy/new/screens/SingUpScreen.dart';
import 'package:chat_buddy/new/screens/MainHomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passcontroller=TextEditingController();
  bool _isload=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 30,left: 30,top:80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Log in to Chatbox",style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(61, 74, 122, 1),
                ),),

                SizedBox(height: 25,),

                Text("Welcome to Back! Sign in using",style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(121, 124, 123, 1),
                ),),

                Text("email to continue us",style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(121, 124, 123, 1),
                ),),

                SizedBox(height: 80,),

                Container(
                  width: double.infinity,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your email",style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(61, 74, 122, 1),
                      ),),

                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(121, 124, 123, 1),
                            )
                          )
                        ),
                          child: TextField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ))
                    ],
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  width: double.infinity,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password",style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(61, 74, 122, 1),
                      ),),

                      Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(121, 124, 123, 1),
                                  )
                              )
                          ),
                          child: TextField(
                            controller: _passcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                            ),
                            obscureText: true,
                          )),

                    ],
                  ),
                ),


                SizedBox(height: 180,),

                // Image.asset("asset/loginbutton.png"),

                Container(
                  width: double.infinity,
                  height: 55,
                  // color: Colors.black,
                  child: Stack(
                    children: [
                      Center(child: InkWell
                        (onTap: () async {
                        setState(() { _isload=true;});
                        String a=await Auth().login(email: _emailcontroller.text, pass: _passcontroller.text);
                        setState(() { _isload=false;});

                        if(a=="Sucess")
                        {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainHomePage()));
                        }
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a)));
                        }
                      },
                          child: Image.asset("asset/loginbutton.png"))),
                      Center(child:_isload ? CircularProgressIndicator(color: Colors.white,) :
                      Text("Login in" , style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),)
                    ],
                  ),
                ),

                SizedBox(height: 10,),

                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                  child: Text("Create account",style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(61, 74, 122, 1),
                  ),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
