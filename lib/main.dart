import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gogo_admin/firebase_options.dart';
import 'package:gogo_admin/ui/home_page.dart';
import 'package:gogo_admin/ui/screens/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('GoGoAdmin');
    setWindowMinSize(const Size(1300, 800));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system,
      home: FirebaseAuth.instance.currentUser != null
          ? const HomePage()
          : const LoginScreen(),
    );
  }
}
