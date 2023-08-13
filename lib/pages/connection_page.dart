//import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:nifti_locapp/components/copy_tool.dart';
import 'package:nifti_locapp/components/pin_code.dart';
//import '../components/text_display.dart';
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

  late Map<String, Object?> friend = {};
  String pincode = '';

  _getConnectionData() async {
    friend = await ReadUserData.getConnectionData(pincode);
    setState(() {});
    return friend;
  }

  @override
  initState() {
    _getProfileData();
    _getConnectionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.top,
                    children: [
                  const SizedBox(
                    height: 100,
                  ),
                  // ? Display user's personal code
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      // Background gradient container
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        height: 75,
                        width: 175,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color.fromRGBO(209, 147, 246, 1),
                                  Color.fromRGBO(115, 142, 247, 1),
                                  Color.fromRGBO(116, 215, 247, 1),
                                ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            )),
                        child: CopyTool(
                          text: "${details['pincode']}",
                          fontSize: 35,
                          letterSpacing: 5,
                        ),
                      ),
                      // White container displaying code
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        height: 65,
                        width: 165,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(252, 250, 245, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(26),
                            )),
                        child: CopyTool(
                          text: "${details['pincode']}",
                          fontSize: 35,
                          letterSpacing: 5,
                        ),
                      ),
                    ],
                  ),
                  // Space between
                  const SizedBox(height: 30),
                  // ? Entry prompt
                  const Text("Tell them your code ",
                      style: TextStyle(
                        letterSpacing: 0.8,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(115, 142, 247, 1))),
                  const Text('& enter theirs!',
                      style:
                          TextStyle(letterSpacing: 0.8, fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromRGBO(209, 147, 246, 1))),
                  /*Text("Friends details: ${friend['firstName']}",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w400)),*/

                  // Space between
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const PinCodeVerificationScreen(),
                  ),
                ]))));
  }
}
