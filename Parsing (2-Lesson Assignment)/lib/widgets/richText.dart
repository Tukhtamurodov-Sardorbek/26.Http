import 'package:flutter/material.dart';

Widget employeeDetailsRichText(int id, String name, String salary, String age, Color  color){
  return RichText(
    text: TextSpan(
        text: 'ID: ',
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        children: [
          TextSpan(
            text: id.toString(),
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const TextSpan(
            text: '\nName: ',
          ),
          TextSpan(
            text: name,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const TextSpan(
            text: '\nSalary: ',
          ),
          TextSpan(
            text: '\$' + salary,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const TextSpan(
            text: '\nAge: ',
          ),
          TextSpan(
            text: age,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ]
    ),
  );
}