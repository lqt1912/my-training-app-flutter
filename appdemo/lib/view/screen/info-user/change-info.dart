// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, use_build_context_synchronously, avoid_unnecessary_containers, deprecated_member_use

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../controller/user.proviser.dart';
import '../../../model/user.dart';
import '../../widget/toast.dart';

class ChangeInFor extends StatefulWidget {
  UserLogin user;
  ChangeInFor({super.key, required this.user});
  @override
  State<ChangeInFor> createState() => _ChangeInForState();
}

class _ChangeInForState extends State<ChangeInFor> {
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController password2 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserLogin data;
  late UserLogin databack;

  @override
  void initState() {
    super.initState();
    data = widget.user;
    databack = widget.user;
    fullname.text = data.displayName ?? "";
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
        child: Consumer<Security>(
            builder: (context, security, child) => Scaffold(
                appBar: AppBar(),
                body: Container(
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
                                      margin: EdgeInsets.only(top: 120),
                                      child: Center(
                                          child: OutlinedButton(
                                        onPressed: () async {
                                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                                          if (result != null) {
                                            String fileName = result.files.first.name;
                                            String path = result.files.first.path ?? "";
                                            await FirebaseStorage.instance.ref('Images/$fileName').putFile(File(path));
                                            setState(() {
                                              data.photoURL = "https://firebasestorage.googleapis.com/v0/b/dog-app-ec6ec.appspot.com/o/Images%2F$fileName?alt=media";
                                            });
                                          }
                                        },
                                        child: const Text(
                                          "Thay ảnh",
                                          // style: textAppStyle,
                                        ),
                                      )),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18, top: 10),
                                        height: 52.0,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078))),
                                        child: TextField(
                                          decoration: InputDecoration(hintText: "Full Name", hintStyle: TextStyle(color: Color(0xffAFAFAF)), border: InputBorder.none),
                                          controller: fullname,
                                          obscureText: false,
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
                                                if (fullname.text == "") {
                                                  showToast(
                                                    context: context,
                                                    msg: "Need to fill out the information completely",
                                                    color: Color.fromRGBO(245, 115, 29, 0.464),
                                                    icon: const Icon(Icons.warning),
                                                    timeHint: 2,
                                                  );
                                                  Navigator.pop(context);
                                                } else {
                                                  data.displayName = fullname.text;
                                                  User? user = _auth.currentUser;
                                                  await user!.updateProfile(displayName: fullname.text, photoURL: data.photoURL);
                                                  security.changeUser(data);
                                                  showToast(
                                                    context: context,
                                                    msg: "Update Success",
                                                    color: Color.fromRGBO(54, 245, 29, 0.463),
                                                    icon: const Icon(Icons.done),
                                                    timeHint: 2,
                                                  );
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
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
                                child: (data.photoURL == "" || data.photoURL == null)
                                    ? ClipOval(
                                        //  clipper:C,
                                        child: Image.network('https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg', width: 200, height: 200, fit: BoxFit.cover),
                                      )
                                    : Container(
                                        width: 200,
                                        height: 200,
                                        child: ClipOval(
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/gif/load.gif',
                                            image: data.photoURL!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
