import 'dart:io';
import 'package:flutter_application_1/register.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Reg2 extends StatelessWidget {
  const Reg2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Reg2page(),
    );
  }
}

class Reg2page extends StatefulWidget {
  const Reg2page({super.key});

  @override
  State<Reg2page> createState() => _Reg2pageState();
}

class _Reg2pageState extends State<Reg2page> {
  bool pv = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Reg()),
            );
          },
          iconSize: 33.0,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          tooltip: 'Go Back',
        ),
        backgroundColor: const Color.fromARGB(0, 255, 69, 1),
        actions: const [],
      ),
      body: const Reg2Screen(),
    );
  }
}

class Reg2Screen extends StatefulWidget {
  const Reg2Screen({super.key});

  @override
  State<Reg2Screen> createState() => _Reg2Screen();
}

class _Reg2Screen extends State<Reg2Screen> {
  bool pv = false;
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.0,
          ),
          Text(
            "Fill in The Details ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            "I am a ",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "RobotoSans",
              fontSize: 18.0,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
