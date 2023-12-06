import 'package:flutter/material.dart';

class PostNewVideoScreen extends StatefulWidget {
  const PostNewVideoScreen({super.key});

  @override
  State<PostNewVideoScreen> createState() => _PostNewVideoScreenState();
}

class _PostNewVideoScreenState extends State<PostNewVideoScreen> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
