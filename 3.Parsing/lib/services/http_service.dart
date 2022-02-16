import 'dart:convert';
import 'package:http/http.dart';
import 'package:image/models/post_model.dart';
import 'log_service.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "jsonplaceholder.typicode.com";
  static String SERVER_PRODUCTION = "jsonplaceholder.typicode.com";

  static Map<String, String> getHeaders() {
    Map<String,String> headers = {'Content-Type':'application/json; charset=UTF-8'};
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response = await post(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200 || response.statusCode == 201)
      return response.body;
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response = await put(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response = await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> DELETE(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  /* Http Apis */
  static String API_LIST = "/photos";
  static String API_CREATE = "/photos";
  static String API_UPDATE = "/photos/"; //{id}
  static String API_DELETE = "/photos/"; //{id}

  /* Http Params */
  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> params = {};
    return params;
  }

  static Map<String, dynamic> paramsCreate(Post post) {
    Map<String, dynamic> params = {};
    params.addAll({
      'albumId': post.albumId,
      'title': post.title,
      'url': post.url,
      'thumbnailUrl': post.thumbnailUrl,
    });
    return params;
  }

  static Map<String, dynamic> paramsUpdate(Post post) {
    Map<String, dynamic> params = {};
    params.addAll({
      'id': post.id,
      'albumId': post.albumId,
      'title': post.title,
      'url': post.url,
      'thumbnailUrl': post.thumbnailUrl,
    });
    return params;
  }
}
