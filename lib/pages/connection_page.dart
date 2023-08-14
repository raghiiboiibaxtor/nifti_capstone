//import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:nifti_locapp/components/copy_tool.dart';
import 'package:nifti_locapp/components/pin_code.dart';
//import '../components/text_display.dart';
import '../functions/functions.dart';

// * ---------------- * (STATEFUL WIDGET) CLASS CONNECTOR (STATEFUL WIDGET) * ---------------- *
class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Connector()), //PinCodeVerificationScreen()
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

  String imageUrl = '';

  // ? get profileImage from storage
  _getProfileImageUrl() async {
    // get reference to image file in Firebase Storage
    imageUrl = await ReadUserData.getProfileImageUrl();
    //imageUrl = url;
    setState(() {
      imageUrl;
    });
  }

  @override
  initState() {
    _getProfileData();
    _getConnectionData();
    _getProfileImageUrl();
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
                child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.top,
                    children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Stack(
                        children: [
                          // Profile picture
                          details['imageLink'] != null
                            ? 
                            CircleAvatar(
                                radius: 50,
                                backgroundImage: const AssetImage(
                                    'images/defaultProfileImage.png'),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      NetworkImage(imageUrl, scale: 1.0),
                                ),
                              )
                            :
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/defaultProfileImage.png'),
                          ),
                        ],
                      ),
                      // Space between
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
                  // Space between
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