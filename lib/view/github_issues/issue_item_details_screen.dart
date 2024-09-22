import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';

class IssueItemDetailsScreen extends StatelessWidget {
  final IssueItemModel selectedIssue;

  const IssueItemDetailsScreen({
    super.key,
    required this.selectedIssue,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextScaler textFont = MediaQuery.of(context).textScaler;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('${widget.selectedIssue.body}'),
            Padding(
              padding:  EdgeInsets.only(
                top: size.height * 0.01,
                left: size.width * 0.028,
                right: size.width * 0.028,
              ),
              child: Text(
                  selectedIssue.title.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xff333333),
                  fontSize: textFont.scale(17),
                ),
              ),
            ),
            // SizedBox(height: 10),
            const Divider(
              thickness: 1,
              // color: Colors.white54,
              color: Color(0xff333333),
            ),

            Expanded(
              child: Markdown(
                  data: selectedIssue.body.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
