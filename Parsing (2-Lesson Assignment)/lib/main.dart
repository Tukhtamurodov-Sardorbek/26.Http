import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dummy_api/pages/home_page.dart';
import 'package:dummy_api/pages/put_employee.dart';
import 'package:dummy_api/pages/post_employee.dart';
import 'package:dummy_api/pages/delete_employee.dart';
import 'package:dummy_api/services/hive_service.dart';
import 'package:dummy_api/pages/get_one_employee.dart';
import 'package:dummy_api/pages/get_all_employees.dart';


void main() async{
  await Hive.initFlutter();
  await Hive.openBox(HiveService.DB_NAME);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        GETAll.id: (context) => const GETAll(),
        GETOne.id: (context) => const GETOne(),
        POSTOne.id: (context) => const POSTOne(),
        PUTOne.id: (context) => const PUTOne(),
        DELETEOne.id: (context) => const DELETEOne(),
      },
    );
  }
}