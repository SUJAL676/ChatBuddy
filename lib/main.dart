import 'package:chat_buddy/screens/MainHomePage.dart';
import 'package:chat_buddy/screens/homepage.dart';
import 'package:chat_buddy/screens/login_screen.dart';
import 'package:chat_buddy/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'new/LoginScreen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb)
    {
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD6NLNlwTiW2rDUGzsdkbUcnx8IyT56QB0",
            authDomain: "chatbuddy-6519e.firebaseapp.com",
            projectId: "chatbuddy-6519e",
            storageBucket: "chatbuddy-6519e.appspot.com",
            messagingSenderId: "789738590206",
            appId: "1:789738590206:web:926eba21fe31ad363b3aaf")
      );
    }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot)
        {
          if(snapshot.connectionState == ConnectionState.active)
            {
              if (snapshot.hasData)
                {
                  return MainHomePage();
                }
              else if (snapshot.hasError)
                {
                  return Center(child: Text("Error"),);
                }
            }
          if (snapshot.connectionState==ConnectionState.waiting)
            {
              Center(child: CircularProgressIndicator(),);
            }
          return LoginScreen();
        },
      )
    );
  }
}