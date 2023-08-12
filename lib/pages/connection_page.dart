//import 'dart:ffi';
//import 'dart:html';

import "package:flutter/material.dart";
import 'package:nifti_locapp/components/pin_code.dart';
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
  late String users = '';
  late Map<String, dynamic> details = {};
  //late List user = [];
  // late List key = [];
  //late dynamic index;
  _getProfileData() async {
    details = await ReadUserData.getProfileData();
    // index = details.map(('firstName', '') => null);
    if (details.isNotEmpty) {
      users = details['firstName'];
      //  key = details.keys.toList();
      //  user = details.values.toList();
      setState(() {
        // index.toString();
      });
    }
    return users;
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
              Text("User: $users",
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
