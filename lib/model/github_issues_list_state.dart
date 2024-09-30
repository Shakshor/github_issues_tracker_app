import 'github_issuse_item_model/issue_item_model.dart';

class GithubIssuesState{
 final List<IssueItemModel> issuesList;

 GithubIssuesState({
       required this.issuesList
     });

  GithubIssuesState.initial({
    this.issuesList = const [],
  });

  GithubIssuesState copyWith({
    List<IssueItemModel>? issuesList,
  }){
    return GithubIssuesState(
        issuesList: issuesList ?? this.issuesList,
    );
  }
}


// class TaskState extends Equatable {
//   final List<Task> tasks;
//
//   const TaskState({
//     required this.tasks,
//   });
//   const TaskState.initial({
//     this.tasks = const [],
//   });
//
//   TaskState copyWith({
//     List<Task>? tasks,
//   }) {
//     return TaskState(
//       tasks: tasks ?? this.tasks,
//     );
//   }
//
//   @override
//   List<Object> get props => [tasks];
// }