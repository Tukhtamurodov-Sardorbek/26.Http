import 'package:dummy_api/models/employee_model.dart';
import 'package:dummy_api/services/http_service.dart';
import 'package:dummy_api/widgets/app_bar.dart';
import 'package:dummy_api/widgets/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class POSTOne extends StatefulWidget {
  static const String id = '/post_one';
  const POSTOne({Key? key}) : super(key: key);

  @override
  State<POSTOne> createState() => _POSTOneState();
}

class _POSTOneState extends State<POSTOne> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _salaryFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String response = '';

  void _unfocusAll(){
    _nameFocusNode.unfocus();
    _salaryFocusNode.unfocus();
    _ageFocusNode.unfocus();
  }

  void _postEmployee(){
    _unfocusAll();
    String name = _nameController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();
    String age = _ageController.text.toString().trim();
    if(name.isEmpty || salary.isEmpty || age.isEmpty){
      snackBar(context, 'Fill in the all fields!');
      return;
    }
    Employee employee = Employee(employeeName: name, employeeSalary: salary, employeeAge: age);
    Network.POST(Network.API_POST, Network.POSTbody(employee)).then((response) => _showResponse(response));
  }

  void _showResponse(String? _response){
    setState(() {
      response = _response ?? 'Something went wrong';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    _salaryFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBarWidget('POST AN EMPLOYEE'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          alignment: AlignmentDirectional.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // #name
                TextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
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
                  child: const Text('POST EMPLOYEE', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  onPressed: _postEmployee,
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
                  child: Center(child: Text(response, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
