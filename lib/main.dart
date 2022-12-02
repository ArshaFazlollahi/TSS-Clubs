import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tss_clubs/pages/admin_home.dart';
import 'package:tss_clubs/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //debugPrint("object");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? admin = false;
  bool statechanged = false;

  Future<bool> _getboolfromsharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    final adminc = prefs.getBool('admin');
    if (!statechanged) {
      setState(() {
        admin = adminc;
        statechanged = true;
      });
    }
    if (adminc == null) {
      return false;
    }
    return adminc;
  }

  @override
  Widget build(BuildContext context) {
    _getboolfromsharedpref();
    if (admin ?? false) {
      debugPrint("oomad tooye true");
      return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminHome(),
      );
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      );
    }
  }
}
