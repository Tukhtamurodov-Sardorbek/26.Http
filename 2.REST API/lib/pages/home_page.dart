import 'package:flutter/material.dart';
import 'package:rest_api/models/post_model.dart';
import 'package:rest_api/services/http_service.dart';
import 'package:rest_api/services/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = 'No data';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
    // var post = Post(id: 1,title: "PDP",body: "Online",userId: 1);
    // _apiPostCreate(post);
    // _apiPostUpdate(post);
    //_apiPostDelete(post);
  }

  void _apiPostList(){
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      Log.d(response!),
      _showResponse(response),
    });
  }

  void _apiPostCreate(Post post){
    Network.POST(Network.API_CREATE, Network.paramsCreate(post)).then((response) => {
      print(response!),
      _showResponse(response),
    });
  }

  void _apiPostUpdate(Post post){
    Network.PUT(Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post)).then((response) => {
      print(response!),
      _showResponse(response),
    });
  }

  void _apiPostDelete(Post post){
    Network.DELETE(Network.API_DELETE + post.id.toString(), Network.paramsEmpty()).then((response) => {
      print(response!),
      _showResponse(response),
    });
  }

  void _showResponse(String response){
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP Networking"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Text(data),
          ),
        ),
      ),
    );
  }
}
