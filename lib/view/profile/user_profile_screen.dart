import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      // appBar: AppBar(
      //   title: const Text('User Profile Screen'),
      //   backgroundColor: Color(0xff333333),
      //   elevation: 0,
      // ),
    
      // preserving previous state
      body: SafeArea(
        child: Center(
          child: Text(
              'Profile here...',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
