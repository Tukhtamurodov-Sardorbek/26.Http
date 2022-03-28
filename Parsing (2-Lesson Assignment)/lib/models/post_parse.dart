import 'package:dummy_api/models/employees_list_element_parse.dart';

class PostEmployeeParse{
  String? status;
  String? message;
  PostEmployeeParsing? data;

  PostEmployeeParse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = PostEmployeeParsing.fromJson(json['data']);

  Map<String, dynamic> toJson()=>{
    'status' : status,
    'message' : message,
    'data' : data!.toJson()
  };
}

class PostEmployeeParsing{
  int? id;
  String? name;
  String? salary;
  String? age;

  PostEmployeeParsing();

  PostEmployeeParsing.fromJson(Map<String, dynamic> json)
      : id = json['id'] is int ? json["id"] : int.parse(json["id"]),
        name = json['name'],
        salary = json['salary'],
        age = json['age'];


  Map<String, dynamic> toJson() => {
    'name' : name,
    'salary' : salary,
    'age' : age,
  };
}