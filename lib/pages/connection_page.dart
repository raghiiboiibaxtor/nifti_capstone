//import 'dart:ffi';
//import 'dart:html';

import "package:flutter/material.dart";
import 'package:nifti_locapp/components/pin_code.dart';
//import '../components/text_display.dart';
import '../functions/functions.dart';

//Bluetooth Contact Exchange Page
class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Connector()), //PinCodeVerificationScreen()
    );
  }
}

/* * ---------------- * (STATEFUL WIDGET) CLASS CONNECTOR (STATEFUL WIDGET) * ---------------- * */
class Connector extends StatefulWidget {
  const Connector({super.key});

  @override
  State<Connector> createState() => _ConnectorState();
}

/* * ---------------- * (STATE) CLASS _ConnectorState (STATE) * ---------------- * */
class _ConnectorState extends State<Connector> {
  late String code = '';
  late Map<String, Object?> details = {};

  _getProfileData() async {
    details = await ReadUserData.getProfileData();
    if (details.isNotEmpty) {
      for (int i = 0; i < details.length; i++) {
        setState(() {});
      }
    }
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.top,
                    children: [
              Text("Random Number: $code",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),
              ElevatedButton(
                  onPressed: () async {
                    code = await ReadUserData.readUserCode();
                    setState(() {});
                  },
                  child: const Text("My Number")),
              Text("User: ${details['firstName']}",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),
              ElevatedButton(
                  onPressed: () async {
                    await _getProfileData();
                    setState(() {});
                  },
                  child: const Text("Read User")),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const PinCodeVerificationScreen(),
              ),
            ]))));
  }
}

/*Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.top,
                    children: [
              Text("Random Number: $code",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),
              ElevatedButton(
                  onPressed: () async {
                    code = await ReadUserData.readUserCode();
                    setState(() {});
                  },
                  child: const Text("My Number")),
              Text("User: ${details['firstName']}",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),
              ElevatedButton(
                  onPressed: () async {
                    await _getProfileData();
                    setState(() {});
                  },
                  child: const Text("Read User")),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const PinCodeVerificationScreen(),
              ),
            ]))));* 
            
            
            
            
            
            return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<Map<String, Object?>>(
            stream: await _getProfileData(),
            builder: (context, snapshot) {
              // get user data
              if (snapshot.hasData) {
                return Container(
                    alignment: Alignment.topLeft,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: ListView(children: [
                      Row(children: [
                        // First Name
                        TextDisplay(
                          text: details['firstName'],
                          fontSize: 33,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(133, 157, 194, 1),
                        ),
                        // Space between first & last name
                        const SizedBox(
                          width: 8,
                        ),
                        // Last Name
                        TextDisplay(
                          text: details['lastName'],
                          fontSize: 33,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(133, 157, 194, 1),
                        ),
                      ]),
                    ]));
              }
            }));*/