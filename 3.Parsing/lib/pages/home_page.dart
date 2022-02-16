import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/models/post_model.dart';
import 'package:image/services/http_service.dart';
import 'package:image/services/log_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      print(response!),
      _showResponse(response),
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isLoading ? const Center(child: CircularProgressIndicator.adaptive()) : Container(),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index){
                  return _listTile(posts[index]);
                },
              ),
            ],
          )
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {

        },

      ),
    );
  }

  Widget _listTile(Post post){
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
        title: Text(post.title!, overflow: TextOverflow.ellipsis, softWrap: true),
        leading: SizedBox(
          width: 54,
            child: CachedNetworkImage(
              imageUrl: '${post.thumbnailUrl}',
              placeholder: (context, url) => const Image(image: AssetImage('assets/images/img.png')),
              errorWidget: (context, url, error) => const Image(image: AssetImage('assets/images/img_1.png')),
            ),

            // Image.network('${post.thumbnailUrl}')
        ),
    );
  }


}
