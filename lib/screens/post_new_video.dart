import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/provider/auth_provider.dart';
import 'package:videxplore/utils/utils.dart';
import 'package:videxplore/widgets/thumbainail_picker.dart';

class PostNewVideoScreen extends StatefulWidget {
  final XFile? file;
  final UserModel userModel;
  const PostNewVideoScreen(
      {super.key, required this.file, required this.userModel});

  @override
  State<PostNewVideoScreen> createState() => _PostNewVideoScreenState();
}

class _PostNewVideoScreenState extends State<PostNewVideoScreen> {
  bool _isLoading = true;
  bool _success = false;
  bool _isRetried = false;
  late String _location;
  String _selectedCategory = 'Category';
  final List<String> _locations = ['Nature', 'City', 'Desert', 'Jungle'];
  TextEditingController titleController = TextEditingController();
  File? thumbnail;
  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  void selectImage() async {
    thumbnail = await pickImage(context);
    setState(() {});
  }

  void loadLocation() async {
    _location = await getLocation(context);
    setState(() {
      _isLoading = false;
      _isRetried = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthenticationProvider>(context, listen: true).isLoading;
    Size screenSize = MediaQuery.of(context).size;
    if (_isRetried) {
      loadLocation();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Upload',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : _location != 'notFound'
              ? isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    )
                  : _success
                      ? SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenSize.width * 40 / 100,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: screenSize.width * 20 / 100,
                                ),
                                SizedBox(
                                  height: screenSize.width * 10 / 100,
                                ),
                                Text(
                                  'Upload Successful',
                                  style: TextStyle(
                                      fontSize: screenSize.width * 5 / 100,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: screenSize.width * 60 / 100,
                                ),
                                SizedBox(
                                  height: screenSize.width * 14 / 100,
                                  width: screenSize.width * 80 / 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Explore Videos',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenSize.width * 4 / 100,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 5 / 100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                SizedBox(
                                  height: screenSize.width * 10 / 100,
                                  child: Text(
                                    'Thumbnail',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 5 / 100,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                ThumbnailPicker(
                                  height: (screenSize.width / 16 * 9) -
                                      screenSize.width * 10 / 100,
                                  width: screenSize.width -
                                      screenSize.width * 10 / 100,
                                  onTap: () => selectImage(),
                                  child: thumbnail != null
                                      ? Image.file(
                                          thumbnail!,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.add_photo_alternate_rounded,
                                          size: 40,
                                          color: Colors.grey[600],
                                        ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                SizedBox(
                                  height: screenSize.width * 10 / 100,
                                  child: Text(
                                    'Title',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 5 / 100,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                SizedBox(
                                  width: screenSize.width -
                                      screenSize.width * 10 / 100,
                                  child: TextFormField(
                                    maxLines: 2,
                                    maxLength: 50,
                                    style: TextStyle(
                                      fontSize: screenSize.width * 4 / 100,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onChanged: (input) {
                                      setState(() {
                                        titleController.text = input;
                                      });
                                    },
                                    controller: titleController,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: screenSize.width * 4 / 100,
                                          horizontal: 20),
                                      hintText: 'Enter title',
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.normal),
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
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                SizedBox(
                                  height: screenSize.width * 10 / 100,
                                  child: Text(
                                    'Location',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 5 / 100,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  height: screenSize.width * 10 / 100,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 5 / 100),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on_rounded),
                                        SizedBox(
                                          width: screenSize.width * 2 / 100,
                                        ),
                                        Text(
                                          _location,
                                          maxLines: 3,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenSize.width * 3 / 100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 2 / 100,
                                ),
                                SizedBox(
                                  width: screenSize.width * 30 / 100,
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.amber,
                                    elevation: 0,
                                    isExpanded: true,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    items: _locations.map((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      _selectedCategory,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onChanged: (newVal) {
                                      _selectedCategory = newVal!;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 20 / 100,
                                ),
                                SizedBox(
                                  height: screenSize.width * 14 / 100,
                                  width: screenSize.width * 80 / 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (thumbnail != null &&
                                          titleController.text.isNotEmpty &&
                                          _selectedCategory != 'Category' &&
                                          widget.file != null) {
                                        storeVideo();
                                      } else {
                                        if (thumbnail == null) {
                                          showSnackBar(context,
                                              'Thumbnail is required.');
                                        } else if (titleController
                                            .text.isEmpty) {
                                          showSnackBar(
                                              context, 'Title is required.');
                                        } else if (_selectedCategory ==
                                            'Category') {
                                          showSnackBar(
                                              context, 'Category is required.');
                                        } else {
                                          showSnackBar(
                                              context, 'Something went wrong');
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Upload',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenSize.width * 4 / 100,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 10 / 100,
                                ),
                              ],
                            ),
                          ),
                        )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wrong_location_rounded,
                        color: Colors.grey[400],
                        size: screenSize.width * 15 / 100,
                      ),
                      SizedBox(
                        height: screenSize.width * 6 / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 5 / 100),
                        child: Text(
                          'We are having trouble while fetching your current location, please turn on device location.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 6 / 100,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber)),
                        onPressed: () {
                          setState(
                            () {
                              _isLoading = true;
                              _isRetried = true;
                            },
                          );
                        },
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  void storeVideo() async {
    final authPro = Provider.of<AuthenticationProvider>(context, listen: false);
    VideoModel videoModel = VideoModel(
      title: titleController.text.toString(),
      file: widget.file,
      videoId: "",
      uploaderName: "",
      uploaderPfp: "",
      views: [],
      category: _selectedCategory,
      location: _location,
      postedTimeStamp: DateTime.now().millisecondsSinceEpoch,
      uploaderUid: '',
      videoUrl: "",
      thumbnail: thumbnail,
      likes: [],
      dislikes: [],
      comments: [],
    );
    authPro.uploadVideo(
      userModel: widget.userModel,
      context: context,
      videoModel: videoModel,
      onSuccess: () {
        setState(() {
          _success = true;
        });
      },
    );
  }
}
