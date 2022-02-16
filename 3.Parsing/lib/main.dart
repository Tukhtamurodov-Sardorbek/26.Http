import 'package:flutter/material.dart';
import 'package:image/pages/display_image.dart';
import 'package:image/pages/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        DisplayImage.id: (context) => const DisplayImage(),
      },
    );
  }
}
