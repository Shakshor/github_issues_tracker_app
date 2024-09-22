import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff333333),
    
      // preserving previous state
      body: SafeArea(
        child: Column(
          children: [
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,

             children: [
                CircleAvatar(
                  radius: 120,
                ),
               Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Text(
                         'Francisco Miles',
                       style: TextStyle(
                         fontSize: 30,
                       ),
                     ),
                     Text('@Francisco_miles')
                   ],
                 ),
               ),

               Padding(
                 padding: EdgeInsets.all(16.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,

                   children: [
                     Text('Bio: There was once..'),
                   ],
                 ),
               ),

               Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                   Text('Public Repos: 2'),
                   Text('Public Gists: 2'),
                   Text('Private Repos: 2'),
                 ],
               )
             ],
           )
          ],
        ),
      ),
    );
  }
}
