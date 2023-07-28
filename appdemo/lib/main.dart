// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/sqlite.dart';
import 'controller/user.proviser.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'view/screen/home.dart';
import 'view/screen/home/home-screen.dart';
import 'view/screen/login/login-screen.dart';
import 'view/screen/sign/sign-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Security()),
      ],
      child:  const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginScreen(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/sign': (context) => const SignScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
