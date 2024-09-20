import 'package:github_issue_tracker_app/model/github_issuse_item_model/issue_user_model.dart';
import 'package:github_issue_tracker_app/model/github_issuse_item_model/label_item_model.dart';

class IssueItemModel{
  String? url;
  String? repositoryUrl;
  String? labelsUrl;
  String? commentsUrl;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  int? number;
  String? title;
  IssueUserModel? user;
  List<LabelItemModel>? labels;
  String? state;
  bool? locked;
  dynamic assignee;
  // List<>? assignees;
  dynamic milestone;
  int? comments;
  String? createdAt;
  String? updatedAt;
  dynamic closedAt;
  String? authorAssociation;
  dynamic activeLockReason;
  String? body;
  dynamic closedBy;
  // Reactions? reactions;
  String? timelineUrl;
  dynamic performedViaGithubApp;
  dynamic stateReason;

  IssueItemModel({
    this.url,
    this.repositoryUrl,
    this.labelsUrl,
    this.commentsUrl,
    this.eventsUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.number,
    this.title,
    this.user,
    this.labels,
    this.state,
    this.locked,
    this.assignee,
    // this.assignees,
    this.milestone,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.authorAssociation,
    this.activeLockReason,
    this.body,
    this.closedBy,
    // this.reactions,
    this.timelineUrl,
    this.performedViaGithubApp,
    this.stateReason,
  });

  factory IssueItemModel.fromJson(Map<String, dynamic> json){
    // labels_list
    List<LabelItemModel> labelsList = [];
    if (json['labels'] != null) {
      json['labels'].forEach((label) {
        labelsList.add(LabelItemModel.fromJson(label));
      });
    }

    return IssueItemModel(
        url: json['url'],
        repositoryUrl: json['repository_url'],
        labelsUrl: json['labels_url'],
        commentsUrl: json['comments_url'],
        eventsUrl: json['events_url'],
        htmlUrl: json['html_url'],
        id: json['id'],
        nodeId: json['node_id'],
        number: json['number'],
        title: json['title'],
        user: json['user'] != null ? IssueUserModel.fromJson(json['user']) : null,
        labels: labelsList,
        state: json['state'],
        locked: json['locked'],
        assignee: json['assignee'],
        // assignees: ,
        milestone: json['milestone'],
        comments: json['comments'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        closedAt: json['closed_at'],
        authorAssociation: json['author_association'],
        activeLockReason: json['active_lock_reason'],
        body: json['body'],
        closedBy: json['closed_by'],
        // reactions: ,
        timelineUrl: json['timeline_url'],
        performedViaGithubApp: json['performed_via_github_app'],
        stateReason: json['state_reason'],
    );
  }
}