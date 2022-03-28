import 'package:flutter/material.dart';

Widget AppBarWidget(String _title){
  return AppBar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    title: Text(_title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    centerTitle: true
  );
}