import 'package:image_picker/image_picker.dart';

class VideoModel {
  String title;
  XFile? file;
  String videoId;
  String uploaderName;
  String uploaderUid;
  int views;
  String category;
  String location;
  String postedTimeStamp;
  String videoUrl;
  int likes;
  int dislikes;
  List<dynamic> comments;

  VideoModel({
    required this.title,
    required this.file,
    required this.videoId,
    required this.uploaderName,
    required this.views,
    required this.category,
    required this.location,
    required this.postedTimeStamp,
    required this.uploaderUid,
    required this.videoUrl,
    required this.dislikes,
    required this.likes,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "videoId": videoId,
      "uploaderName": uploaderName,
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
