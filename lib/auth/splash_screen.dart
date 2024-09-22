import 'dart:async';
import 'package:flutter/material.dart';
import '../view/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    // calling the function
    isSignIn();
  }


  // check_the_signin_condition and
  // navigate_to_next_screen
  void isSignIn () async {
    Timer(const Duration(seconds: 4), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // company logo
      body:  Center(
        child: SizedBox(

          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.80,

          child: const Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/github_logo_first.png'),
          ),
        ),
      ),

    );
  }
}