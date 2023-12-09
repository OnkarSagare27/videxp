import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/widgets/vid_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel videoModel;
  const VideoPlayerScreen({
    super.key,
    required this.videoModel,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            VideoPlayerView(
              dataSourceType: DataSourceType.network,
              url: widget.videoModel.videoUrl,
            ),
            Padding(
              padding: EdgeInsets.all(
                screenSize.width * 3 / 100,
              ),
              child: Text(
                'New random video of a city New random video of a city New random video of a city',
                maxLines: 3,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 3.5 / 100,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt_rounded,
                        color: Colors.white,
                        size: screenSize.width * 5 / 100,
                      ),
                      SizedBox(
                        width: screenSize.width * 2 / 100,
                      ),
                      Text(
                        widget.videoModel.likes.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 4 / 100,
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_down_alt_rounded,
                        color: Colors.white,
                        size: screenSize.width * 5 / 100,
                      ),
                      SizedBox(
                        width: screenSize.width * 2 / 100,
                      ),
                      Text(
                        widget.videoModel.dislikes.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 4 / 100,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 3 / 100,
                vertical: screenSize.width * 4 / 100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenSize.width * 30 / 100,
                    height: screenSize.width * 8 / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 2 / 100,
                          vertical: screenSize.width * 1 / 100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove_red_eye_rounded,
                              size: screenSize.width * 4 / 100,
                            ),
                            SizedBox(
                              width: screenSize.width * 1 / 100,
                            ),
                            SizedBox(
                              width: screenSize.width * 20 / 100,
                              child: Center(
                                child: Text(
                                  (widget.videoModel.views + 10000).toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 3 / 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 30 / 100,
                    height: screenSize.width * 8 / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 2 / 100,
                          vertical: screenSize.width * 1 / 100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              size: screenSize.width * 4 / 100,
                            ),
                            SizedBox(
                              width: screenSize.width * 1 / 100,
                            ),
                            SizedBox(
                              width: screenSize.width * 20 / 100,
                              child: Center(
                                child: Text(
                                  widget.videoModel.postedTimeStamp.toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 3 / 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 30 / 100,
                    height: screenSize.width * 8 / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 2 / 100,
                          vertical: screenSize.width * 1 / 100,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.category_rounded,
                              size: screenSize.width * 4 / 100,
                            ),
                            SizedBox(
                              width: screenSize.width * 1 / 100,
                            ),
                            SizedBox(
                              width: screenSize.width * 20 / 100,
                              child: Center(
                                child: Text(
                                  widget.videoModel.category,
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 3 / 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 2 / 100),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.width * 2 / 100),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.videoModel.uploaderPfp,
                      ),
                      radius: screenSize.width * 6 / 100,
                    ),
                    title: Text(
                      widget.videoModel.uploaderName,
                      maxLines: 1,
                    ),
                    titleTextStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: screenSize.width * 4 / 100,
                    ),
                    trailing: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber)),
                      child: const Text(
                        'View all videos',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('videos')
                  .doc(widget.videoModel.videoId.toString())
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                if (snapshot.hasData) {
                  final List<dynamic> comments = snapshot.data!['comments'];
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (_, i) {
                      final data = comments[i];

                      return SizedBox(
                        height: 50,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['pfp'],
                            ),
                            radius: screenSize.width * 4 / 100,
                          ),
                        ),
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
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.amber)),
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.all(
            screenSize.width * 2 / 100,
          ),
          child: const Text(
            'Explore',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
