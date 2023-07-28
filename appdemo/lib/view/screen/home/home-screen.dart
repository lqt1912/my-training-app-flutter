// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/api.dart';
import '../../../../controller/user.proviser.dart';
import '../../../controller/sqlite.dart';
import '../../../model/demo.dart';
import '../../widget/toast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({Key? key}) : super(key: key);

  @override
  State<HomeBodyScreen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  List<Demo> listDemoSqlite = [];
  void callData() async {
    var securityModel = Provider.of<Security>(context, listen: false);
    listDemoSqlite = await DBProvider.db.getAllClients(securityModel.user.userName ?? "");
    setState(() {
      statusData = true;
    });
  }

  bool statusData = false;
  Map<int, String> listStatus = {
    -1: 'All',
    1: 'Done',
    0: 'Todo',
  };
  int selectedtatus = -1;
  @override
  void initState() {
    super.initState();
    callData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> processing() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Center(child: const CircularProgressIndicator());
        },
      );
    }

    return Consumer<Security>(
        builder: (context, security, child) => (statusData)
            ? ListView(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Home",
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController todoIteam = TextEditingController();
                                  return AlertDialog(
                                    title: const Text('Add todos'),
                                    content: TextField(
                                      controller: todoIteam,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        child: const Text('Add'),
                                        onPressed: () async {
                                          if (todoIteam.text != "") {
                                            Demo dataAdd = Demo(id: 0, status: false, text: todoIteam.text, author: security.user.userName);
                                            DBProvider.db.newClient(dataAdd);
                                            setState(() {
                                              listDemoSqlite.insert(0, dataAdd);
                                            });
                                            showToast(
                                              context: context,
                                              msg: "Add Success",
                                              color: Color.fromRGBO(54, 245, 29, 1),
                                              icon: const Icon(Icons.done),
                                              timeHint: 2,
                                            );
                                            Navigator.of(context).pop();
                                          } else {
                                            showToast(
                                              context: context,
                                              msg: "None",
                                              color: Color.fromRGBO(251, 156, 14, 1),
                                              icon: const Icon(Icons.warning),
                                              timeHint: 2,
                                            );
                                          }
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.border_color,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height - 130,
                    decoration: BoxDecoration(),
                    child: ListView(
                      children: [
                        Center(child: Text("author: ${security.user.userName}")),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text("All"),
                                items: listStatus.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                                value: selectedtatus,
                                onChanged: (value) async {
                                  setState(() {
                                    statusData = false;
                                    selectedtatus = value!;
                                    listDemoSqlite = [];
                                  });
                                  var securityModel = Provider.of<Security>(context, listen: false);
                                  if (selectedtatus == -1) {
                                    listDemoSqlite = await DBProvider.db.getAllClients(securityModel.user.userName ?? "");
                                  } else {
                                    listDemoSqlite = await DBProvider.db.getAllClientsFilter(securityModel.user.userName ?? "", selectedtatus);
                                  }

                                  setState(() {
                                    statusData = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (listDemoSqlite.isNotEmpty)
                          for (var i = 0; i < listDemoSqlite.length; i++)
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(border: Border.all(width: 0.5), color: (listDemoSqlite[i].status) ? Colors.green : Color.fromARGB(255, 251, 154, 63)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${i + 1}"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 5,
                                    child: Text(listDemoSqlite[i].text),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: Text(listDemoSqlite[i].status ? "Done" : "To Do"),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (!listDemoSqlite[i].status)
                                          IconButton(
                                            onPressed: () async {
                                              listDemoSqlite[i].status = true;
                                              DBProvider.db.updateDemo(listDemoSqlite[i]);
                                              setState(() {
                                                listDemoSqlite[i] = listDemoSqlite[i];
                                              });
                                              showToast(
                                                context: context,
                                                msg: "Remove Success",
                                                color: Color.fromRGBO(54, 245, 29, 1),
                                                icon: const Icon(Icons.done),
                                                timeHint: 2,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            ),
                                          ),
                                        IconButton(
                                          onPressed: () async {
                                            DBProvider.db.deleteDemo(listDemoSqlite[i].id);
                                            setState(() {
                                              listDemoSqlite.remove(listDemoSqlite[i]);
                                            });
                                            showToast(
                                              context: context,
                                              msg: "Remove Success",
                                              color: Color.fromRGBO(54, 245, 29, 1),
                                              icon: const Icon(Icons.done),
                                              timeHint: 2,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.disabled_by_default,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: const CircularProgressIndicator()));
  }
}
