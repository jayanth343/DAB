import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rec.dart';
import 'gmaps.dart';
import 'main.dart';
import 'donor.dart';

late String lat;
late String long;

final chs = FirebaseAuth.instance.authStateChanges().listen((User? user) {
  if (user == null) {
    debugPrint("No Login");
  } else {
    final uid = l.currentUser?.uid;
    final CollectionReference a =
        FirebaseFirestore.instance.collection("/don_det");
    DocumentReference doc = a.doc("$uid");
  }
});

FirebaseFirestore db = FirebaseFirestore.instance;
final latc = TextEditingController();
final lonc = TextEditingController();

class Homep extends StatelessWidget {
  const Homep({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Page1());
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  get cpntext => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "HomePage",
          ),
          backgroundColor: const Color.fromARGB(0, 255, 32, 1),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Don()));
              },
              child: const Text("Donate"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Gmap()));
                //Gmap.getCurrentLocation().then((value) =>
                //   {lat = '${value.latitude}', long = '${value.longitude}'});
              },
              child: const Text("Receive"),
            )
          ]),
        ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Page 2"),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Back"),
      )),
    );
  }
}
