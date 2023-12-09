import 'package:flutter/material.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/screens/video_player_screen.dart';

class VideoTile extends StatefulWidget {
  final VideoModel videoModel;
  final UserModel userModel;
  const VideoTile({
    super.key,
    required this.videoModel,
    required this.userModel,
  });

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(
        screenSize.width * 2 / 100,
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              userModel: widget.userModel,
              videoModel: widget.videoModel,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.grey[300],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  screenSize.width * 2 / 100,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    height: (screenSize.width / 16 * 9) -
                        screenSize.width * 6 / 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.videoModel.thumbnail,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenSize.width * 2 / 100),
                child: ListTile(
                  dense: false,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.videoModel.uploaderPfp,
                    ),
                    radius: screenSize.width * 6 / 100,
                  ),
                  title: Text(
                    widget.videoModel.title,
                    maxLines: 2,
                  ),
                  titleTextStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: screenSize.width * 3.5 / 100,
                  ),
                  subtitle: Text(widget.videoModel.uploaderName),
                  subtitleTextStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                    fontSize: screenSize.width * 3 / 100,
                  ),
                  trailing: SizedBox(
                    width: screenSize.width * 40 / 100,
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenSize.width * 40 / 100,
                          height: screenSize.width * 6 / 100,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              color: Colors.white,
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
                                    Icons.location_on_rounded,
                                    size: screenSize.width * 3 / 100,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 1 / 100,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 30 / 100,
                                    child: Center(
                                      child: Text(
                                        widget.videoModel.location,
                                        maxLines: 1,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width * 2 / 100,
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
                          height: screenSize.width * 1 / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenSize.width * 13 / 100,
                              height: screenSize.width * 6 / 100,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 2 / 100,
                                    vertical: screenSize.width * 1 / 100,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_rounded,
                                        size: screenSize.width * 3 / 100,
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 1 / 100,
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 5 / 100,
                                        child: Center(
                                          child: Text(
                                            widget.videoModel.views.length
                                                .toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  screenSize.width * 2 / 100,
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
                              width: screenSize.width * 25 / 100,
                              height: screenSize.width * 6 / 100,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  color: Colors.white,
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
                                        size: screenSize.width * 3 / 100,
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 1 / 100,
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 16 / 100,
                                        child: Center(
                                          child: Text(
                                            widget.videoModel.category,
                                            maxLines: 1,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  screenSize.width * 2 / 100,
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
