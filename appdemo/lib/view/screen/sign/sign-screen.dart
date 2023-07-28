// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controller/firebase-auth.dart';
import '../../widget/button-login-other.dart';
import '../../widget/toast.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController password2 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool checkPass = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    fullname.dispose();
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

    return Scaffold(
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
                    Navigator.pushNamed(context, "/login");
                    // EnterExitRoute(
                    //     exitRouteName: '/sign', enterRouteName: '/login');
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
                    decoration: InputDecoration(hintText: "Name", hintStyle: TextStyle(color: Color(0xffAFAFAF)), border: InputBorder.none),
                    controller: fullname,
                    obscureText: false,
                  )),
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
                margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18, top: 10),
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
                    if (username.text == "" || password.text == "" || fullname.text == "" || password2.text == "") {
                      showToast(
                        context: context,
                        msg: "Need to fill out the information completely",
                        color: Color.fromRGBO(245, 115, 29, 0.464),
                        icon: const Icon(Icons.warning),
                        timeHint: 2,
                      );
                      Navigator.pop(context);
                    } else {
                      if (password.text != password2.text) {
                        showToast(
                          context: context,
                          msg: "Passwords do not match",
                          color: Color.fromRGBO(245, 115, 29, 0.464),
                          icon: const Icon(Icons.warning),
                          timeHint: 2,
                        );
                        Navigator.pop(context);
                      } else {
                        if (password.text.length > 5 && password2.text.length > 5) {
                          try {
                            await signUpWithEmailAndPassword(fullname.text, username.text, password.text);
                            showToast(
                              context: context,
                              msg: "Sign Up Success",
                              color: Color.fromRGBO(54, 245, 29, 0.463),
                              icon: const Icon(Icons.done),
                              timeHint: 2,
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            showToast(
                              context: context,
                              msg: "Error",
                              color: Color.fromRGBO(245, 115, 29, 1),
                              icon: const Icon(Icons.warning),
                              timeHint: 2,
                            );
                            Navigator.pop(context);
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
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Register",
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
                      " Or Register With ",
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
                      onPressed: () {
                        print("facebook");
                      },
                      url: "assets/icon/facebook.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ButtonLink(
                      onPressed: () {},
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

              // Center(
              //   child: Container(
              //     width: 200,
              //     height: 200,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.red),
              //     child: FadeInImage.assetNetwork(
              //       placeholder: 'assets/gif/giphy.gif',
              //       image: 'https://picsum.photos/250?image=7',
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
