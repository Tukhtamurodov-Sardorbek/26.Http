import 'package:dummy_api/models/employees_list_element_parse.dart';

class SingleEmployeeParse{
  String? status;
  String? message;
  EmployeeParsing? data;

  SingleEmployeeParse();

  SingleEmployeeParse.fromJson(Map<String, dynamic> json)
    : status = json['status'],
      message = json['message'],
      data = EmployeeParsing.fromJson(json['data']);

  Map<String, dynamic> toJson()=>{
    'status' : status,
    'message' : message,
    'data' : data!.toJson()
  };
}