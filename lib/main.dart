//import 'dart:html';
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/* * ---------------- * MAIN FUNCTION * ---------------- * */
void main() {
  runApp(const MyApp());
}

/* * ---------------- * CLASS MY APP * ---------------- * */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application: NiftiGeo.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NiftiDemo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 85, 80, 233)),
        useMaterial3: true,
      ),
      home: const NiftiGeoApp(),
    );
  }
}

/* * ---------------- * (STATEFUL WIDGET) CLASS NiftiGeoApp (STATEFUL WIDGET) * ---------------- * */
class NiftiGeoApp extends StatefulWidget {
  const NiftiGeoApp({super.key});

  @override
  State<NiftiGeoApp> createState() => _NiftiGeoAppState();
}

/* * ---------------- * (STATE) CLASS _NiftiGeoAppState (STATE) * ---------------- * */
class _NiftiGeoAppState extends State<NiftiGeoApp> {
  // ? Generic debugging print function
  void print(Object? object) {
    print(object);
  }

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAddress = "";
  double tryLoc = 0;
  double bearing =
      Geolocator.bearingBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  Future<Position> _getLocation() async {
    // ? Confirming native location access specifier is public.
    servicePermission = await Geolocator.isLocationServiceEnabled();

    // ? Conditional if statement to check location permissions
    if (!servicePermission) {
      //print("LocationDisabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  // ? Converting geocode coordinates into location addresses
  _getAddressFromLoc() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country} ";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nifti GeoGrab"),
        backgroundColor: const Color.fromARGB(255, 148, 249, 250),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Location:",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              "HELLO LOC! Latitude: ${_currentLocation?.latitude} ; Longitude: ${_currentLocation?.longitude}"),
          const SizedBox(
            height: 33.3,
          ),
          const Text(
            "Location Address",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(_currentAddress),
          Text("{$bearing}"),
          const SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() async {
                  _currentLocation = await _getLocation();
                  await _getAddressFromLoc();
                  print(_currentLocation);
                });
              },
              child: const Text("GetLoc"))
        ],
      )),
    );
  }
}
