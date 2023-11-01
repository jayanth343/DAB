import 'dart:io';
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

class Don extends StatelessWidget {
  const Don({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Donsc(),
      title: "DAB",
      debugShowCheckedModeBanner: false,
    );
  }
}

class Donsc extends StatefulWidget {
  const Donsc({super.key});

  @override
  State<Donsc> createState() => _Don();
}

class _Don extends State<Donsc> {
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
      body: const Donscr(),
    );
  }
}

class Donscr extends StatefulWidget {
  const Donscr({super.key});

  @override
  State<Donscr> createState() => Dons();
}

class Dons extends State<Donscr> {
  final latc = TextEditingController();
  final lonc = TextEditingController();
  final detc = TextEditingController();
  final qtc = TextEditingController();
  //final latc = TextEditingController();
  //final lonc = TextEditingController();

  String? lat;
  String? long;
  String det = '''''';
  String qty = '';
  FirebaseFirestore d = FirebaseFirestore.instance;

  Future<void> insd(lat, long, det, qty) async {
    det = detc.text;
    qty = qtc.text;
    det = detc.text;
    qty = qtc.text;
    int.parse(qty);
    lat = double.parse(lat);
    long = double.parse(long);
    var uid = l.currentUser?.uid;
    final u = {
      "UID": uid,
      "details": det,
      "qty": qty,
      "loc": GeoPoint(lat, long)
    };
    d.collection("don_det").doc("$uid").set(u);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Success!",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1, milliseconds: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Donor ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "How Many People Can it Feed",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: qtc,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Details about Food",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              controller: detc,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Current Location: ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RawMaterialButton(
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                fillColor: const Color(0xFF0069FE),
                elevation: 0,
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Gmap.getCurrentLocation().then((value) =>
                      {lat = '${value.latitude}', long = '${value.longitude}'});
                  if (lat == null || long == null) {
                    Gmap.getCurrentLocation().then((value) => {
                          lat = '${value.latitude}',
                          long = '${value.longitude}'
                        });
                  }
                  debugPrint("\n lat:$lat long: $long\n");
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Reg2()),
                );*/
                  insd(lat, long, det, qty);
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
