import "package:flutter/material.dart";
import 'package:nifti_locapp/components/pin_code.dart';
import '../functions/functions.dart';

/* * ---------------- * (STATEFUL WIDGET) CLASS CONNECTOR (STATEFUL WIDGET) * ---------------- * */
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
  initState() {
    _getProfileData();
    super.initState();
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
              Text("Code: ${details['pincode']}",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),
              Text("User: ${details['firstName']}",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const PinCodeVerificationScreen(),
              ),
            ]))));
  }
}
