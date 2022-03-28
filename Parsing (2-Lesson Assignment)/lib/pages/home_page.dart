import 'package:dummy_api/pages/delete_employee.dart';
import 'package:dummy_api/pages/get_all_employees.dart';
import 'package:dummy_api/pages/get_one_employee.dart';
import 'package:dummy_api/pages/post_employee.dart';
import 'package:dummy_api/pages/put_employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const[
          GETAll(),
          GETOne(),
          POSTOne(),
          PUTOne(),
          DELETEOne()
        ],
        onPageChanged: (index){
          setState(() {
            _currentPage = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentPage,
        activeColor: _currentPage == 0 || _currentPage == 1
            ? CupertinoColors.systemBlue
            : _currentPage == 2 || _currentPage == 3
            ? CupertinoColors.systemGreen
            : CupertinoColors.systemRed,
        items: const[
          BottomNavigationBarItem(label: 'GET All', icon: Icon(Icons.get_app_outlined, color: CupertinoColors.systemBlue)),
          BottomNavigationBarItem(label: 'GET One', icon: Icon(Icons.get_app_outlined, color: CupertinoColors.systemBlue)),
          BottomNavigationBarItem(label: 'POST', icon: Icon(Icons.upload_outlined, color: CupertinoColors.systemGreen)),
          BottomNavigationBarItem(label: 'PUT', icon: Icon(Icons.upload_outlined, color: CupertinoColors.systemGreen)),
          BottomNavigationBarItem(label: 'DELETE', icon: Icon(Icons.delete, color: CupertinoColors.systemRed)),
        ],
        onTap: (index){
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
