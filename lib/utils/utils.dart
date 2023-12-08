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
