import 'dart:convert';
import 'package:dummy_api/models/employee_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static String DB_NAME = 'database';
  static Box box = Hive.box(DB_NAME);

  /// FOR A STRING
  Future<void> storeListEmployees (String employees) async {
    box.put('Employees', employees);
  }
  String loadListEmployees(){
    if(box.containsKey('Employees')){
      String employees = box.get('Employees');
      return employees;
    }
    return 'No data';
  }
  Future<void> removeListEmployees() async {
    box.delete('Employees');
  }

  /// FOR A LIST
  Future<void> storeEmployeesHistory (List<String> employees) async {
    await box.put('employeesSet', employees);
  }

  List<String> loadEmployee(){
    if(box.containsKey('employeesSet')){
      List<String> employees = box.get('employeesSet');
      return employees;
    }
    return <String>[];
  }

  Future<void> removeEmployees() async {
    await box.delete('employeesSet');
  }
}