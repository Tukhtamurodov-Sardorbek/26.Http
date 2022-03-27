import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_requiest/models/post_model.dart';
import 'package:network_requiest/services/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = '';
  void _apiGETList(){
    Network.GET(Network.API_GET_LIST, Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response)
    });
  }
  void _apiPOST(Post post){
    Network.POST(Network.API_POST, Network.POSTbody(post)).then((response) =>
    {
      _showResponse(response)
    });
  }
  void _apiPUT(Post post){
    Network.PUT(Network.API_PUT + post.id.toString(), Network.PUTbody(post)).then((response) =>
    {
      _showResponse(response)
    });
  }
  void _apiDELETE(Post post){
    Network.DELETE(Network.API_DELETE + post.id.toString(), Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response)
    });
  }
  void _apiGET(Post post){
    Network.GET(Network.API_GET + post.id.toString(), Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response)
    });
  }

   void _showResponse(String? response){
    if (kDebugMode) {
      print(response);
    }
    setState(() {
      data = response ?? 'No data';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Post post = Post(id: 1, title: 'title', body: 'body', userId: 1);
    // _apiGETList();
    // _apiPOST(post);
    // _apiPUT(post);
    // _apiDELETE(post);
    _apiGET(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Text(data),
      ),
    );
  }
}
