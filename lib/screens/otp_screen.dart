import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:videxplore/provider/auth_provider.dart';
import 'package:videxplore/screens/home_screen.dart';
import 'package:videxplore/screens/phone_verification_screen.dart';
import 'package:videxplore/screens/user_info_screen.dart';
import 'package:videxplore/utils/utils.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otp;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthenticationProvider>(context, listen: true).isLoading;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenSize.width * 10 / 100,
                      ),
                      SizedBox(
                        height: screenSize.width * 60 / 100,
                        width: screenSize.width * 60 / 100,
                        child: Image.asset('assets/logos/otp_main.png'),
                      ),
                      SizedBox(
                        height: screenSize.width * 6 / 100,
                        width: screenSize.width * 6 / 100,
                      ),
                      Text(
                        'Enter OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenSize.width * 6 / 100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 6 / 100,
                        width: screenSize.width * 6 / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 4 / 100),
                        child: Text(
                          'Enter the OTP sent on your phone number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenSize.width * 4 / 100,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 10 / 100,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: screenSize.width * 12 / 100,
                          height: screenSize.width * 12 / 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          textStyle: TextStyle(
                            fontSize: screenSize.width * 4 / 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otp = value;
                          });
                        },
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
                          onPressed: () => otp != null
                              ? verifyOtp(context, otp!)
                              : showSnackBar(
                                  context,
                                  'Enter the 6 digit OTP sent on your phone number',
                                ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 4 / 100,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 10 / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 4 / 100),
                        child: Text(
                          "Didn't receive any code?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenSize.width * 3 / 100,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 4 / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 4 / 100),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PhoneScreen()));
                          },
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: screenSize.width * 4 / 100,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 5 / 100,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final authPro = Provider.of<AuthenticationProvider>(context, listen: false);
    authPro.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        authPro.userExist().then(
          (value) async {
            if (value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInfoScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
