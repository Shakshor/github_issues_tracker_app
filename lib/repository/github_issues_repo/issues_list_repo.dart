import 'dart:convert';
import 'dart:developer';
import 'package:github_issue_tracker_app/Utils/app_url.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_item_model.dart';
import 'package:http/http.dart' as http;

class IssuesListRepo {
  Future<List<IssueItemModel>> fetchGithubIssues () async {
    dynamic url = AppUrl.baseUrl;
    final response = await http.get(Uri.parse(url));
    log('issues_list_repo_res_status: ${response.statusCode}');
    try{
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        log('issues_list_repo_res: $data');

        List<dynamic> dataBody = data!.toList();

        List<IssueItemModel> issuesList = dataBody.map((dynamic data) => IssueItemModel.fromJson(data)).toList();
        log('issues_list_repo_res2: ${issuesList.length}');

        return issuesList;
      }
      else{
        throw Exception('Error in Issues List Repo');
      }
    }catch(e){
      log(e.toString());
      throw Exception('$e:${response.statusCode}');
    }
  }
}