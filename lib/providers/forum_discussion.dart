class DiscussionForum {
  final String id;
  final String category;
  final int viewer;
  final int commentators;
  final String title;
  final String discussionText;
  final DateTime dateCreated;
  final int comments;

  DiscussionForum({
    required this.id,
    required this.category,
    required this.commentators,
    required this.dateCreated,
    required this.discussionText,
    required this.title,
    required this.viewer,
    required this.comments,
  });
}
