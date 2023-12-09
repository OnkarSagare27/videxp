import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/widgets/video_tile.dart';

class ViewAllVideosScreen extends StatefulWidget {
  final String uploaderUid;
  final String uploaderName;
  final UserModel userModel;
  const ViewAllVideosScreen(
      {super.key,
      required this.uploaderUid,
      required this.userModel,
      required this.uploaderName});

  @override
  State<ViewAllVideosScreen> createState() => _ViewAllVideosScreenState();
}

class _ViewAllVideosScreenState extends State<ViewAllVideosScreen> {
  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  void loadVideos() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'All posts: ${widget.uploaderName}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .where("uploaderUid", isEqualTo: widget.uploaderUid)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                VideoModel videoModel = VideoModel.fromMap(data);
                return VideoTile(
                  videoModel: videoModel,
                  userModel: widget.userModel,
                );
              },
            );
          }

          return const Center(
              child: CircularProgressIndicator(
            color: Colors.amber,
          ));
        },
      ),
    );
  }
}
