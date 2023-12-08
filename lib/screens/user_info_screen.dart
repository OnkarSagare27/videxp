import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videxplore/models/user_model.dart';
import 'package:videxplore/provider/auth_provider.dart';
import 'package:videxplore/screens/home_screen.dart';
import 'package:videxplore/utils/utils.dart';

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

  void selectImage() async {
    pfp = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthenticationProvider>(context, listen: true).isLoading;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: isLoading == true
              ? const CircularProgressIndicator(
                  color: Colors.amber,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: screenSize.width * 10 / 100,
                    ),
                    Text(
                      'Create Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenSize.width * 6 / 100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.width * 10 / 100,
                    ),
                    InkWell(
                      onTap: () => selectImage(),
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
                              radius: screenSize.width * 15 / 100,
                              backgroundColor: Colors.amber,
                            ),
                    ),
                    SizedBox(
                      height: screenSize.width * 10 / 100,
                    ),
                    SizedBox(
                      width: screenSize.width * 80 / 100,
                      child: TextFormField(
                        maxLength: 10,
                        style: TextStyle(
                            fontSize: screenSize.width * 4 / 100,
                            fontWeight: FontWeight.normal),
                        onChanged: (input) {
                          setState(() {
                            usernameController.text = input;
                          });
                        },
                        controller: usernameController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.width * 4 / 100,
                          ),
                          hintText: 'Enter name',
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.normal),
                          prefixIcon: const Icon(Icons.person),
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
                          suffixIcon: usernameController.text.length > 9
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: screenSize.width * 6 / 100,
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.width * 10 / 100,
                    ),
                    SizedBox(
                      height: screenSize.width * 14 / 100,
                      width: screenSize.width * 80 / 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () => storeData(),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 4 / 100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      )),
    );
  }

  void storeData() async {
    final authPro = Provider.of<AuthenticationProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: usernameController.text.toString(),
        uid: "",
        pfp: "",
        phoneNumber: "");
    if (pfp != null) {
      authPro.saveUser(
          context: context,
          userModel: userModel,
          profilePic: pfp!,
          onSuccess: () {
            authPro.saveUserLocally().then(
                  (value) => authPro.setSignIn().then(
                        (value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false),
                      ),
                );
          });
    } else {
      showSnackBar(context, "Please upload a profile picture");
    }
  }
}
