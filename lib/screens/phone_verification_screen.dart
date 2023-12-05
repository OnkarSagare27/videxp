import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videxplore/provider/auth_provider.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController _inputcontroller = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
                  child: Image.asset('assets/logos/login_main.png'),
                ),
                SizedBox(
                  height: screenSize.width * 6 / 100,
                  width: screenSize.width * 6 / 100,
                ),
                Text(
                  'Phone Verification',
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
                    'We need to verify your phone number before proceeding',
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
                SizedBox(
                  width: screenSize.width * 80 / 100,
                  child: TextField(
                    maxLength: 10,
                    style: TextStyle(
                        fontSize: screenSize.width * 4 / 100,
                        fontWeight: FontWeight.normal),
                    onChanged: (input) {
                      setState(() {
                        _inputcontroller.text = input;
                      });
                    },
                    controller: _inputcontroller,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenSize.width * 4 / 100,
                      ),
                      hintText: 'Enter number',
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(screenSize.width * 2 / 100),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  searchTextStyle: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                  inputDecoration: const InputDecoration(
                                    labelText: "Search country",
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  bottomSheetHeight:
                                      screenSize.height * 80 / 100,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.all(screenSize.width * 2 / 100),
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: TextStyle(
                                fontSize: screenSize.width * 4 / 100,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      suffixIcon: _inputcontroller.text.length > 9
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
                    onPressed: () => sendPhoneNumber(),
                    child: Text(
                      'Get OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width * 4 / 100,
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

  void sendPhoneNumber() {
    final authPro = Provider.of<AuthenticationProvider>(context, listen: false);
    String phoneNumber = _inputcontroller.text.trim();
    authPro.signInWithPhone(
        context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
