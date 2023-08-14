import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../functions/functions.dart';
import '../functions/frontend.dart';
import 'package:nifti_locapp/components/button.dart';
import 'package:nifti_locapp/components/text_display.dart';
import 'package:nifti_locapp/components/connection_modal.dart';

// ? PinCodeVerificationScreen == widget to display and capture user's unique pin

// * ---------------- * (STATEFUL WIDGET) CLASS PinCodeVerificationScreen (STATEFUL WIDGET) * ---------------- *
class PinCodeVerificationScreen extends StatefulWidget {
  // Required variables to be passed
  const PinCodeVerificationScreen({
    Key? key,
    this.userPin,
  }) : super(key: key);
  // Component Variables
  final String? userPin;

  @override
  State<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}
// * ---------------- * END OF (STATE) CLASS PinCodeVerificationScreen (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _PinCodeVerificationScreenState (STATE) * ---------------- *
class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  // Variables
  bool hasError = false;
  String currentText = '';
  final formKey = GlobalKey<FormState>();

  late Map<String, Object?> friend = {};
  String pincode = '';
  String staticPin = '';

  // ? get user's code and store in staticPin
  _getPincode() async {
    if (staticPin != '') {
      setState(() {});
      return staticPin;
    } else {
      return staticPin = 'lame';
    }
  }

  // ? get connections data and store in Map<> friend
  _getConnectionData(String staticPin) async {
    if (staticPin != '') {
      friend = await ReadUserData.getConnectionData(staticPin);
      setState(() {});
      return friend;
    } else {
      return staticPin = 'lame';
    }
  }

  // Run functions on page load
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _getPincode();
    _getConnectionData(staticPin);
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // ? snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 8),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 0,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    textStyle: const TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(209, 147, 246, 1)),
                    textGradient: const LinearGradient(colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ]),
                    obscureText: false,
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(21),
                      fieldHeight: 88,
                      fieldWidth: 77,
                      borderWidth: 0.0,
                      inactiveFillColor:
                          const Color.fromRGBO(209, 147, 246, 0.88),
                      selectedFillColor:
                          const Color.fromRGBO(115, 142, 247, 0.88),
                      activeFillColor:
                          const Color.fromRGBO(116, 215, 247, 0.88),
                      activeBorderWidth: 0.0,
                      inactiveBorderWidth: 0.0,
                      selectedBorderWidth: 0.0,
                      errorBorderColor: const Color.fromRGBO(116, 215, 247, 0),
                    ),
                    cursorColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  hasError ? "* Please fill up all the cells properly" : "",
                  style: const TextStyle(
                    color: Color.fromRGBO(116, 215, 247, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Space between
              const SizedBox(height: 10),
              // ? Entry prompt
              const Text("Add Connection",
                  style: TextStyle(
                      letterSpacing: 0.8,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(134, 151, 175, 1))),
              const Text('Tell them your code & enter theirs!',
                  style: TextStyle(
                      letterSpacing: 0.8,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(134, 151, 175, 1))),
              const SizedBox(
                height: 25,
              ),

              // ? Clear & Verify Buttons
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    // Button border & drop shadow
                    Container(
                      height: 42,
                      width: 80,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(203, 211, 223, 1),
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                          ],
                          color: Color.fromRGBO(255, 159, 180, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    // Clear Button
                    ButtonComponent(
                      onTap: () {
                        textEditingController.clear();
                      },
                      text: 'Clear',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(252, 247, 244, 1),
                      fontColor: const Color.fromRGBO(255, 159, 180, 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                // ? Connect Button
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    // Button border & drop shadow
                    Container(
                      height: 52,
                      width: 234,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(203, 211, 223, 1),
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                          ],
                          color: Color.fromRGBO(121, 212, 189, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    // Verify Button
                    Container(
                      width: 230,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(235, 254, 244, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ButtonTheme(
                        //height: 50,
                        // ? onPressed Functionalities
                        child: TextButton(
                          onPressed: () async {
                            formKey.currentState!.validate();
                            // conditions for validating
                            if (currentText.length != 4) {
                              errorController!.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() => hasError = true);
                            } else {
                              UserPincode(pincode: currentText);
                              staticPin = await UserPincode.getStaticPincode(
                                  currentText);
                              friend = await _getConnectionData(staticPin);
                              setState(
                                () async {
                                  hasError = false;
                                  if ('${friend['firstName']}' == 'null') {
                                    displayErrorMessage(context,
                                        "Oops! That's an invalid code. Please try again 👀");
                                    const SizedBox(
                                      height: 50,
                                    );
                                    /*snackBar(
                                    "OTP Not Found!!");*/
                                  } else {
                                    /*snackBar(
                                    "OTP Verified!! $staticPin, ${friend['firstName']}");*/
                                    // Clear code when matched
                                    textEditingController.clear();
                                    // Modal with matching connections details

                                    displayModalBottomSheet(
                                      context,
                                      '${friend['firstName']}'
                                          ' ${friend['lastName']}',
                                      '${friend['bio']}',
                                      '${friend['pronouns']}',
                                      '${friend['industry']}',
                                      '${friend['city/town']}',
                                      '${friend['role']}',
                                      '${friend['company']}',
                                      '${friend['yearsWorked']}',
                                    );
                                  }
                                },
                              );
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: TextDisplay(
                                    text: 'CONNECT',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(121, 212, 189, 1)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _PinCodeVerificationScreenState (STATE) * ---------------- *