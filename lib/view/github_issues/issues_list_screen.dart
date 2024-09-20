import 'package:flutter/material.dart';
import 'package:github_issue_tracker_app/repository/github_issues_repo/issues_list_repo.dart';

class IssuesListScreen extends StatefulWidget {
  const IssuesListScreen({super.key});

  @override
  State<IssuesListScreen> createState() => _IssuesListScreenState();
}

class _IssuesListScreenState extends State<IssuesListScreen> {
  // dependency
  final IssuesListRepo _issuesListRepo = IssuesListRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Issues List'),
        backgroundColor: Color(0xff333333),
        elevation: 0,
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _issuesListRepo.fetchGithubIssues();
          },
          child: Text('Fetch Issues'),
        ),
      ),
    );
  }
}
