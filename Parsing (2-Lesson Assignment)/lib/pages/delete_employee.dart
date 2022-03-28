import 'package:dummy_api/services/http_service.dart';
import 'package:dummy_api/widgets/app_bar.dart';
import 'package:dummy_api/widgets/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class DELETEOne extends StatefulWidget {
  static const String id = '/delete_one';
  const DELETEOne({Key? key}) : super(key: key);

  @override
  State<DELETEOne> createState() => _DELETEOneState();
}

class _DELETEOneState extends State<DELETEOne> {
  final FocusNode _idFocusNode = FocusNode();
  final TextEditingController _idController = MaskedTextController(mask: "00");
  String originalResponse = '';
  String deletedResponse = '';

  // #get employee
  void _getID(String employeeId){
    _idFocusNode.unfocus();
    setState(() {
      originalResponse = '';
      deletedResponse = '';
    });
    try{
      int id = int.parse(employeeId);
      if(id < 1 || id > 24){
        snackBar(context, 'Enter valid ID number');
      }else{
        getAnEmployee(id);
      }
    }catch(e){
      snackBar(context, 'Enter valid ID number');
    }
  }
  void getAnEmployee(int id){
    Network.GET(Network.API_GET + id.toString(), Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response)
    });
  }
  void _showResponse(String? _response){
    if (kDebugMode) {
      print(_response);
    }
    setState(() {
      originalResponse = _response ?? 'Try again...';
    });
  }

  // #delete
  void deleteEmployee(){
    _idFocusNode.unfocus();
    Network.DELETE(Network.API_DELETE, Network.paramsEmpty()).then((response) => _showUpdatedResponse(response));
  }
  void _showUpdatedResponse(String? _response){
    if (kDebugMode) {
      print(_response);
    }
    setState(() {
      deletedResponse = _response ?? 'Something went wrong...';
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _idController.dispose();
    _idFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget('DELETE AN EMPLOYEE'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // #get employee id
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // #id number
                Row(
                  children: [
                    const Text('ID (1 - 24): ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemRed)),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 40,
                      width: 60,
                      child: TextField(
                        controller: _idController,
                        focusNode: _idFocusNode,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemRed),
                        decoration: InputDecoration(
                            label: const Text('ID', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: CupertinoColors.systemRed, width: 4)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: CupertinoColors.systemRed, width: 4)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: CupertinoColors.systemRed, width: 5)
                            )
                        ),
                        onSubmitted: (value){
                          _getID(_idController.text.toString().trim());
                        },
                      ),
                    ),
                  ],
                ),
                // #get button
                MaterialButton(
                  height: 40,
                  minWidth: 100,
                  color: CupertinoColors.systemRed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: const Text('GET', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: (){
                    _getID(_idController.text.toString().trim());
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text('Result', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemRed)),
            const SizedBox(height: 10),
            // #show respond
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemRed, width: 4),
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Center(child: Text(originalResponse, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 20),
            // #post button
            MaterialButton(
              height: 46,
              minWidth: MediaQuery.of(context).size.width,
              color: CupertinoColors.systemRed,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: const Text('DELETE EMPLOYEE', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              onPressed: originalResponse.isEmpty || originalResponse == 'Try again...'
                  ? (){}
                  : deleteEmployee,
            ),
            const SizedBox(height: 10),
            // #show result
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: CupertinoColors.systemRed, width: 4)
              ),
              child: Center(child: Text(deletedResponse, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            ),
          ],
        ),
      ),
    );
  }
}
