import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/widgets/video_tile.dart';

class SearchResultScreen extends StatefulWidget {
  final String category;
  final String searchString;
  final UserModel userModel;
  const SearchResultScreen(
      {super.key,
      required this.category,
      required this.userModel,
      required this.searchString});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  void loadVideos() {}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Search result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: widget.category != 'Category'
            ? FirebaseFirestore.instance
                .collection('videos')
                .where("category", isEqualTo: widget.category)
                .snapshots()
            : FirebaseFirestore.instance.collection('videos').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                VideoModel videoModel = VideoModel.fromMap(data);
                if (widget.searchString.isNotEmpty) {
                  bool containsElement = widget.searchString.split(' ').any(
                        (element) => data.toString().toLowerCase().contains(
                              element.toLowerCase(),
                            ),
                      );

                  if (containsElement) {
                    return VideoTile(
                      videoModel: videoModel,
                      userModel: widget.userModel,
                    );
                  }
                }
                if (widget.category == data['category']) {
                  return VideoTile(
                    videoModel: videoModel,
                    userModel: widget.userModel,
                  );
                }
                return null;
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
