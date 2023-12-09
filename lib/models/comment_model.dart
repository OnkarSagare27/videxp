class CommentModel {
  final String name;
  final String pfp;
  final String commentContent;

  CommentModel({
    required this.name,
    required this.pfp,
    required this.commentContent,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      name: map['name'],
      pfp: map['pfp'],
      commentContent: map['commentContet'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "pfp": pfp,
      "commentContent": commentContent,
    };
  }
}
