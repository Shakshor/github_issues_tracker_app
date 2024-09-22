import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextScaler textFont = MediaQuery.of(context).textScaler;

    return Scaffold(
      backgroundColor: const Color(0xff333333),

      // preserving previous state
      body: SafeArea(
        child: Column(
          children: [
           Padding(
             padding:  EdgeInsets.only(
               top: size.width * 0.12,
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,

               children: [
                 _buildProfileImage(size),

                 _buildProfileInfo(size, textFont),

                 _buildProfileDetails(size, textFont),

                 _buildGithubDetails(textFont)
               ],
             ),
           )
          ],
        ),
      ),
    );
  }

  Widget _buildGithubDetails(TextScaler textFont) {
    return Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                   Text(
                       'Public Repos: 2',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: textFont.scale(17),
                     ),
                   ),
                   Text(
                       'Public Gists: 5',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: textFont.scale(17),
                     ),
                   ),
                   Text(
                       'Private Repos: 5',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: textFont.scale(17),
                     ),
                   ),
                 ],
               );
  }

  Widget _buildProfileDetails(Size size, TextScaler textFont) {
    return Padding(
                 padding: EdgeInsets.symmetric(
                   horizontal: size.width * 0.016,
                   vertical:  size.height * 0.016,
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,

                   children: [
                     Text(
                         'Bio: Passionate Software Engineer..',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: textFont.scale(17),
                       ),
                     ),
                   ],
                 ),
               );
  }

  Widget _buildProfileInfo(Size size, TextScaler textFont) {
    return Padding(
                 padding: EdgeInsets.symmetric(
                   horizontal: size.width * 0.008,
                   vertical:  size.height * 0.008,
                 ),
                 child: Column(
                   children: [
                     Text(
                         'Fatin Ismam',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: textFont.scale(24),
                       ),
                     ),
                     Text(
                         '@fatin_ishmam',
                          style: TextStyle(
                            color: const Color(0xffC9C9C9),
                            fontSize: textFont.scale(14),
                          ),
                     )
                   ],
                 ),
               );
  }

  Widget _buildProfileImage(Size size) {
    return CircleAvatar(
                  radius: size.width * 0.3,
                  // radius: 168,
                  backgroundImage: const AssetImage(
                      'assets/images/person_image.png',
                  ),
                );
  }
}
