// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:appdemo/model/demo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/api.dart';
import '../../../../controller/user.proviser.dart';
import '../../../controller/sqlite.dart';
import '../../widget/toast.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _State();
}

class _State extends State<ToDoScreen> {
  List<Demo> listDemo = [];
  void callApi() async {
    var response = await httpGet("/todo", context);
    var todos = [];
    if (response.containsKey("body")) {
      var resultTodo = jsonDecode(response["body"]);
      todos = resultTodo['todos'];

      setState(() {
        listDemo = todos.map((e) {
          return Demo.fromMap(e);
        }).toList();
      });
    }
    // await getImage(selectedBreed, selectedSubBreed);
    setState(() {
      statusData = true;
    });
  }

  bool statusData = false;

  var abc = {};

  @override
  void initState() {
    super.initState();
    callApi();
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
            ? Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ToDo",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height - 130,
                    decoration: BoxDecoration(),
                    child: ListView(
                      children: [
                        for (Demo element in listDemo)
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(border: Border.all(width: 0.5)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${element.id}"),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 5,
                                  child: Text(element.text),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text("${element.status}"),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      element.author = security.user.userName;
                                      DBProvider.db.newClient(element);
                                      showToast(
                                        context: context,
                                        msg: "Add Success",
                                        color: Color.fromRGBO(54, 245, 29, 1),
                                        icon: const Icon(Icons.done),
                                        timeHint: 2,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_box,
                                      color: Colors.blue,
                                    ),
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
