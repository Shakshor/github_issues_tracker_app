import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';

class IssueItemDetailsScreen extends StatefulWidget {
  final IssueItemModel selectedIssue;

  const IssueItemDetailsScreen({
    super.key,
    required this.selectedIssue,
  });

  @override
  State<IssueItemDetailsScreen> createState() => _IssueItemDetailsScreenState();
}

class _IssueItemDetailsScreenState extends State<IssueItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('${widget.selectedIssue.body}'),
            Text(
                widget.selectedIssue.title.toString(),
                style: TextStyle(fontSize: 20),
            ),
            // SizedBox(height: 10),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: Markdown(
                  // selectable: true,
                  // onTapLink: ,
                  data: widget.selectedIssue.body.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
