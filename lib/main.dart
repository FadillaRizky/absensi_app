import 'package:absensi_app/absensi.dart';
import 'package:absensi_app/cuti.dart';
import 'package:absensi_app/home.dart';
import 'package:absensi_app/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'edit_profile.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(),
        '/absensi': (context) => Absensi(),
        '/cuti': (context) => Cuti(),
        '/profile': (context) => Profile(),
        '/editprofile': (context) => EditProfile(),

      },
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
