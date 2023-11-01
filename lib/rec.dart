import 'dart:io';

import 'package:path/path.dart';

import 'home.dart';
import 'gmaps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Rec extends StatelessWidget {
  const Rec({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Recsc(),
      title: "DAB",
      debugShowCheckedModeBanner: false,
    );
  }
}

class Recsc extends StatefulWidget {
  const Recsc({super.key});

  @override
  State<Recsc> createState() => _Rec();
}

class _Rec extends State<Recsc> {
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
              MaterialPageRoute(builder: (context) => const Homep()),
            );
          },
          iconSize: 33.0,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          tooltip: 'Go Back',
        ),
        backgroundColor: const Color.fromARGB(0, 255, 69, 1),
        actions: [],
      ),
      body: const Recscr(),
    );
  }
}

class Recscr extends StatefulWidget {
  const Recscr({super.key});

  @override
  State<Recscr> createState() => Recs();
}

class Recs extends State<Recscr> {
  final latc = TextEditingController();
  final lonc = TextEditingController();
  final detc = TextEditingController();
  final qtc = TextEditingController();
  //final latc = TextEditingController();
  //final lonc = TextEditingController();

  late String? lat;
  late String? long;
  String det = '''''';
  String qty = '';
  FirebaseFirestore d = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> getd() async {
    d.collection("don_det").where("loc", isNull: false).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          var cl = docSnapshot['loc'];
          Navigator.push(
            context as BuildContext,
            MaterialPageRoute(builder: (context) => const Gmap()),
          );
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<void> insd(lat, long, det, qty) async {
    det = detc.text;
    qty = qtc.text;
    det = detc.text;
    qty = qtc.text;
    int.parse(qty);
    lat = double.parse(lat);
    long = double.parse(long);
    final u = {"details": det, "qty": qty, "loc": GeoPoint(lat, long)};
    d
        .collection("don_det")
        .add(u)
        .then((DocumentReference doc) => debugPrint("\nAdded!\n"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
