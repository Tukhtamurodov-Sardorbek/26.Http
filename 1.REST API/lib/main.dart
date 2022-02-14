import 'package:flutter/material.dart';
import 'package:rest_api/pages/home_page.dart';

void main() {
  runApp(const REST_API());
}

class REST_API extends StatelessWidget {
  const REST_API({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage()
      },
    );
  }
}
