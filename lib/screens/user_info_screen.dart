import 'dart:io';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  File? pfp;
  final usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: pfp == null
                  ? CircleAvatar(
                      radius: screenSize.width * 15 / 100,
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: screenSize.width * 30 / 100,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(pfp!),
                      radius: screenSize.width * 30 / 100,
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: screenSize.width * 30 / 100,
                      ),
                    ),
            )
          ],
        )),
      )),
    );
  }
}
