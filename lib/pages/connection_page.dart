import "package:flutter/material.dart";
import 'package:nifti_locapp/components/copy_tool.dart';
import 'package:nifti_locapp/components/pin_code.dart';
import '../functions/functions.dart';
/* * ---------------- * END OF PACKAGES * ---------------- * */

// * ---------------- * (STATEFUL WIDGET) CLASS CONNECTOR (STATEFUL WIDGET) * ---------------- *
class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Connector()),
    );
  }
}

// * ---------------- * (STATEFUL WIDGET) CLASS CONNECTOR (STATEFUL WIDGET) * ---------------- *
class Connector extends StatefulWidget {
  const Connector({super.key});

  @override
  State<Connector> createState() => _ConnectorState();
}

// * ---------------- * (STATE) CLASS _ConnectorState (STATE) * ---------------- *
class _ConnectorState extends State<Connector> {
  // ? Global variables
  late Map<String, Object?> details = {};
  late Map<String, Object?> friend = {};
  String pincode = '';

  // ? Get user's data and store in Map<> details
  _getProfileData() async {
    details = await ReadUserData.getProfileData();
    if (details.isNotEmpty) {
      for (int i = 0; i < details.length; i++) {
        setState(() {});
      }
    }
    return details;
  }

  // ? Get connection's code data
  _getConnectionData() async {
    friend = await ReadUserData.getConnectionData(
        pincode); // ? Grabbing connection object and assigning to friend
    setState(() {}); // ? Allowing the ui to change
    return friend;
  }

  // ? Running functions on page load
  @override
  initState() {
    _getProfileData();
    _getConnectionData();
    super.initState();
  }

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child: Column(children: [
              const SizedBox(
                height: 70,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // ? Profile picture
                      details['imageLink'] != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: const AssetImage(
                                  'images/defaultProfileImage.png'),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    '${details['imageLink']}',
                                    scale: 1.0),
                              ),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/defaultProfileImage.png'),
                            ),
                    ],
                  ),
                  // ? Space between
                  const SizedBox(
                    width: 15,
                  ),

                  // ? Display user's personal code
                  CopyTool(
                    text: "${details['pincode']}",
                    fontSize: 88,
                    letterSpacing: 1,
                  ),
                ],
              ),
              // ? Space between
              const SizedBox(height: 40),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const PinCodeVerificationScreen(),
              ),
            ]))));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _LoginPageState (STATE) * ---------------- *