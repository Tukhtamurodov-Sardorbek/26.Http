import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api/models/post_model.dart';
import 'package:rest_api/services/http_service.dart';
import 'package:rest_api/services/log_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String data = 'No data';
  List<Post> posts = [];

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
    setState(() {
      isLoading = true;
    });
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
      if(response != null){
        print('DELETED!'),
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('DELETED'),
          behavior: SnackBarBehavior.floating,
          width: 300,
        )
        )
      }
      else{
        print('NOT DELETED ...')
      }
    });
  }

  void _showResponse(String response){
    setState(() {
      data = response;
      posts = List<Post>.from(json.decode(data).map((x) => Post.fromJson(x)));
      setState(() {
        isLoading = false;
      });
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
          child: Stack(
            children: [
              isLoading ? const Center(child: CircularProgressIndicator.adaptive()) : Container(),
              ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index){
                  return _listTile(posts[index]);
                },
              ),
            ],
          )
      ),

    );
  }

  Widget _listTile(Post post){
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        dragDismissible: false,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (BuildContext context) {
              setState(() {
                _apiPostDelete(post);
                _apiPostList();
                // posts.remove(post);
              });
            },
          ),
        ],
      ),

      child: ListTile(
        title: Text(post.title!),
        subtitle: Text(post.body!),
      ),
    );
  }


}
