import 'dart:convert';
import 'package:dummy_api/models/employee_list_parse.dart';
import 'package:dummy_api/models/model.dart';
import 'package:dummy_api/models/post_parse.dart';
import 'package:dummy_api/models/single_employee_parse.dart';
import 'package:http/http.dart';

class Network{
  static bool isTester = true;

  /// Base URL
  static String SERVER_DEVELOPMENT = 'dummy.restapiexample.com';
  static String SERVER_PRODUCTION = 'dummy.restapiexample.com';

  /// Server
  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /// Headers
  static Map<String, String> getHeaders() {
    Map<String,String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    // {
    //   'Content-type': 'application/json; charset=UTF-8'
    // };
    return headers;
  }

  /// Http APIs
  static String API_GET_LIST = '/api/v1/employees';
  static String API_GET = '/api/v1/employee/'; // {id}
  static String API_POST = '/api/v1/create';
  static String API_PUT = '/api/v1/update/'; // {id}
  static String API_DELETE = '/api/v1/delete/'; // {id}

  /// Http Requests Methods
  static Future<String?> GET(String api, Map<String, String> params) async{
    var uri = Uri.http(getServer(),  api, params);  // http or https -> depends on api
    Response response = await get(uri, headers: getHeaders());
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }
  static Future<String?> POST(String api, Map<String, String> body) async{
    var uri = Uri.http(getServer(), api);  // http or https -> depends on api
    Response response = await post(uri, headers: getHeaders(), body: jsonEncode(body)); // body
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }
    return null;
  }
  static Future<String?> PUT(String api, Map<String, String> body) async{
    var uri = Uri.http(getServer(), api);  // http or https -> depends on api
    Response response = await put(uri, headers: getHeaders(), body: jsonEncode(body));
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }
  static Future<String?> DELETE(String api, Map<String, String> params) async{
    var uri = Uri.http(getServer(), api, params);  // http or https -> depends on api
    Response response = await delete(uri, headers: getHeaders());
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  /// Http Parameters
  static Map<String, String> paramsEmpty(){
    Map<String, String> params = {};
    return params;
  }

  /// Http Bodies
  static Map<String, String> POSTbody(Employee employee){
    Map<String, String> body = {};
    body.addAll({
      'name' : employee.employeeName,
      'salary' : employee.employeeSalary,
      'age' : employee.employeeAge,
    });
    return body;
  }
  static Map<String, String> PUTbody(Employee employee){
    Map<String, String> body = {};
    body.addAll({
      'name' : employee.employeeName,
      'salary' : employee.employeeSalary,
      'age' : employee.employeeAge,
    });
    return body;
  }

  /// Http Parsing
  // #get List
  static EmployeeListParsing parseEmployeeList(String response){
    dynamic json = jsonDecode(response);
    EmployeeListParsing data = EmployeeListParsing.fromJson(json);
    return data;
  }
  // #get one
  static SingleEmployeeParse parseEmployee(String response){
    dynamic json = jsonDecode(response);
    SingleEmployeeParse data = SingleEmployeeParse.fromJson(json);
    return data;
  }
  // #post one
  static PostEmployeeParse parsePostEmployee(String response){
    dynamic json = jsonDecode(response);
    PostEmployeeParse data = PostEmployeeParse.fromJson(json);
    return data;
  }
}