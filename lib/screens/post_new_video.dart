import 'package:flutter/material.dart';
import 'package:videxplore/utils/utils.dart';
import 'package:videxplore/widgets/thumbainail_picker.dart';

class PostNewVideoScreen extends StatefulWidget {
  const PostNewVideoScreen({super.key});

  @override
  State<PostNewVideoScreen> createState() => _PostNewVideoScreenState();
}

class _PostNewVideoScreenState extends State<PostNewVideoScreen> {
  bool _isLoading = true;
  late String _location;
  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  void loadLocation() async {
    _location = await getLocation(context);
    print(_location);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    loadLocation();

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
              ? const SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [ThumbnailPicker()],
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
                            setState(() {
                              _isLoading = true;
                            });
                          },
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
    );
  }
}
