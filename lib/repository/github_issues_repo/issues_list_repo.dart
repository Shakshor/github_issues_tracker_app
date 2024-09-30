import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_issue_tracker_app/Utils/app_url.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';
import 'package:http/http.dart' as http;
import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_service.dart';

// dependecny_injection
final issuesListRepoProvider = Provider((ref){
  return IssuesListRepo();
});

class IssuesListRepo {
  List<IssueItemModel> issuesList = [];

  // List<IssueItemModel>
  Future<List<IssueItemModel>> fetchGithubIssues () async {
    // dependency_object
    final BaseApiService apiService = NetWorkApiService();

   try{
     dynamic response = await apiService.getGetApiResponse(AppUrl.baseUrl);
     List<dynamic> dataBody = response!.toList();

     List<IssueItemModel> issuesList = dataBody.map((dynamic data) => IssueItemModel.fromJson(data)).toList();
     log('issues_list_repo_res2: ${issuesList.length}');

     return issuesList;
   }catch(e){
     print('inside_issues_list_repo_error: ${e.toString()}');
     throw e.toString();
   }
  }

  // Future<List<IssueItemModel>> fetchGithubIssuesWithoutFilter () async {
  //   if(issuesList.length.isNegative == false){
  //     return issuesList.where((issueItem) => !(issueItem.title!.toLowerCase().contains('flutter'))).toList();
  //   }else{
  //     return issuesList;
  //   }
  // }

  void searchIssueResult(query, issuesWithoutFlutter){
    if(issuesWithoutFlutter == null){
      log('inside_issues_list_repo: Empty Issues');
      return;
    }
  }
}



// ---------------------------------------- state_notifier ------------------------------------------------

final issuesNotifierProvider = StateNotifierProvider<IssuesNotifier, List<IssueItemModel>>((ref){
  final githubIssuesListRepoProvider = ref.watch(issuesListRepoProvider);
  return IssuesNotifier(githubIssuesListRepoProvider);
});


class IssuesNotifier extends StateNotifier<List<IssueItemModel>>{
  IssuesListRepo issuesListRepo;
  late List<IssueItemModel> _allIssues = [];

  IssuesNotifier(this.issuesListRepo): super([]){
    fetchAllIssues();
  }

  Future<void> fetchAllIssues() async {
    final allIssuesList =  await issuesListRepo.fetchGithubIssues();
    _allIssues = allIssuesList;
    state = allIssuesList;
  }

  // Future<void> fetchIssuesWithoutFlutter() async {
  //   final allIssuesList =  await issuesListRepo.fetchGithubIssues();
  //   state = allIssuesList;
  // }

  void filterIssues(String query) async {
    if (query.isEmpty) {
      // If search query is empty, show all issues
      state = _allIssues;
    } else {
      state = _allIssues.where((issue) => issue.title!.toLowerCase().contains(query.toLowerCase())).toList();
    }

    log('before:${state.length}');
    final allIssuesList =  await issuesListRepo.fetchGithubIssues();
    state = allIssuesList.where((issue) => issue.title!.toLowerCase().contains(query.toLowerCase())).toList();
    log('after_filter: ${state.length}');
  }
}