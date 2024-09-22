import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';
import 'package:github_issue_tracker_app/repository/github_issues_repo/issues_list_repo.dart';
import 'package:github_issue_tracker_app/view/github_issues/issue_item_details_screen.dart';

class IssuesListScreen extends StatefulWidget {
  const IssuesListScreen({super.key});

  @override
  State<IssuesListScreen> createState() => _IssuesListScreenState();
}

class _IssuesListScreenState extends State<IssuesListScreen> {
  // dependency
  final IssuesListRepo _issuesListRepo = IssuesListRepo();
  // states
  List<IssueItemModel> filteredIssues = [];
  List<IssueItemModel>? issuesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Issues List'),
        backgroundColor: Color(0xff333333),
        elevation: 0,
      ),

      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Issues',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  filteredIssues = issuesData!.where((issue) => issue.title!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),

          Expanded(
            child: FutureBuilder<List<IssueItemModel>>(
                future: _issuesListRepo.fetchGithubIssues(),
                builder: (context, AsyncSnapshot<List<IssueItemModel>> snapshot){
                  // loading_indicator
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // error_showing
                  else if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  else{
                    if(snapshot.data!.isEmpty){
                      return const Center(
                        child: Text('Empty Github Issues'),
                      );
                    }
                    else{
                      log('.....inside_github_issues_list_screen.....${snapshot.data!.length}...........');
                      issuesData = snapshot.data!;
                      // setState(() {
                      //                       //   issuesData = snapshot.data!;
                      //                       // });

                      // List<IssueItemModel> issuesData = snapshot.data!.where((issueItem) => issueItem.title!.contains('flutter')).toList();

                      return ListView.builder(
                          itemCount: filteredIssues.isNotEmpty ? filteredIssues.length : issuesData!.length,
                          itemBuilder: (context, index){
                            var issueItemData = issuesData![index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => IssueItemDetailsScreen(selectedIssue: issueItemData,)
                                    ));
                              },
                              child: Card(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5
                                  ),
                                  elevation: 0,
                                  color: Colors.blue,
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children:[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            Expanded(
                                              child: Text(
                                                issueItemData.title.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Text(issueItemData.createdAt.toString()),
                                          ],
                                        ),

                                        Row(
                                          children:[
                                            CircleAvatar(
                                              radius: 24,
                                              child: Image(
                                                image: NetworkImage(issueItemData.user!.avatarUrl!.toString()),
                                                fit: BoxFit.contain,
                                              ),
                                            ),

                                            Text(issueItemData.nodeId.toString()),
                                          ],
                                        ),

                                        Divider(
                                          thickness: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            );
                          }
                      );
                    }
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
