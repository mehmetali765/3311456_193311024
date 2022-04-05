import 'package:flutter/material.dart';
import 'package:design/screens/about_us_page.dart';
import 'package:design/screens/support_us_page.dart';
import 'package:design/screens/beginner_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const BeginnerPage(),
        "/about": (context) => const AboutUs(),
        "/support": (context) => const SupportUs()
      },
      title: 'Material App',
    );
  }
}
