// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/rec.dart';

import 'home.dart';
import 'dart:math';
import 'donor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

FirebaseAuth l = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
      title: 'DAB',
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Color.fromARGB(0, 255, 69, 1),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              exit(0);
            },
            tooltip: "Exit",
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emc = TextEditingController();
  final pc = TextEditingController();
  String em = '';
  String p = '';

  Future<void> login(em, p) async {
    em = emc.text;
    p = pc.text;
    debugPrint("\n$em \n $p\n");
    try {
      final cred = l.signInWithEmailAndPassword(
        email: em,
        password: p,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Success!",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1, milliseconds: 0),
        ),
      );

      final uc = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: em, password: p);
      final use = uc.user;
      final uid = use?.uid;
      debugPrint("\n\n $uid \n\n");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homep()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'User Not Found!',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(
              seconds: 1,
              microseconds: 500,
            ),
            action: SnackBarAction(
              label: 'TRY AGAIN',
              onPressed: () {},
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Wrong Password!',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(
              seconds: 1,
              microseconds: 500,
            ),
            action: SnackBarAction(
              label: 'TRY AGAIN',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Donate A Bite",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            const Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emc,
              decoration: const InputDecoration(
                hintText: "Email ID ",
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              obscureText: true,
              controller: pc,
              decoration: const InputDecoration(
                  hintText: "Password ",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 22.0,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 14),
                ),
                onPressed: () => {
                  debugPrint('forgot pass'),
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 18, color: Colors.orange),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Reg()),
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 69, 1),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 18.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 77.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
                  login(em, p);
                },
                child: const Text(
                  "Login ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
