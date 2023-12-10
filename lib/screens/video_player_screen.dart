// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/screens/comment_screen.dart';
import 'package:videxplore/screens/home_screen.dart';
import 'package:videxplore/screens/search_screen.dart';
import 'package:videxplore/screens/view_all_videos_screen.dart';
import 'package:videxplore/utils/utils.dart';
import 'package:videxplore/widgets/vid_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel videoModel;
  final UserModel userModel;
  const VideoPlayerScreen({
    super.key,
    required this.videoModel,
    required this.userModel,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  String _selectedCategory = 'Category';
  final List<String> _category = [
    'Gaming',
    'Programming',
    'Vacation',
    'Hiking',
    'Movie',
    'Other'
  ];
  TextEditingController searchController = TextEditingController();
  bool _commentBox = false;
  double keb = 30;
  @override
  void initState() {
    updateViews();
    super.initState();
  }

  void toggleCommentBox() {
    _commentBox = !_commentBox;
    setState(() {});
  }

  void updateViews() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.videoModel.videoId)
        .get();
    List<dynamic> views = snapshot.get('views');
    if (!views.contains(widget.userModel.uid)) {
      views.add(widget.userModel.uid);
      var collection = FirebaseFirestore.instance.collection('videos');
      collection
          .doc(widget.videoModel.videoId)
          .update({'views': views})
          .then((_) => widget.videoModel.views = views)
          .catchError(
            (error) => showSnackBar(context, 'Error while updating views'),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                width: screenSize.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 5 / 100,
                      vertical: screenSize.width * 2 / 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenSize.width * 70 / 100,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: screenSize.width * 4 / 100,
                              fontWeight: FontWeight.normal),
                          onChanged: (input) {
                            setState(() {
                              searchController.text = input;
                            });
                          },
                          controller: searchController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenSize.width * 4 / 100,
                                horizontal: screenSize.width * 4 / 100),
                            hintText: 'Search',
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.normal),
                            fillColor: Colors.grey[300],
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            suffixIcon: SizedBox(
                              width: screenSize.width * 20 / 100,
                              child: DropdownButton<String>(
                                dropdownColor: Colors.amber,
                                elevation: 0,
                                isExpanded: true,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                items: _category.map((String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                                icon: Padding(
                                  padding: EdgeInsets.only(
                                      right: screenSize.width * 3 / 100),
                                  child: const Icon(Icons.filter_alt_rounded),
                                ),
                                underline: const SizedBox(),
                                hint: const SizedBox(),
                                onChanged: (newVal) {
                                  _selectedCategory = newVal!;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (searchController.text.isNotEmpty ||
                              _selectedCategory != 'Category') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResultScreen(
                                  category: _selectedCategory,
                                  userModel: widget.userModel,
                                  searchString:
                                      searchController.text.toString(),
                                ),
                              ),
                            );

                            setState(() {});
                          } else {
                            showSnackBar(context, 'Search by filter or title');
                          }
                        },
                        icon: Icon(
                          Icons.search_rounded,
                          size: screenSize.width * 8 / 100,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              VideoPlayerView(
                dataSourceType: DataSourceType.network,
                url: widget.videoModel.videoUrl,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        screenSize.width * 3 / 100,
                      ),
                      child: Text(
                        widget.videoModel.title,
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
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.amber)),
                          onPressed: () async {
                            DocumentSnapshot snapshot = await FirebaseFirestore
                                .instance
                                .collection('videos')
                                .doc(widget.videoModel.videoId)
                                .get();
                            List<dynamic> likes = snapshot.get('likes');
                            List<dynamic> dislikes = snapshot.get('dislikes');

                            var vidData =
                                FirebaseFirestore.instance.collection('videos');
                            vidData
                                .doc(widget.videoModel.videoId)
                                .update(likes.remove(widget.userModel.uid)
                                    ? {"likes": likes}
                                    : dislikes.remove(widget.userModel.uid)
                                        ? {
                                            "likes": likes
                                              ..add(widget.userModel.uid),
                                            "dislikes": dislikes
                                          }
                                        : {
                                            "likes": likes
                                              ..add(widget.userModel.uid)
                                          })
                                .then((_) {
                              setState(() {
                                widget.videoModel.likes = likes;
                                widget.videoModel.dislikes = dislikes;
                              });
                            }).catchError(
                              (error) => showSnackBar(
                                context,
                                'Error while updating likes',
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_alt_rounded,
                                color: widget.videoModel.likes
                                        .contains(widget.userModel.uid)
                                    ? Colors.green
                                    : Colors.white,
                                size: screenSize.width * 5 / 100,
                              ),
                              SizedBox(
                                width: screenSize.width * 2 / 100,
                              ),
                              Text(
                                widget.videoModel.likes.length.toString(),
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
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.amber)),
                          onPressed: () async {
                            DocumentSnapshot snapshot = await FirebaseFirestore
                                .instance
                                .collection('videos')
                                .doc(widget.videoModel.videoId)
                                .get();
                            List<dynamic> dislikes = snapshot.get('dislikes');
                            List<dynamic> likes = snapshot.get('likes');

                            var vidData =
                                FirebaseFirestore.instance.collection('videos');
                            vidData
                                .doc(widget.videoModel.videoId)
                                .update(dislikes.remove(widget.userModel.uid)
                                    ? {"dislikes": dislikes}
                                    : likes.remove(widget.userModel.uid)
                                        ? {
                                            "dislikes": dislikes
                                              ..add(widget.userModel.uid),
                                            "likes": likes
                                          }
                                        : {
                                            "dislikes": dislikes
                                              ..add(widget.userModel.uid)
                                          })
                                .then((_) {
                              setState(() {
                                widget.videoModel.likes = likes;
                                widget.videoModel.dislikes = dislikes;
                              });
                            }).catchError(
                              (error) => showSnackBar(
                                context,
                                'Error while updating dislikes',
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.thumb_down_alt_rounded,
                                color: widget.videoModel.dislikes
                                        .contains(widget.userModel.uid)
                                    ? Colors.red
                                    : Colors.white,
                                size: screenSize.width * 5 / 100,
                              ),
                              SizedBox(
                                width: screenSize.width * 2 / 100,
                              ),
                              Text(
                                widget.videoModel.dislikes.length.toString(),
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
                                          widget.videoModel.views.length
                                              .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenSize.width * 3 / 100,
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
                                          widget.videoModel.postedTimeStamp
                                              .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenSize.width * 3 / 100,
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
                                            fontSize:
                                                screenSize.width * 3 / 100,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewAllVideosScreen(
                                      uploaderUid:
                                          widget.videoModel.uploaderUid,
                                      userModel: widget.userModel,
                                      uploaderName:
                                          widget.videoModel.uploaderName,
                                    ),
                                  ),
                                );
                              },
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentScreen(
                                            userModel: widget.userModel,
                                            videoModel: widget.videoModel,
                                          )),
                                );
                              },
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
                        if (snapshot.hasError) {
                          return Text('Error = ${snapshot.error}');
                        }

                        if (snapshot.hasData) {
                          final List<dynamic> comments =
                              snapshot.data!['comments'];

                          return SizedBox(
                            height: screenSize.width * 60 / 100,
                            child: ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, ind) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: screenSize.width * 10 / 100,
                                      right: screenSize.width * 5 / 100,
                                      top: screenSize.width * 2 / 100,
                                      bottom: comments.length - 1 == ind
                                          ? screenSize.width * 20 / 100
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
                                            fontSize:
                                                screenSize.width * 3 / 100,
                                            color: Colors.black,
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: screenSize.width * 1 / 100,
                                                bottom:
                                                    screenSize.width * 1 / 100),
                                            child: Text(comments[ind]
                                                ['commentContent']),
                                          ),
                                          subtitleTextStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                screenSize.width * 4 / 100,
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
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.amber)),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
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
