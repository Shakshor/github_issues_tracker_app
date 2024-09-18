import 'package:flutter/material.dart';

class IssuesListScreen extends StatefulWidget {
  const IssuesListScreen({super.key});

  @override
  State<IssuesListScreen> createState() => _IssuesListScreenState();
}

class _IssuesListScreenState extends State<IssuesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Issues List'),
        backgroundColor: Color(0xff333333),
        elevation: 0,
      ),

      body: Center(
        child: Text('Issues here...'),
      ),
    );
  }
}
