// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/utils/utils.dart';

class InfoScreen extends StatelessWidget {
  final UserModel userModel;
  const InfoScreen({
    super.key,
    required this.userModel,
  });
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.mobile_friendly_rounded),
              title: const Text(
                'Device Compatibility',
                maxLines: 1,
              ),
              titleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenSize.width * 4 / 100,
              ),
              subtitle: const Text('Android version 13 or higher is required.'),
              subtitleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
                fontSize: screenSize.width * 3.5 / 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 5 / 100,
                  vertical: screenSize.width * 5 / 100),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: screenSize.width * 4 / 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  userModel.pfp,
                ),
                radius: screenSize.width * 6 / 100,
              ),
              title: Text(
                userModel.name,
                maxLines: 1,
              ),
              titleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenSize.width * 4 / 100,
              ),
              subtitle: Text(userModel.phoneNumber),
              subtitleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
                fontSize: screenSize.width * 3.5 / 100,
              ),
              trailing: IconButton(
                onPressed: () async {
                  SharedPreferences s = await SharedPreferences.getInstance();
                  if (await s.clear()) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'phone', (route) => false);
                  } else {
                    showSnackBar(
                        context, 'Failed to log out user, try again later');
                  }
                },
                icon: const Icon(
                  Icons.logout_rounded,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 5 / 100,
                  vertical: screenSize.width * 5 / 100),
              child: Text(
                'Contact developer',
                style: TextStyle(
                  fontSize: screenSize.width * 4 / 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/logos/linked_in.png',
                height: screenSize.width * 10 / 100,
              ),
              title: const Text(
                'Onkar Sagare',
                maxLines: 1,
              ),
              titleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenSize.width * 4 / 100,
              ),
              subtitle: const Text('Linked In'),
              subtitleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
                fontSize: screenSize.width * 3.5 / 100,
              ),
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://www.linkedin.com/in/onkar-sagare-9a68aa251/');
                await launchUrl(url,
                    mode: LaunchMode.externalNonBrowserApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}
