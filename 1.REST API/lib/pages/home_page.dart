import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rest_api/models/todo_model.dart';
import 'package:rest_api/services/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = "No Data";

  @override
  void initState() {
    super.initState();
    apiGetTodoList();
  }

  /// GET
  void apiGetTodoList() {
    HttpService.GET(HttpService.API_GET_LIST, HttpService.paramEmpty()).then((value) {
      if(value != null) {
        getResponse(value);
      }
    });
  }
  /// POST
  void apiCreateTodo() {
    Todo todo = Todo(userId: 1, id: -1, title: "title", completed: true);
    HttpService.POST(HttpService.API_POST, HttpService.paramsCreate(todo)).then((value) {
      if(value != null) {
        if (kDebugMode) {
          print(value);
        }
        apiGetTodoList();
      } else {
        //error msg
      }
    });
  }
  /// PUT
  void apiUpdateTodo() {
    Todo todo = Todo(userId: 1, id: 55, title: "title", completed: true);
    HttpService.PUT(HttpService.API_PUT + todo.id.toString(), HttpService.paramsUpdate(todo)).then((value) {
      if(value != null) {
        if (kDebugMode) {
          print(value);
        }
        apiGetTodoList();
      } else {
        //error msg
      }
    });
  }
  /// PATCH
  void apiEditTodo() {
    Todo todo = Todo(userId: 1, id: 55, title: "title", completed: true);
    HttpService.PATCH(HttpService.API_PATCH + todo.id.toString(), HttpService.paramsEdit('title', "Flutter")).then((value) {
      if(value != null) {
        if (kDebugMode) {
          print(value);
        }
      } else {
        //error msg
      }
    });
  }
  /// DELETE
  void apiDeleteTodo() {
    Todo todo = Todo(userId: 1, id: 55, title: "title", completed: true);
    HttpService.DELETE(HttpService.API_DELETE + todo.id.toString(), HttpService.paramEmpty()).then((value) {
      if(value != null) {
        if (kDebugMode) {
          print(value);
        }
        apiGetTodoList();
      } else {
        //error msg
      }
    });
  }
  /// Update Value
  void getResponse(String response) {
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Text(data),
        ),
      ),
    );
  }
}
