import 'package:dummy_api/models/employee_model.dart';
import 'package:dummy_api/services/hive_service.dart';
import 'package:dummy_api/services/http_service.dart';
import 'package:dummy_api/widgets/app_bar.dart';
import 'package:dummy_api/widgets/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';


class GETOne extends StatefulWidget {
  static const String id = '/get_one';
  const GETOne({Key? key}) : super(key: key);

  @override
  State<GETOne> createState() => _GETOneState();
}

class _GETOneState extends State<GETOne> {
  String response = '';
  Set<String> history = {};
  final TextEditingController _idController = MaskedTextController(mask: "00");
  final FocusNode _focusNode = FocusNode();

  void _getID(String employeeId){
    _focusNode.unfocus();

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
      response = _response ?? 'Try again...';
    });

    if(_response != null){
      setState(() {
        history.add(_response);
      });
      HiveService().storeEmployeesHistory(List<String>.from(history));
    }
  }

  void loadHistory(){
    setState(() {
      history = Set.from(HiveService().loadEmployee());
    });
  }

  void clearHistory(){
    HiveService().removeEmployees();
    loadHistory();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHistory();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadHistory();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _idController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: [
              AppBarWidget('GET AN EMPLOYEE'),
              Container(
                height: kToolbarHeight + 20,
                alignment: Alignment.bottomRight,
                child: IconButton(
                  splashRadius: 1,
                  icon: const Icon(Icons.refresh, size: 30),
                  onPressed: loadHistory,
                  tooltip: 'Reload the history',
                ),
              )
            ],
          ),
        ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // #id number
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Enter id number (1 - 24)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemBlue)),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _idController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemBlue),
                      decoration: InputDecoration(
                        label: const Text('ID', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color: CupertinoColors.systemBlue, width: 4)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(color: CupertinoColors.systemBlue, width: 4)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: CupertinoColors.systemBlue, width: 5)
                        )
                      ),
                      onSubmitted: (value){
                        _getID(_idController.text.toString().trim());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // #get button
              MaterialButton(
                height: 46,
                minWidth: MediaQuery.of(context).size.width,
                color: CupertinoColors.systemBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: const Text('GET EMPLOYEE', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                onPressed: (){
                  _getID(_idController.text.toString().trim());
                },
              ),
              const SizedBox(height: 10),
              const Divider(color: CupertinoColors.systemBlue, thickness: 2),
              const Text('Result', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemBlue)),
              const SizedBox(height: 10),
              // #show respond
              Container(
                height: 200,
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(child: Text(response, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemBlue, width: 4),
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              const SizedBox(height: 10),
              const Text('History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.systemBlue)),
              const SizedBox(height: 10),
              // #history list
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemBlue, width: 4),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: history.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(10.0),
                          itemCount: history.length,
                          itemBuilder: (BuildContext context, int index){
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${(index + 1).toString()}.', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                                    const VerticalDivider(color: CupertinoColors.systemBlue, thickness: 2),
                                    Expanded(
                                      child: Text(history.elementAt(index), style: const TextStyle(fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                                const Divider(color: CupertinoColors.systemBlue, thickness: 2)
                              ],
                            );
                          },
                      )
                      : const Center(child: Text('Empty', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),))
                ),
              ),
              const SizedBox(height: 10),
              // #delete button
              MaterialButton(
                height: 46,
                minWidth: MediaQuery.of(context).size.width,
                color: CupertinoColors.systemRed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: const Center(child: Icon(Icons.delete, color: Colors.white)),
                onPressed: clearHistory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
