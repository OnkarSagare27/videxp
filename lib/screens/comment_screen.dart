// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:videxplore/models/comment_model.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/utils/utils.dart';

class CommentScreen extends StatefulWidget {
  final VideoModel videoModel;
  final UserModel userModel;
  const CommentScreen({
    super.key,
    required this.videoModel,
    required this.userModel,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(
                screenSize.width * 3 / 100,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                width: screenSize.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 5 / 100,
                      vertical: screenSize.width * 5 / 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenSize.width * 70 / 100,
                        child: TextFormField(
                          maxLength: 80,
                          style: TextStyle(
                              fontSize: screenSize.width * 4 / 100,
                              fontWeight: FontWeight.normal),
                          onChanged: (input) {
                            setState(() {
                              commentContentController.text = input;
                            });
                          },
                          controller: commentContentController,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenSize.width * 4 / 100,
                            ),
                            hintText: 'Add your comment',
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.normal),
                            prefixIcon: const Icon(Icons.comment),
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
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 1 / 100),
                              child: SizedBox(
                                height: screenSize.width * 3 / 100,
                                width: screenSize.width * 3 / 100,
                                child: Center(
                                  child: Text(
                                    '${commentContentController.text.length}/80',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 3 / 100),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (commentContentController.text.isNotEmpty) {
                            CommentModel commentModel = CommentModel(
                              name: widget.userModel.name,
                              pfp: widget.userModel.pfp,
                              commentContent:
                                  commentContentController.text.toString(),
                            );
                            DocumentSnapshot snapshot = await FirebaseFirestore
                                .instance
                                .collection('videos')
                                .doc(widget.videoModel.videoId)
                                .get();
                            List<dynamic> comments = snapshot.get('comments');

                            var vidData =
                                FirebaseFirestore.instance.collection('videos');

                            vidData.doc(widget.videoModel.videoId).update({
                              "comments": comments
                                ..insert(0, commentModel.toMap())
                            }).then((_) {
                              setState(() {
                                widget.videoModel.comments = comments;
                                commentContentController.clear();
                              });
                            }).catchError(
                              (error) => showSnackBar(
                                context,
                                'Error while updating comments',
                              ),
                            );
                          } else {
                            showSnackBar(
                                context, 'Comment content cannot be empty');
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          size: screenSize.width * 8 / 100,
                        ),
                      )
                    ],
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
                                  fontSize: screenSize.width * 3 / 100,
                                  color: Colors.black,
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSize.width * 1 / 100,
                                      bottom: screenSize.width * 1 / 100),
                                  child: Text(comments[ind]['commentContent']),
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
                      },
                    ),
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
            'Back',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
