import 'package:dummy_api/models/employee_list_parse.dart';
import 'package:dummy_api/models/employees_list_element_parse.dart';
import 'package:dummy_api/services/hive_service.dart';
import 'package:dummy_api/services/http_service.dart';
import 'package:dummy_api/widgets/app_bar.dart';
import 'package:dummy_api/widgets/listTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GETAll extends StatefulWidget {
  static const String id = '/get_all';
  const GETAll({Key? key}) : super(key: key);

  @override
  State<GETAll> createState() => _GETAllState();
}

class _GETAllState extends State<GETAll> {
  String response = '';
  List<EmployeeParsing> employees = [];

  void _getList(){
    Network.GET(Network.API_GET_LIST, Network.paramsEmpty()).then((response){
      _showResponse(response);
    });
  }
  void _showResponse(String? _response){
    if(_response == null && HiveService.box.containsKey('Employees')){
      setState(() {
        response = HiveService().loadListEmployees();
      });
      EmployeeListParsing employeesList = Network.parseEmployeeList(response);
      setState(() {
        employees = employeesList.data;
      });
      if (kDebugMode) {
        print(employeesList.data.length);
        print(employeesList.data.first.name);
      }
    }
    else if(_response != null){
      HiveService().storeListEmployees(_response);
      setState(() {
        response = _response;
      });
      EmployeeListParsing employeesList = Network.parseEmployeeList(response);
      setState(() {
        employees = employeesList.data;
      });
      if (kDebugMode) {
        print(employeesList.data.length);
        print(employeesList.data.first.name);
      }
    }
    else{
      print(_response);
    }
    // if(_response == null && HiveService.box.containsKey('Employees')){
    //   setState(() {
    //     response = HiveService().loadListEmployees();
    //   });
    // } else if(_response != null){
    //   setState(() {
    //     response = _response;
    //   });
    //   HiveService().storeListEmployees(_response);
    // }
    // else{
    //   setState(() {
    //     response = _response ?? 'No data';
    //   });
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBarWidget('GET ALL EMPLOYEES'),
            Container(
              height: kToolbarHeight + 20,
              alignment: Alignment.bottomRight,
              child: IconButton(
                splashRadius: 1,
                icon: const Icon(Icons.refresh, size: 30),
                onPressed: _getList,
                tooltip: 'Refresh',
              ),
            )
          ],
        ),
      ),
      body: employees.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index){
                   return employeeInfoListTile(employees[index]);
                },
             ),
          )
    );
  }
}
