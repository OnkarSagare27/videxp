// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    var status = await Permission.photos.request();
    if (status.isGranted) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return image;
}

Future<String> getLocation(BuildContext context) async {
  String city;
  String state;
  String country;
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      city = placemark.locality != null ? '${placemark.locality},' : '';
      state = placemark.administrativeArea != null
          ? ' ${placemark.administrativeArea},'
          : '';
      country = placemark.country != null ? ' ${placemark.country}' : '';
      return city + state + country;
    }
    return 'notFound';
  } catch (e) {
    showSnackBar(context, e.toString());
    return 'notFound';
  }
}

String formatTimeAgo(int millisecondsSinceEpoch) {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final timeDifference = currentTime - millisecondsSinceEpoch;

  if (timeDifference < 0) {
    return 'In the future';
  } else if (timeDifference < 1000) {
    return 'Just now';
  } else if (timeDifference < 60 * 1000) {
    final seconds = (timeDifference / 1000).floor();
    return '$seconds ${seconds == 1 ? 'second' : 'seconds'} ago';
  } else if (timeDifference < 60 * 60 * 1000) {
    final minutes = (timeDifference / (60 * 1000)).floor();
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (timeDifference < 24 * 60 * 60 * 1000) {
    final hours = (timeDifference / (60 * 60 * 1000)).floor();
    return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
  } else if (timeDifference < 7 * 24 * 60 * 60 * 1000) {
    final days = (timeDifference / (24 * 60 * 60 * 1000)).floor();
    return '$days ${days == 1 ? 'day' : 'days'} ago';
  } else if (timeDifference < 30 * 24 * 60 * 60 * 1000) {
    final weeks = (timeDifference / (7 * 24 * 60 * 60 * 1000)).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else if (timeDifference < 365 * 24 * 60 * 60 * 1000) {
    final months = (timeDifference / (30 * 24 * 60 * 60 * 1000)).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else {
    final years = (timeDifference / (365 * 24 * 60 * 60 * 1000)).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  }
}
