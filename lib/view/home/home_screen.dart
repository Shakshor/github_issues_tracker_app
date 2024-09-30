import 'package:flutter/material.dart';
import 'package:github_issue_tracker_app/view/github_issues/issues_list_screen.dart';
import 'package:github_issue_tracker_app/view/github_issues/issues_list_test_screen.dart';
import 'package:github_issue_tracker_app/view/profile/user_profile_screen.dart';

import '../github_issues/issues_list_screen_with_state_management.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // state
  int _currentIndex = 0;

  // pages
  final List<Widget> pages =  const [
    // IssuesListScreen(),
    IssuesListWithStateManagementScreen(),
    UserProfileScreen(),
  ];

  // handle tap function
  void handleTapEvent (int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      //   backgroundColor: Color(0xff333333),
      //   elevation: 0,
      // ),

      // preserving previous state
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // bottom_bar_method
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      // backgroundColor: Color(0xff333333),
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,

      // onTap event for navigate page
      onTap: handleTapEvent,

      items: const <BottomNavigationBarItem>[
        // issues
        BottomNavigationBarItem(
            icon: Icon(
              Icons.commit_outlined
            ),
            activeIcon: Icon(
              Icons.commit,
            ),
            label: 'Issues'
        ),
        // profile
        BottomNavigationBarItem(
            icon: Icon(
                Icons.person_outline,
            ),
            activeIcon: Icon(
              Icons.person,
            ),
            label: 'Profile'
        ),
      ],
    );
  }
}
