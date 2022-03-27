import 'dart:convert';
import 'package:http/http.dart';
import 'package:network_requiest/models/post_model.dart';

class Network{
  static bool isTester = true;

  /// Base URL
  static String SERVER_DEVELOPMENT = 'jsonplaceholder.typicode.com';
  static String SERVER_PRODUCTION = 'jsonplaceholder.typicode.com';

  /// Server
  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /// Headers
  static Map<String, String> getHeaders() {
    Map<String,String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    return headers;
  }

  /// Http APIs
  static String API_GET_LIST = '/posts';
  static String API_GET = '/posts/'; // {id}
  static String API_POST = '/posts';
  static String API_PUT = '/posts/'; // {id}
  static String API_PATCH = '/posts/';  // {id}
  static String API_DELETE = '/posts/'; // {id}

  /// Http Requests Methods
  static Future<String?> GET(String api, Map<String, String> params) async{
    var uri = Uri.https(getServer(), api, params);  // http or https -> depends on api
    Response response = await get(uri, headers: getHeaders());
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }
  static Future<String?> POST(String api, Map<String, String> body) async{
    var uri = Uri.https(getServer(), api);  // http or https -> depends on api
    Response response = await post(uri, headers: getHeaders(), body: jsonEncode(body)); // body
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }
    return null;
  }
  static Future<String?> PUT(String api, Map<String, String> body) async{
    var uri = Uri.https(getServer(), api);  // http or https -> depends on api
    Response response = await put(uri, headers: getHeaders(), body: jsonEncode(body));
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }
  static Future<String?> PATCH(String api, Map<String, String> body) async {
    var uri = Uri.https(getServer(), api);  // http or https -> depends on api
    Response response = await patch(uri, headers: getHeaders(), body: jsonEncode(body));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
  static Future<String?> DELETE(String api, Map<String, String> params) async{
    var uri = Uri.https(getServer(), api, params);  // http or https -> depends on api
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
  static Map<String, String> POSTbody(Post post){
    Map<String, String> params = {};
    params.addAll({
      'title' : post.title,
      'body' : post.body,
      'userId' : post.userId.toString()
    });
    return params;
  }
  static Map<String, String> PUTbody(Post post){
    Map<String, String> params = {};
    params.addAll({
      'id' : post.id.toString(),
      'title' : post.title,
      'body' : post.body,
      'userId' : post.userId.toString()
    });
    return params;
  }
  static Map<String, String> PATCHbody(String key, String value) {
    Map<String, String> map = {
      key: value,
    };
    return map;
  }
}
