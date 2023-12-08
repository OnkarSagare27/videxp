import 'package:image_picker/image_picker.dart';

class VideoModel {
  String title;
  XFile? file;
  String videoId;
  String uploaderName;
  String uploaderPfp;
  String uploaderUid;
  int views;
  String category;
  String location;
  int postedTimeStamp;
  String videoUrl;
  int likes;
  int dislikes;
  dynamic thumbnail;
  List<dynamic> comments;

  VideoModel({
    required this.title,
    required this.file,
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
