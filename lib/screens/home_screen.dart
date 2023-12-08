// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videxplore/screens/explore_screen.dart';
import 'package:videxplore/screens/library_screen.dart';
import 'package:videxplore/screens/post_new_video.dart';
import 'package:videxplore/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  dynamic userModel = '';
  int _selectedIndex = 0;
  PageController controller = PageController();
  List<GButton> tabs = [];
  @override
  void initState() {
    super.initState();
    var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
    double gap = 10;

    tabs.add(GButton(
      gap: gap,
      iconActiveColor: Colors.amber,
      iconColor: Colors.white,
      textColor: Colors.amber,
      backgroundColor: Colors.white,
      iconSize: 24,
      padding: padding,
      icon: Icons.explore,
      text: "Explore",
    ));

    tabs.add(GButton(
      gap: gap,
      iconActiveColor: Colors.amber,
      iconColor: Colors.white,
      textColor: Colors.amber,
      backgroundColor: Colors.white,
      iconSize: 24,
      padding: padding,
      icon: Icons.video_library_rounded,
      text: 'Library',
    ));
  }

  Future<dynamic> fetch() async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    return preff.getString('userModel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return getScreen(index);
        },
        itemCount: tabs.length,
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: -10,
                        blurRadius: 60,
                        color: Colors.black.withOpacity(.20),
                        offset: const Offset(0, 15))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: GNav(
                    tabs: tabs,
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      controller.jumpToPage(index);
                    }),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
              child: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.videos,
                    Permission.camera,
                    Permission.locationWhenInUse,
                  ].request();
                  statuses.forEach(
                    (permission, status) {
                      if (status == PermissionStatus.denied) {
                        showSnackBar(
                            context, '${permission.toString()} is required');
                        openAppSettings();
                      } else if (status == PermissionStatus.granted) {}
                    },
                  );
                  final XFile? file = await _picker.pickVideo(
                      source: ImageSource.camera,
                      maxDuration: const Duration(seconds: 10));
                  if (file != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostNewVideoScreen(
                          file: file,
                        ),
                      ),
                    );
                  } else {
                    showSnackBar(context,
                        'Record a video of minimum duration of 1 second to upload.');
                  }
                },
                elevation: 0.0,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getScreen(int selectedIndex) {
    if (selectedIndex == 0) {
      return const ExploreScreen();
    } else if (selectedIndex == 1) {
      return const LibraryScreen();
    }
  }
}
