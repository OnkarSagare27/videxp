import 'package:image_picker/image_picker.dart';

class VideoModel {
  String title;
  XFile? file;
  String videoId;
  String uploaderName;
  String uploaderPfp;
  String uploaderUid;
  List<dynamic> views;
  String category;
  String location;
  int postedTimeStamp;
  String videoUrl;
  List<dynamic> likes;
  List<dynamic> dislikes;
  dynamic thumbnail;
  List<dynamic> comments;

  VideoModel({
    this.file,
    required this.title,
    required this.videoId,
    required this.uploaderName,
    required this.uploaderPfp,
    required this.views,
    required this.category,
    required this.location,
    required this.postedTimeStamp,
    required this.uploaderUid,
    required this.videoUrl,
    required this.dislikes,
    required this.likes,
    required this.comments,
    required this.thumbnail,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      title: map["title"],
      videoId: map["videoId"],
      thumbnail: map["thumbnail"],
      uploaderName: map["uploaderName"],
      uploaderPfp: map["uploaderPfp"],
      uploaderUid: map["uploaderUid"],
      views: map["views"],
      category: map["category"],
      location: map["location"],
      postedTimeStamp: map["postedTimeStamp"],
      videoUrl: map["videoUrl"],
      likes: map["likes"],
      dislikes: map["dislikes"],
      comments: map["comments"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "videoId": videoId,
      "thumbnail": thumbnail,
      "uploaderName": uploaderName,
      "uploaderPfp": uploaderPfp,
      "uploaderUid": uploaderUid,
      "views": views,
      "category": category,
      "location": location,
      "postedTimeStamp": postedTimeStamp,
      "videoUrl": videoUrl,
      "likes": likes,
      "dislikes": dislikes,
      "comments": comments,
    };
  }
}
