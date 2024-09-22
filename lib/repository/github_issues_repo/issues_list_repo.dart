import 'dart:convert';
import 'dart:developer';
import 'package:github_issue_tracker_app/Utils/app_url.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';
import 'package:http/http.dart' as http;

import '../../data/network/base_api_service.dart';
import '../../data/network/network_api_service.dart';

class IssuesListRepo {
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
     print(e.toString());
     throw e.toString();
   }
  }
}