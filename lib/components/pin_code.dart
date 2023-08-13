import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../functions/functions.dart';
//import 'package:gradient_borders/gradient_borders.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({
    Key? key,
    this.userPin,
  }) : super(key: key);

  final String? userPin;

  @override
  State<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = '';
  final formKey = GlobalKey<FormState>();

  late Map<String, Object?> friend = {};
  String pincode = '';
  String staticPin = '';

  _getPincode() async {
    if (staticPin != '') {
      setState(() {});
      return staticPin;
    } else {
      return staticPin = 'lame';
    }
  }

  _getConnectionData(String staticPin) async {
    if (staticPin != '') {
      friend = await ReadUserData.getConnectionData(staticPin);
      setState(() {});
      return friend;
    } else {
      return staticPin = 'lame';
    }
  }

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

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
                    horizontal: 15,
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(
                    color: Color.fromRGBO(116, 215, 247, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: const Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: const Offset(-1, 2),
                          blurRadius: 5)
                    ]),
                child: ButtonTheme(
                  height: 50,
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
                        staticPin =
                            await UserPincode.getStaticPincode(currentText);
                        friend = await _getConnectionData(staticPin);
                        setState(
                          () async {
                            hasError = false;
                            snackBar(
                                "OTP Verified!! $staticPin, ${friend['firstName']}");
                          },
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        "VERIFY".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextButton(
                      child: const Text("Clear"),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
