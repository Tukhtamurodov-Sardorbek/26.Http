import 'package:dummy_api/services/hive_service.dart';
import 'package:dummy_api/services/http_service.dart';
import 'package:dummy_api/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GETAll extends StatefulWidget {
  static const String id = '/get_all';
  const GETAll({Key? key}) : super(key: key);

  @override
  State<GETAll> createState() => _GETAllState();
}

class _GETAllState extends State<GETAll> {
  String response = '';
  void _getList(){
    Network.GET(Network.API_GET_LIST, Network.paramsEmpty()).then((response){
      _showResponse(response);
    });
  }
  void _showResponse(String? _response){
    print(_response);
    if(_response == null && HiveService.box.containsKey('Employees')){
      setState(() {
        response = HiveService().loadListEmployees();
      });
    } else if(_response != null){
      setState(() {
        response = _response;
      });
      HiveService().storeListEmployees(_response);
    }
    else{
      setState(() {
        response = _response ?? 'No data';
      });
    }
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
      body: response.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              physics: const BouncingScrollPhysics(),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CupertinoColors.systemBlue, width: 4)
                  ),
                  child: Center(child: Text(response, style: const TextStyle(color: Colors.black)))
              ),
         ),
    );
  }
}
