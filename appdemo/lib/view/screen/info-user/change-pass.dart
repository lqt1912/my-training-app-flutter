// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widget/toast.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool checkPass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    password2.dispose();
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change password"),
        ),
        backgroundColor: Color(0xffFFFFFF),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 30),
                  width: 130,
                  height: 130,
                  ),
                Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18),
                    height: 52.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Color(0xffAFAFAF)),
                              border: InputBorder.none,
                            ),
                            controller: password,
                            obscureText: checkPass,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              checkPass = !checkPass;
                            });
                          },
                          icon: Icon(
                            checkPass ? Icons.visibility : Icons.visibility_off,
                            color: Color.fromARGB(255, 107, 107, 107),
                          ),
                        )
                      ],
                    )),
                Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18),
                    height: 52.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Confirm password",
                              hintStyle: TextStyle(color: Color(0xffAFAFAF)),
                              border: InputBorder.none,
                            ),
                            controller: password2,
                            obscureText: checkPass,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              checkPass = !checkPass;
                            });
                          },
                          icon: Icon(
                            checkPass ? Icons.visibility : Icons.visibility_off,
                            color: Color.fromARGB(255, 107, 107, 107),
                          ),
                        )
                      ],
                    )),
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
                          onPressed: () async {
                            processing();
                            if (password.text == "" || password2.text == "") {
                              showToast(
                                context: context,
                                msg: "Need to fill out the information completely",
                                color: Color.fromRGBO(245, 115, 29, 1),
                                icon: const Icon(Icons.warning),
                                timeHint: 2,
                              );
                              Navigator.pop(context);
                            } else {
                              if (password.text.length > 5 && password2.text.length > 5) {
                                if (password.text != password2.text) {
                                  showToast(
                                    context: context,
                                    msg: "Passwords do not match",
                                    color: Color.fromRGBO(245, 115, 29, 1),
                                    icon: const Icon(Icons.warning),
                                    timeHint: 2,
                                  );
                                  Navigator.pop(context);
                                } else {
                                  User? user = FirebaseAuth.instance.currentUser;

                                  try {
                                    await user?.updatePassword(password.text);
                                    showToast(
                                      context: context,
                                      msg: "Change Password Success",
                                      color: Color.fromRGBO(54, 245, 29, 0.463),
                                      icon: const Icon(Icons.done),
                                      timeHint: 2,
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } catch (error) {
                                    print("error:$error");
                                    showToast(
                                      context: context,
                                      msg: "Error",
                                      color: Color.fromRGBO(245, 115, 29, 1),
                                      icon: const Icon(Icons.warning),
                                      timeHint: 2,
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              } else {
                                showToast(
                                  context: context,
                                  msg: "Password greater than 5 characters",
                                  color: Color.fromRGBO(245, 115, 29, 1),
                                  icon: const Icon(Icons.warning),
                                  timeHint: 2,
                                );
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check, color: Colors.white),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Confirm",
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(255, 228, 139, 5)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // security.changeUser(databack);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.chevron_left, color: Colors.white),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
