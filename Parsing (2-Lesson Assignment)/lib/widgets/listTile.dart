import 'package:dummy_api/models/employees_list_element_parse.dart';
import 'package:flutter/material.dart';

Widget employeeInfoListTile(EmployeeParsing? employee) {
  return employee != null
      ? ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('${employee.name} (ID: ${employee.id})'),
          subtitle: Text(
              'Salary: \$${employee.salary.toString()} \t Age: ${employee.age.toString()} years old'),
        )
      : SizedBox();
}
