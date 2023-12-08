import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:videxplore/models/user_model.dart';

class LibraryScreen extends StatefulWidget {
  final UserModel userModel;
  const LibraryScreen({super.key, required this.userModel});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  void loadVideos() {}

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Library',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .where("uploaderUid", isEqualTo: widget.userModel.uid)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                return ListTile(
                  leading: Image.network(
                    data['thumbnail'],
                    height: screenSize.width * 15 / 100,
                    width: screenSize.width * 15 / 100,
                  ),
                  title: Text(data['title']),
                  subtitle: Text(data['uploaderName']),
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
