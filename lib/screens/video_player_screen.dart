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
                                  widget.videoModel.views.toString(),
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
              padding: EdgeInsets.all(screenSize.width * 3 / 100),
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 3 / 100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments',
                    style: TextStyle(
                        fontSize: screenSize.width * 4 / 100,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: IconButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber)),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                    ),
                  )
                ],
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
                  print(comments);
                  return Expanded(
                    child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, ind) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: screenSize.width * 10 / 100,
                              right: screenSize.width * 5 / 100,
                              top: screenSize.width * 2 / 100,
                              bottom: comments.length - 1 == ind
                                  ? screenSize.width * 10 / 100
                                  : screenSize.width * 5 / 100,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Center(
                                child: ListTile(
                                  isThreeLine: true,
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      comments[ind]['pfp'],
                                    ),
                                    radius: screenSize.width * 4 / 100,
                                  ),
                                  title: Text(comments[ind]['name']),
                                  titleTextStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenSize.width * 3 / 100,
                                    color: Colors.black,
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(
                                        top: screenSize.width * 1 / 100,
                                        bottom: screenSize.width * 1 / 100),
                                    child: Text(comments[ind]
                                            ['commentContent'] +
                                        ' The way it was recorded is great Linked it sjbhusjdgfyjsdgfjsdghjsdfgjskdgfjsgdkfhgk hbsdhsgjdgyh'),
                                  ),
                                  subtitleTextStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenSize.width * 4 / 100,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
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
        onPressed: () {
          Navigator.pop(context);
        },
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
