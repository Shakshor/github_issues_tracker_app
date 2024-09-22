import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';
import 'package:github_issue_tracker_app/repository/github_issues_repo/issues_list_repo.dart';
import 'package:github_issue_tracker_app/view/github_issues/issue_item_details_screen.dart';

class IssuesListTestScreen extends StatefulWidget {
  const IssuesListTestScreen({super.key});

  @override
  State<IssuesListTestScreen> createState() => _IssuesListTestScreenState();
}

class _IssuesListTestScreenState extends State<IssuesListTestScreen> {
  // dependency
  final IssuesListRepo _issuesListRepo = IssuesListRepo();
  // states
  List<IssueItemModel> filteredIssues = [];
  List<IssueItemModel>? allIssuesData;
  // List<IssueItemModel>? issuesWithoutFlutter;

  String currentFilter = 'All'; // State to keep track of the current filter.
  String searchQuery = ''; // State to keep track of the search query.

  Future<List<IssueItemModel>> fetchIssues() async {
    // Fetch all issues from the API.
    _issuesListRepo.fetchGithubIssues().then((value){
      print(value);
      setState(() {
        List<IssueItemModel> allIssuesData =  value;
      });


      // Apply filter based on the current selection.
      if (currentFilter == 'Without Flutter') {
        allIssuesData = allIssuesData!
            .where((issue) => !(issue.title!.toLowerCase().contains('flutter')))
            .toList();
      }

      // Further filter based on the search query.
      if (searchQuery.isNotEmpty) {
        allIssuesData = allIssuesData!
            .where((issue) => issue.title!.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      }

      return allIssuesData;
    }).catchError((error){
      print(error.toString());
      throw error.toString();
    });
    return filteredIssues;
  }


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }




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
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // search_text_field
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                      vertical: size.height * 0.004,
                      // vertical: ,
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textFont.scale(17),
                      ),
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
                      onChanged: (query){
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                  ),
                ),

                // // menu_anchor_btn
                Expanded(
                  child: MenuAnchor(
                      style: const MenuStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xff333333)),
                      ),
                      builder: (BuildContext context, MenuController controller, Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Filters',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textFont.scale(17),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: size.height * 0.024,
                                color: Colors.white,
                              )
                            ],
                          ),
                          tooltip: 'Show menu',
                        );
                      },
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = 'All'; // Update to show all issues.
                            });
                          },
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textFont.scale(16),
                            ),
                          ),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            setState(() {
                              currentFilter = 'Without Flutter'; // Update to show all issues.
                            });
                          },
                          child: Text('Without Flutter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textFont.scale(16),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),

            // showing_list_data
            Expanded(
              child: FutureBuilder<List<IssueItemModel>>(
                  future: fetchIssues(),
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
                        child: Text(
                            snapshot.error.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: textFont.scale(17),
                          ),
                        ),
                      );
                    }
                    else{
                      if(snapshot.data!.isEmpty){
                        return Center(
                          child: Text(
                              'Empty Github Issues',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textFont.scale(17),
                            ),
                          ),
                        );
                      }
                      else{
                        log('.....inside_total_github_issues_list_screen.....${snapshot.data!.length}...........');
                        final allIssuesData = snapshot.data!;
                        return ListView.builder(
                            itemCount: allIssuesData.length,
                            itemBuilder: (context, index){
                              var issueItemData = allIssuesData[index];
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
                    }
                  }
              ),
            ),
          ],
        ),
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
