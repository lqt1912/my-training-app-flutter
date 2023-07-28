// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/user.proviser.dart';
import 'home/home-screen.dart';
import 'info-user/info-user.dart';
import 'todo/todo-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? controller;
  int pageNumber = 0;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
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
      builder: (context, security, child) => SafeArea(
        // top:false,
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          body: pageNumber == 0
              ? HomeBodyScreen()
              : pageNumber == 2
                  ? InfoUserScreen()
                  : ToDoScreen(),
          bottomNavigationBar: Material(
            color: Colors.white,
            child: TabBar(
              onTap: (value) {
                setState(() {
                  pageNumber = value;
                });
              },
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: Colors.blue,
              ),
              controller: controller,
              indicatorColor: Colors.blue,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home, size: 30, color: pageNumber == 0 ? Colors.white : Colors.blue)),
                Tab(icon: Icon(Icons.add_box, size: 30, color: pageNumber == 1 ? Colors.white : Colors.blue)),
                Tab(
                  icon: Icon(Icons.account_circle, size: 30, color: pageNumber == 2 ? Colors.white : Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
