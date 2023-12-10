import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
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
