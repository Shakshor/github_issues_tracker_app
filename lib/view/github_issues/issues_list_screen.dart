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
    Size size = MediaQuery.of(context).size;
    TextScaler textFont = MediaQuery.of(context).textScaler;

    return Scaffold(
      backgroundColor: const Color(0xff333333),

      body: SafeArea(
        child: Column(
          children:[
            _buildPageTitle(size, textFont),

            _buildFilterTextField(size, textFont),

            _buildIssueExpanded(size, textFont),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueExpanded(Size size, TextScaler textFont) {
    return Expanded(
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
                      // List<IssueItemModel> issuesData = snapshot.data!.where((issueItem) => issueItem.title!.contains('flutter')).toList();

                      return _buildIssuesListView(size, textFont);
                    }
                  }
                }
            ),
          );
  }

  Widget _buildIssuesListView(Size size, TextScaler textFont) {
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
                                  margin: EdgeInsets.zero,
                                  surfaceTintColor: const Color(0xff333333),
                                  elevation: 0,
                                  color: const Color(0xff333333),
                                  child:Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.012,
                                      horizontal: size.width * 0.028,
                                    ),
                                    child: Column(
                                      children:[
                                        // issue_title&time
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            Expanded(
                                              child: Text(
                                                issueItemData.title.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: textFont.scale(17),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              issueItemData.createdAt.toString(),
                                              style: TextStyle(
                                                fontSize: textFont.scale(12),
                                                color: const Color(0xffB8B8B8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // image&name_id
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:[
                                            CircleAvatar(
                                              // radius: 24,
                                              radius: size.width * 0.06,
                                              backgroundImage: NetworkImage(issueItemData.user!.avatarUrl!.toString()),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: size.width * 0.02,
                                              ),
                                              child: Text(
                                                issueItemData.nodeId.toString(),
                                                style: TextStyle(
                                                  fontSize: textFont.scale(12),
                                                  color: const Color(0xff9B9B9B),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            );
                          }
                      );
  }

  Widget _buildFilterTextField(Size size, TextScaler textFont) {
    return Padding(
            padding:  EdgeInsets.symmetric(
                vertical: size.height * 0.008,
                // vertical: ,
            ),
            child: TextField(
              decoration:  InputDecoration(
                labelText: 'Search Issue Title',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: textFont.scale(17),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: size.width * 0.002,
                      color: Colors.white,
                  )
                ),
              ),
              onChanged: (query) {
                setState(() {
                  filteredIssues = issuesData!.where((issue) => issue.title!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
            ),
          );
  }

  Widget _buildPageTitle(Size size, TextScaler textFont) {
    return Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.01,
              bottom: size.height * 0.01,
              left: size.width * 0.028,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    'Flutter Commit List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textFont.scale(17),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.008
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff515050),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                      'master',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textFont.scale(17),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
