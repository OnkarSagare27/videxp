import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/screens/otp_screen.dart';
import 'package:videxplore/utils/utils.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseSotage = FirebaseStorage.instance;

  AuthenticationProvider() {
    checkSignedIn();
  }

  void checkSignedIn() async {
    final SharedPreferences preffs = await SharedPreferences.getInstance();
    _isSignedIn = preffs.getBool('isSignedin') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences preffs = await SharedPreferences.getInstance();
    await preffs.setBool("isSignedIn", true);
    _isSignedIn = true;
    notifyListeners();
  }

  static Future<bool> get statusIsSingedIn async {
    final SharedPreferences preffs = await SharedPreferences.getInstance();
    bool status = preffs.getBool('isSignedIn') ?? false;
    return status;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          showSnackBar(context, error.message.toString());
        },
        codeSent: (verificationId, forcedResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpScreen(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (veridicationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> userExist() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      SharedPreferences preffs = await SharedPreferences.getInstance();
      _userModel = UserModel(
        name: snapshot.get('name'),
        uid: snapshot.get('uid'),
        pfp: snapshot.get('pfp'),
        phoneNumber: snapshot.get('phoneNumber'),
      );
      await preffs.setString('userModel', jsonEncode(userModel.toMap()));
      setSignIn();
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      print("USER DOES NOT EXIST");
      return false;
    }
  }

  void saveUser({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await storeFileToSotage("profilePic$_uid", profilePic).then((value) {
        print(value);
        userModel.pfp = value;
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.uid;
      });
      _userModel = userModel;
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToSotage(String ref, File file) async {
    print(file);
    UploadTask uploadTask = _firebaseSotage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future saveUserLocally() async {
    SharedPreferences preffs = await SharedPreferences.getInstance();
    await preffs.setString("userModel", jsonEncode(userModel.toMap()));
  }
}
