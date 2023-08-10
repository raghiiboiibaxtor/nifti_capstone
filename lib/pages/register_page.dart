import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/gradient_text_field.dart';
import 'package:nifti_locapp/components/text_field_character_limit.dart';
import 'package:nifti_locapp/components/drop_menu.dart';

// * * ---------------- * (STATEFUL WIDGET) CLASS RegisterPage (STATEFUL WIDGET) * ---------------- *
class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
// * * ---------------- * END OF (STATE) CLASS RegisterPage (STATE) * ---------------- *

// * * ---------------- * (STATE) CLASS _RegisterPageState (STATE) * ---------------- *
class _RegisterPageState extends State<RegisterPage> {
  // ? Text Controllers - used to access the user's input
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cityController = TextEditingController();
  String _pronouns = '';
  Uint8List? _profileImage;
  final _bio = TextEditingController();
  final _roleTitle = TextEditingController();
  final _industry = TextEditingController();
  final _companyName = TextEditingController();
  String _yearsWorked = '';

  // ? Stepper Variable
  int currentStep = 0;
  // ? Pronoun dropdown list
  final List<String> pronouns = [
    'They / Them',
    'He / Him',
    'She / Her',
    'He / They',
    'She / They',
    'Prefer not to say'
  ];
  // ? Years in company dropdown list
  final List<String> years = [
    '< 1 year',
    '1+ year',
    '2+ years',
    '3+ years',
    '4+ years',
    '5+ years',
    '6+ years',
    '7+ years',
    '8+ years',
    '9+ years',
    '10+ years',
  ];

  // ? Profile image selection function
  void selectProfileImage() async {
    Uint8List image = await pickImage();
    setState(() {
      _profileImage = image;
    });
  }

  // ? Dispose controllers when not using - helps memory management
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cityController.dispose();
    _bio.dispose();
    _roleTitle.dispose();
    _industry.dispose();
    _companyName.dispose();
    super.dispose();
  }

  // ? Check if Password & Confirm Password fields match
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      displayErrorMessage(context, 'Passwords don\'t match. Please try again.');
      return false;
    }
  }

  // ? Method to register user in Firebase / Firestore
  Future register() async {
    // ? Calling Loading Animation
    displayLoadingCircle(context);

    // ? Creates user in Firebase if passwords match
    if (passwordConfirmed()) {
      // ? Registration Check
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // ? pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        // ? pop loading circle & display error message
        Navigator.pop(context);
        displayErrorMessage(context, error.message!);
      }

      // ? Adds user info to Firestore
      await StoreUserData().addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        _cityController.text.trim(),
        _pronouns,
        _profileImage!,
        _bio.text.trim(),
        _roleTitle.text.trim(),
        _industry.text.trim(),
        _companyName.text.trim(),
        _yearsWorked,
      );
      StoreUserData().addUserImage(_profileImage!);
      StoreUserData().updateFirestoreImageLink(_profileImage!);
    }
  }

  // ? List of steps to be displayed in the stepper
  List<Step> stepList() => [
        // ? First Step == Account Details (First Name, Last Name, Email, Password)
        Step(
            isActive: currentStep >= 0,
            state: currentStep <= 0 ? StepState.editing : StepState.complete,
            title: const Text('Account Details'),
            content: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Nifti!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),
                    // Name prompt
                    Row(
                      children: [
                        // First name
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 0),
                          width: 150,
                          controller: _firstNameController,
                          hintText: 'First Name *',
                          obscureText: false,
                        ),
                        // Last name
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 20.0),
                          width: 170,
                          controller: _lastNameController,
                          hintText: 'Last Name',
                          obscureText: false,
                        ),
                      ],
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),

                    //Email Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 350,
                      controller: _emailController,
                      hintText: 'Email *',
                      obscureText: false,
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),

                    //Password Textfield
                    GradientTextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        width: 350,
                        controller: _passwordController,
                        hintText: 'Password *',
                        obscureText: true),
                    // Space between next widget
                    const SizedBox(height: 20),

                    // Confirm Password Textfield
                    GradientTextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        width: 350,
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password *',
                        obscureText: true),
                    // Space between next widget
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            )),

        // ? Second Step == Account Details (Personal & Work Details)
        Step(
          isActive: currentStep >= 1,
          state: currentStep <= 1 ? StepState.editing : StepState.complete,
          title: const Text('Create Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Personal prompt
                const Text(
                  'A little about you...                                                  ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Space between next widget
                const SizedBox(height: 20),

                Row(
                  children: [
                    Stack(
                      children: [
                        _profileImage != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: MemoryImage(_profileImage!),
                              )
                            : const CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                    'images/defaultProfileImage.png'),
                              ),
                        Positioned(
                          bottom: -14,
                          left: 55,
                          child: IconButton(
                            onPressed: selectProfileImage,
                            icon: const Icon(Icons.add_a_photo_rounded),
                          ),
                        ),
                      ],
                    ),
                    // Space between next widget
                    const SizedBox(width: 50),
                    // ? Pronoun dropdown selector
                    DropdownMenuComponent(
                      width: 200,
                      value: pronouns,
                      hintText: const Text('Pronouns'),
                      itemsList: pronouns,
                      onChanged: (value) {
                        setState(() {
                          _pronouns = value as String;
                        });
                      },
                    ),
                  ],
                ),
                // Space between next widget
                const SizedBox(height: 20),

                //Bio Textfield
                CharacterLimitFieldComponent(
                  controller: _bio,
                  hintText: 'Bio',
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                ),
                // Space between next widget
                const SizedBox(height: 10),

                //City Textfield
                GradientTextFieldComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  width: 350,
                  controller: _cityController,
                  hintText: 'City / Town',
                  obscureText: false,
                ),
                // Space between next widget
                const SizedBox(height: 20),

                // Role prompt
                const Text(
                  '...and your current role                                            ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Space between next widget
                const SizedBox(height: 20),

                //Role Title Textfield
                GradientTextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    width: 350,
                    controller: _roleTitle,
                    hintText: 'Title',
                    obscureText: false),
                // Space between next widget
                const SizedBox(height: 20),

                //Industry Textfield
                GradientTextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    width: 350,
                    controller: _industry,
                    hintText: 'Industry',
                    obscureText: false),
                // Space between next widget
                const SizedBox(height: 20),

                Row(
                  children: [
                    // Place of Work/Study Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.only(left: 0),
                      width: 190,
                      controller: _companyName,
                      hintText: 'Place of Work/Study',
                      obscureText: false,
                    ),

                    // ? Years Worked dropdown selector
                    DropdownMenuComponent(
                      width: 150,
                      value: years,
                      hintText: const Text('Years'),
                      itemsList: years,
                      onChanged: (value) {
                        setState(() {
                          _yearsWorked = value as String;
                        });
                      },
                    ),
                  ],
                ),
                // Space between next widget
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ];

  // * * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Top bar that contains Nifti Logo
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
          title: SizedBox(
            width: 100,
            child: Image.asset('images/nifti_logo.png'),
          ),
        ),
        // Colour & Font theme for Stepper Widget
        body: Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(115, 142, 247, 1),
            ),
            fontFamily: 'Montserrat',
          ),
          // ? Start of Stepper widget
          child: Stepper(
            elevation: 0,
            steps: stepList(),
            currentStep: currentStep,
            // ? Change to next step
            onStepContinue: () {
              if (currentStep < (stepList().length - 1)) {
                setState(() {
                  currentStep += 1;
                });
              } else {
                if (currentStep == (stepList().length - 1)) {
                  register();
                }
              }
            },
            // ? Change to previous step
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
            type: StepperType.horizontal,
            // ? Next & Confirm, Cancel & Back Buttons
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == stepList().length - 1;
              return Row(
                children: [
                  // ? If first step = show Next button to continue & cancel prompt to go back to login page
                  if (!isLastStep) ...[
                    // Next Button
                    Expanded(
                        child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5),
                      ),
                    )),
                    const SizedBox(
                      width: 30,
                    ),
                    // Cancel Prompt
                    Expanded(
                        child: GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.5),
                      ),
                    ))
                  ],

                  // ? If final step = show Confirm button to save info & back prompt to go to previous step
                  if (isLastStep) ...[
                    // Confirm Button
                    Expanded(
                        child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5),
                      ),
                    )),
                    const SizedBox(
                      width: 30,
                    ),
                    // Back Prompt
                    Expanded(
                      child: GestureDetector(
                        onTap: details.onStepCancel,
                        child: const Text(
                          'Back',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ));
  }
  // * * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}

// * * ---------------- * END OF (STATE) CLASS _RegisterPageState (STATE) * ---------------- *
