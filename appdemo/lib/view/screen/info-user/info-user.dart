// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/firebase-auth.dart';
import '../../../../controller/user.proviser.dart';
import '../../../model/user.dart';
import 'change-info.dart';
import 'change-pass.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({Key? key}) : super(key: key);

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  bool statusData = false;

  void callApi() async {
    setState(() {
      statusData = true;
    });
  }

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
            ? Container(
                width: MediaQuery.of(context).size.width * 1,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: (MediaQuery.of(context).size.width / 2.6) - 24.0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 193, 231, 247),
                          // borderRadius: const BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                          borderRadius: BorderRadius.circular(32),

                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Color.fromARGB(255, 9, 64, 193).withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 120),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Full name: ",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            )),
                                        Expanded(flex: 4, child: Text("${security.user.displayName}")),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 10),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Email: ",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            )),
                                        Expanded(flex: 4, child: Text("${security.user.userName}")),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                          child: TextButton(
                                            onPressed: () {
                                              //
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext context) => ChangeInFor(user: security.user,),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.update, color: Colors.white),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Update",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: 150,
                                          height: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                          child: TextButton(
                                            onPressed: () {
                                              //
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext context) => ChangePass(),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.change_circle, color: Colors.white),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Change pass",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                       
                                      ],
                                    ),
                                  ),
                                   Center(
                                     child: Container(
                                      margin: EdgeInsets.only(top: 30),
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 228, 139, 5)),
                                            child: TextButton(
                                              onPressed: () {
                                                signOut();
                                                Navigator.pushNamed(context, "/login");
                                                security.changeUser(UserLogin());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.logout, color: Colors.white),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Log out",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                   )
                                  // Ro
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 25),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 5),
                                borderRadius: BorderRadius.circular(120),
                                color: Colors.blue,
                              ),
                              child: (security.user.photoURL == "" || security.user.photoURL == null)
                                  ? ClipOval(
                                      //  clipper:C,
                                      child: Image.network('https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg', width: 200, height: 200, fit: BoxFit.cover),
                                    )
                                  : ClipOval(
                                      //  clipper:C,
                                      child: Image.network(security.user.photoURL!, width: 200, height: 200, fit: BoxFit.cover),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: const CircularProgressIndicator()));
  }
}
