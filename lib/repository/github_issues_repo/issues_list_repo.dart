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
    //
    // dynamic url = AppUrl.baseUrl;
    // final response = await http.get(Uri.parse(url));
    // log('issues_list_repo_res_status: ${response.statusCode}');
    // try{
    //   if(response.statusCode == 200){
    //     var data = jsonDecode(response.body.toString());
    //     log('issues_list_repo_res: $data');
    //
    //     List<dynamic> dataBody = data!.toList();
    //
    //     List<IssueItemModel> issuesList = dataBody.map((dynamic data) => IssueItemModel.fromJson(data)).toList();
    //     log('issues_list_repo_res2: ${issuesList.length}');
    //
    //     return issuesList;
    //   }
    //   else{
    //     throw Exception('Error in Issues List Repo');
    //   }
    // }catch(e){
    //   log(e.toString());
    //   throw Exception('$e:${response.statusCode}');
    // }

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