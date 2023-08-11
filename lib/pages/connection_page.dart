import "package:flutter/material.dart";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
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
                  child: const Text("Create Random Number")),
            ])));
  }
}
