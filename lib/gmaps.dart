// import 'dart:html';
// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'home.dart';
import 'rec.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:geolocator/geolocator.dart';

var currentLoc = LatLng(double.parse(lat), double.parse(long));
var currentLoc1 = LatLng(12.865953, 77.661541);
var currentLoc2 = LatLng(12.857187, 77.670172);

class Gmap extends StatelessWidget {
  const Gmap({super.key});
  // This widget is the root of your application.
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permsision denied");
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location permission denied for ever");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController _mapController;

  final Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(target: currentLoc, zoom: 14),
      onMapCreated: (controller) {
        _mapController = controller;
        addMarker('test', currentLoc);
        addMarker("ts", currentLoc1);
        addMarker("ts1", currentLoc2);
      },
      markers: _markers.values.toSet(),
    ));
  }

  addMarker(String id, LatLng location) {
    String title = id == 'test' ? 'Your current location' : 'Donor Location';

    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: 'Some Description of the place',
      ),
    );

    _markers[id] = marker;
    setState(() {});
  }
}
