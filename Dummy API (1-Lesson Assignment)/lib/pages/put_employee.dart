import 'package:dummy_api/models/employee_model.dart';
import 'package:dummy_api/services/http_service.dart';
import 'package:dummy_api/widgets/app_bar.dart';
import 'package:dummy_api/widgets/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class PUTOne extends StatefulWidget {
  static const String id = '/put_one';
  const PUTOne({Key? key}) : super(key: key);

  @override
  State<PUTOne> createState() => _PUTOneState();
}

class _PUTOneState extends State<PUTOne> {
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _salaryFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final TextEditingController _idController = MaskedTextController(mask: "00");
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String originalResponse = '';
  String updatedResponse = '';

  void _unfocusAll(){
    _idFocusNode.unfocus();
    _nameFocusNode.unfocus();
    _salaryFocusNode.unfocus();
    _ageFocusNode.unfocus();
  }

  // #get employee
  void _getID(String employeeId){
    _idFocusNode.unfocus();

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

  // #update
  void _putEmployee(){
    _unfocusAll();
    String name = _nameController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();
    String age = _ageController.text.toString().trim();
    if(name.isEmpty || salary.isEmpty || age.isEmpty){
      snackBar(context, 'Fill in the all fields!');
      return;
    }
    Employee employee = Employee(employeeName: name, employeeSalary: salary, employeeAge: age);
    Network.PUT(Network.API_PUT, Network.PUTbody(employee)).then((response) => _showUpdatedResponse(response));
  }
  void _showUpdatedResponse(String? _response){
    if (kDebugMode) {
      print(_response);
    }
    setState(() {
      updatedResponse = _response ?? 'Something went wrong...';
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _idController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _idFocusNode.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    _salaryFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBarWidget('PUT AN EMPLOYEE'),
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
                    const Text('ID (1 - 24): ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen)),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 40,
                      width: 60,
                      child: TextField(
                        controller: _idController,
                        focusNode: _idFocusNode,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen),
                        decoration: InputDecoration(
                            label: const Text('ID', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 5)
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
                  color: CupertinoColors.systemGreen,
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
            const Text('Result', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen)),
            const SizedBox(height: 10),
            // #show respond
            Container(
              height: 200,
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(child: Text(originalResponse, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGreen, width: 4),
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            const SizedBox(height: 20),
            // #name
            TextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              readOnly: originalResponse.isEmpty || originalResponse == 'Try again...',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen),
              decoration: InputDecoration(
                  label: const Text('Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 5)
                  )
              ),
              onSubmitted: (value){},
            ),
            const SizedBox(height: 10),
            // #salary
            TextField(
              controller: _salaryController,
              focusNode: _salaryFocusNode,
              readOnly: originalResponse.isEmpty || originalResponse == 'Try again...',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen),
              decoration: InputDecoration(
                  label: const Text('Salary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 5)
                  )
              ),
              onSubmitted: (value){},
            ),
            const SizedBox(height: 10),
            // #age
            TextField(
              controller: _ageController,
              focusNode: _ageFocusNode,
              readOnly: originalResponse.isEmpty || originalResponse == 'Try again...',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen),
              decoration: InputDecoration(
                  label: const Text('Age', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 4)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: CupertinoColors.systemGreen, width: 5)
                  )
              ),
              onSubmitted: (value){},
            ),
            const SizedBox(height: 10),
            // #post button
            MaterialButton(
              height: 46,
              minWidth: MediaQuery.of(context).size.width,
              color: CupertinoColors.systemGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: const Text('PUT EMPLOYEE', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              onPressed: originalResponse.isEmpty || originalResponse == 'Try again...'
                ? (){}
                : _putEmployee,
            ),
            const SizedBox(height: 10),
            // #show result
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: CupertinoColors.systemGreen, width: 4)
              ),
              child: Center(child: Text(updatedResponse, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ),
          ],
        ),
      ),
    );
  }
}
