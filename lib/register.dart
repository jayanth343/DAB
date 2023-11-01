import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'home.dart';
import 'reg2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

var id = '';

final uid = l.currentUser?.uid;

class Reg extends StatelessWidget {
  const Reg({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Regpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Regpage extends StatefulWidget {
  const Regpage({super.key});

  @override
  State<Regpage> createState() => _RegpageState();
}

class _RegpageState extends State<Regpage> {
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
              MaterialPageRoute(builder: (context) => const Homepage()),
            );
          },
          iconSize: 33.0,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          tooltip: 'Go Back',
        ),
        backgroundColor: const Color.fromARGB(0, 255, 69, 1),
        actions: [
          IconButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              exit(0);
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.black,
            ),
            tooltip: "Exit",
          ),
        ],
      ),
      body: const RegScreen(),
    );
  }
}

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreen();
}

class _RegScreen extends State<RegScreen> {
  bool pv = false;
  final ncon = TextEditingController();
  final econ = TextEditingController();
  final pcon = TextEditingController();
  final cpcon = TextEditingController();
  final phcon = TextEditingController();
  String n = "";
  String em = '';
  String p = '';
  String cp = '';
  String ph = '';
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> regdata(n, em, p, cp, ph) async {
    n = ncon.text;
    em = econ.text;
    p = pcon.text;
    cp = cpcon.text;
    ph = phcon.text;

    if (p == cp && n != '' && em != '' && p != '' && cp != '' && ph != '') {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: em,
          password: p,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Successfully Registered!",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green[300],
            duration: const Duration(seconds: 1, milliseconds: 500),
          ),
        );
        FirebaseAuth s = FirebaseAuth.instance;
        final sg = s.signInWithEmailAndPassword(
          email: em,
          password: p,
        );

        insdata(n, em, ph);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          /*Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg: 'Email is Already in Use!',
              backgroundColor: Colors.red[200],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 4,
              textColor: Colors.white,
              fontSize: 15.0);*/
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Email Already In Use!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red[400],
              duration: Duration(seconds: 2, milliseconds: 500),
              action: SnackBarAction(
                label: 'TRY AGAIN',
                onPressed: () {},
              ),
            ),
          );
        }
      } catch (e) {
        print('$e');
      }
    }
    //
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please Fill All the Details!',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red[400],
          duration: Duration(seconds: 1, milliseconds: 500),
          action: SnackBarAction(
            label: 'TRY AGAIN',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  Future<void> insdata(n, em, ph) async {
    n = ncon.text;
    em = econ.text;
    ph = phcon.text;
    final user = <String, dynamic>{"name": n, "email": em, "phone": ph};
    db.collection("users").doc("$uid").set(user);
    print('Added with ID: $uid');
    await db.collection('users').get().then((event) {
      for (var doc in event.docs) {
        var d = doc.data();
        id = doc.id;
        debugPrint((id));
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Homep()),
    );
  }

  final chs = FirebaseAuth.instance.authStateChanges().listen(
    (User? user) {
      if (user == null) {
        debugPrint("\n error: not signed in\n");
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Register",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextField(
              keyboardType: TextInputType.name,
              autofocus: true,
              controller: ncon,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Full Name ",
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: econ,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Email ID ",
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: pcon,
              obscureText: !pv,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: Focus(
                  descendantsAreTraversable: false,
                  child: IconButton(
                      icon: Icon(pv
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          pv = !pv;
                        });
                      }),
                ),
                alignLabelWithHint: true,
                filled: false,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: cpcon,
              obscureText: !pv,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                suffixIcon: Focus(
                  descendantsAreTraversable: true,
                  child: IconButton(
                      icon: Icon(pv
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          pv = !pv;
                        });
                      }),
                ),
                alignLabelWithHint: false,
                filled: false,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: phcon,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Phone Number",
              ),
            ),
            const SizedBox(
              height: 24.0,
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
                  regdata(n, em, p, cp, ph);
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
