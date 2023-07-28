// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/firebase-auth.dart';
import '../../../controller/user.proviser.dart';
import '../../../model/user.dart';
import '../../widget/button-login-other.dart';
import '../../widget/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
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
      builder: (context, security, child) => Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 42, left: 22),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black, width: 1)),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.pushNamed(context, "/welcome");
                    },
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  width: 130,
                  height: 130,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18),
                    height: 52.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078))),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Email", hintStyle: TextStyle(color: Color(0xffAFAFAF)), border: InputBorder.none),
                      controller: username,
                      obscureText: false,
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                            obscureText: true,
                          ),
                        ),
                        // IconButton(
                        //   padding: EdgeInsets.all(0),
                        //   onPressed: () {},
                        //   icon: Icon(Icons.visibility),
                        // )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/sign");
                        },
                        child: Text(
                          "Register member",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                        )),
                    SizedBox(
                      width: 33,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18, top: 47),
                  padding: EdgeInsets.all(0),
                  height: 52.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Color(0xff0064D2), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078)), boxShadow: const [
                    BoxShadow(
                      color: Color(0x00000040),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ]),
                  child: TextButton(
                    onPressed: () async {
                      processing();
                      if (username.text == "" || password.text == "") {
                        showToast(
                          context: context,
                          msg: "Need to fill out the information completely",
                          color: Color.fromRGBO(245, 115, 29, 0.464),
                          icon: const Icon(Icons.warning),
                          timeHint: 2,
                        );
                        Navigator.pop(context);
                      } else {
                        try {
                          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                            email: username.text,
                            password: password.text,
                          );
                          User? user = userCredential.user;
                          security.changeUser(UserLogin(
                            uuid: user?.uid,
                            displayName: user?.displayName,
                            photoURL: user?.photoURL,
                            userName: user?.email,
                          ));

                          Navigator.pushNamed(context, "/home");
                        } catch (e) {
                          showToast(
                            context: context,
                            msg: "Account password is not correct",
                            color: Color.fromRGBO(245, 115, 29, 0.464),
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
                        Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 33.0, right: 32, bottom: 30, top: 30),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black, height: 1)),
                      Text(
                        " Or Login With ",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                      ),
                      Expanded(child: Divider(color: Colors.black, height: 1)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 33,
                    ),
                    Expanded(
                      child: ButtonLink(
                        onPressed: () async {},
                        url: "assets/icon/facebook.png",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonLink(
                        onPressed: () async {},
                        url: "assets/icon/google.png",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonLink(
                        onPressed: () {},
                        url: "assets/icon/apple.png",
                      ),
                    ),
                    SizedBox(
                      width: 33,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
