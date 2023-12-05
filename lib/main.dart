import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videxplore/firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videxplore/provider/auth_provider.dart';
import 'package:videxplore/screens/home_screen.dart';
import 'package:videxplore/screens/phone.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  bool _isSignedIn = false;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preffs = await SharedPreferences.getInstance();
  _isSignedIn = preffs.getBool('isSignedIn') ?? true;
  runApp(MyApp(isSignedIn: _isSignedIn));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;
  const MyApp({super.key, required this.isSignedIn});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (cont) => AuthenticationProvider())
      ],
      child: MaterialApp(
        title: 'VidExplore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: isSignedIn ? 'home' : 'phone',
        routes: {
          'phone': (context) => const PhoneScreen(),
          'home': (context) => const HomeScreen()
        },
      ),
    );
  }
}
