class VideoModel {
  final String title;
  final String uploaderName;
  final String views;
  final String category;
  final String location;
  final String postedTimeStamp;

  VideoModel(
      {required this.title,
      required this.uploaderName,
      required this.views,
      required this.category,
      required this.location,
      required this.postedTimeStamp});
}
