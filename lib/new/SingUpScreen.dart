import 'dart:typed_data';
import 'package:chat_buddy/firebase/Auth.dart';
import 'package:chat_buddy/screens/MainHomePage.dart';
import 'package:chat_buddy/utils/imagePicker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _isload=false;
  TextEditingController _usernamecontroller=TextEditingController();
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passcontroller=TextEditingController();
  Uint8List? image;
  bool _isuploaded=false;

  selectImage()
  async {
    Uint8List im=await pickImage(ImageSource.gallery,context);
    setState(() {
      image=im;
      _isuploaded=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 30,left: 30,top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign up with Email",style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(61, 74, 122, 1),
                ),),

                SizedBox(height: 15,),

                Text("Get chatting with friends and family",style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(121, 124, 123, 1),
                ),),

                Text("today by signing up for our chat app",style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(121, 124, 123, 1),
                ),),

                SizedBox(height: 30,),

                Container(
                  width: 110,
                  height: 110,
                  child: Stack(
                    children: [
                      image!=null ? CircleAvatar(
                        radius: 55,
                        backgroundImage: MemoryImage(image!),
                      ):InkWell(
                        onTap: ()=>selectImage(),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Color.fromRGBO(153, 181, 208, 1.0),),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.add_a_photo ,color: Colors.black,size: 25,)))
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
                      Text("Username",style: GoogleFonts.poppins(
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
                            controller: _usernamecontroller,
                            // controller: _emailcontroller,
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
                      Text("Email",style: GoogleFonts.poppins(
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
                            // controller: _passcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            // obscureText: true,
                          )),

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
                SizedBox(height: 30,),



                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isload=true;
                    });
                    String a = await Auth().signUp(email: _emailcontroller.text, pass: _passcontroller.text, username: _usernamecontroller.text, profilePic: image!, group: []);
                              if(a=="Sucess")
                                {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainHomePage()));
                                }
                              else{
                                setState(() {
                                  _isload=false;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a.toString())));
                                });
                              }

                  },
                  child: Container(
                    width: 300,
                    height: 53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color : Color.fromRGBO(30, 39, 76, 1),
                    ),
                    // color: Colors.black,
                    // child: Stack(
                    //   children: [
                    //     Center(child: InkWell(
                    //         onTap: () async {
                    //           setState(() {
                    //             _isload=true;
                    //           });
                    //           String a = await Auth().signUp(email: _emailcontroller.text, pass: _passcontroller.text, username: _usernamecontroller.text, profilePic: image!, group: []);
                    //           if(a=="Sucess")
                    //             {
                    //               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainHomePage()));
                    //             }
                    //           else{
                    //             setState(() {
                    //               _isload=false;
                    //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a.toString())));
                    //             });
                    //           }
                    //         },
                    //         child: Image.asset("asset/loginbutton.png"))),
                    //     Center(child:_isload ? CircularProgressIndicator(color: Colors.white,) :
                    //     Text("Login in" , style: GoogleFonts.poppins(
                    //         fontSize: 14,
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w600
                    //     ),),)
                    //   ],
                    // ),

                    child : Center(
                      child: _isload?CircularProgressIndicator():Text("SignUp",style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      )),
                    )
                  ),
                ),

                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
