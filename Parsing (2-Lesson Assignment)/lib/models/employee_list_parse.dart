import 'package:dummy_api/models/employees_list_element_parse.dart';
class EmployeeListParsing{
  String status;
  String message;
  List<EmployeeParsing> data;

  EmployeeListParsing.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = List<EmployeeParsing>.from(json['data'].map((employee) => EmployeeParsing.fromJson(employee)));

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'data' : List.from(data.map((employee) => employee.toJson()))
  };
}