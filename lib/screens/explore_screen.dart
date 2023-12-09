import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/widgets/video_tile.dart';

class ExploreScreen extends StatefulWidget {
  final UserModel? userModel;
  const ExploreScreen({super.key, required this.userModel});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('videos').snapshots(),
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
                  userModel: widget.userModel!,
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        },
      ),
    );
  }
}
