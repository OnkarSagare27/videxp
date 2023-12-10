import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/models/video_model.dart';
import 'package:videxplore/screens/search_screen.dart';
import 'package:videxplore/screens/settings_screen.dart';
import 'package:videxplore/utils/utils.dart';
import 'package:videxplore/widgets/video_tile.dart';

class ExploreScreen extends StatefulWidget {
  final UserModel? userModel;
  const ExploreScreen({super.key, required this.userModel});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'Clear filter';
  final List<String> _category = [
    'Clear filter',
    'Gaming',
    'Programming',
    'Vacation',
    'Hiking',
    'Movie',
    'Other'
  ];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenSize.width * 2 / 100),
            child: IconButton(
              tooltip: 'Info',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              ),
              icon: const Icon(
                Icons.info_outline_rounded,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: screenSize.width * 2 / 100,
              left: screenSize.width * 3 / 100,
              right: screenSize.width * 3 / 100,
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
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
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
                            _selectedCategory != 'Clear filter') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultScreen(
                                category: _selectedCategory,
                                userModel: widget.userModel!,
                                searchString: searchController.text.toString(),
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
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('videos').snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      VideoModel videoModel = VideoModel.fromMap(data);
                      return VideoTile(
                        videoModel: videoModel,
                        userModel: widget.userModel!,
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
    );
  }
}
