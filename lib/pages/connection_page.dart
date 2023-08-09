import "package:flutter/material.dart";
import 'dart:math';
import '../components/pin_code.dart';

//Bluetooth Contact Exchange Page
class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: PinCodeVerificationScreen()),
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
  late String _code = '';

  _createRandom() async {
    dynamic secure = Random.secure();
    dynamic secList = List.generate(4, (_) => secure.nextInt(10));
    _code = secList.toString();
    setState(() {});
    return _code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.top,
                children: [
          Text("Random Number: $_code",
              style:
                  const TextStyle(fontSize: 23, fontWeight: FontWeight.w400)),
          ElevatedButton(
              onPressed: () async {
                await _createRandom();
              },
              child: const Text("Create Random Number")),
        ])));
  }
}
