import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/text_display.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/functions/frontend.dart';
import 'package:nifti_locapp/components/text_form_field.dart';
import 'package:nifti_locapp/components/cta_cancel_button.dart';
import 'package:nifti_locapp/components/cta_confirm_button.dart';

// ? RegisterPage == display for new users to add details and register account

// * ---------------- * (STATEFUL WIDGET) CLASS RegisterPage (STATEFUL WIDGET) * ---------------- *
class RegisterPage extends StatefulWidget {
  // ? Component Variables
  final Function()? onTap;
  // ? Required variables to be passed
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
// * ---------------- * END OF (STATE) CLASS RegisterPage (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _RegisterPageState (STATE) * ---------------- *
class _RegisterPageState extends State<RegisterPage> {
  // ? Validation Variables
  final _formKey = GlobalKey<FormState>();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool? isChecked = false;
  bool isError = false;

  // ? Text Controllers - used to access the user's input
  final _fullNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _createCode = '';
  final String _userID = '';

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
  /*void selectProfileImage() async {
    Uint8List image = await pickImage();
    setState(() {
      _profileImage = image;
    });
  }*/

  // ? Dispose controllers when not using - helps memory management
  @override
  void dispose() {
    _fullNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _createCode = '';
    super.dispose();
  }

  // ? Check if Password & Confirm Password fields match
  /*bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      displayErrorMessage(context, 'Passwords don\'t match. Please try again.');
      return false;
    }
  }*/

  // ? Method to register user in Firebase / Firestore
  Future register() async {
    // ? Calling Loading Animation
    displayLoadingCircle(context);
    // ? Registration Check
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // ? pop loading circle
      if (context.mounted) Navigator.pop(context);
      _createCode = await CreateRandom.createRandom();
      // ? Adds user info to Firestore
      await StoreUserData().addUserDetails(
        /*_firstNameController.text.trim(),
        _lastNameController.text.trim(),*/
        _fullNameController.text.trim(),
        _emailController.text.trim(),
        _createCode,
        _userID,
      );
    } on FirebaseAuthException catch (error) {
      // ? pop loading circle & display error message
      Navigator.pop(context);
      if (error.code == 'invalid-email') {
        emailFormatError(_emailController.text, invalidEmailFormat,
            (error) => setState(() => _emailError = error));
      }
      if (error.code == 'email-already-in-use') {
        emailInUseError(_emailController.text, emailInUse,
            (error) => setState(() => _emailError = error));
      }
      if (error.code == 'weak-password') {
        passwordFormatError(_passwordController.text, weakPassword,
            (error) => setState(() => _passwordError = error));
      }
      //displayErrorMessage(context, error.message!);
    }
    //StoreUserData().addUserImage(_profileImage!);
    //StoreUserData().updateFirestoreImageLink(_profileImage!);
  }

  // * * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            //padding:const EdgeInsets.only(bottom: 50),
            child: Container(
          width: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background_gradient.png'),
                fit: BoxFit.cover),
          ),
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(top: 40)),
            // ? Nifti Logo
            const SizedBox(
              height: 160,
              child: Image(image: AssetImage('images/nifti_logo_white.png')),
            ),
            // White container
            Container(
                height: 650,
                width: 400,
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: niftiOffWhite,
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(50))),
                child: Stack(children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 9,
                      ),
                      GradientText(
                        'CREATE ACCOUNT',
                        colors: const [
                          Color.fromRGBO(209, 147, 246, 1),
                          Color.fromRGBO(115, 142, 247, 1),
                          Color.fromRGBO(116, 215, 247, 1)
                        ],
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  // Text Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        // ? Name Textfield
                        TextFieldComponent(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: 350,
                          controller: _fullNameController,
                          labelText: 'Name',
                          obscureText: false,
                          hasError: _nameError != null,
                          errorText: _nameError,
                        ),

                        // ? Space between next widget
                        const SizedBox(height: 20),

                        // ? Email Textfield
                        TextFieldComponent(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: 350,
                          controller: _emailController,
                          labelText: 'Email',
                          obscureText: false,
                          hasError: _emailError != null,
                          errorText: _emailError,
                        ),
                        // ? Space between next widget
                        const SizedBox(height: 20),

                        // ? Password Textfield
                        TextFieldComponent(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 350,
                          controller: _passwordController,
                          labelText: 'Password',
                          obscureText: true,
                          hasError: _passwordError != null,
                          errorText: _passwordError,
                        ),

                        // ? Space between next widget
                        const SizedBox(height: 20),

                        // ? Confirm Password Textfield
                        TextFieldComponent(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: 350,
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          obscureText: true,
                          hasError: _confirmPasswordError != null,
                          errorText: _confirmPasswordError,
                        ),
                        // ? Space between next widget
                        const SizedBox(height: 15),
                        // ? Checkbox + T&Cs
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (newBool) {
                                setState(() {
                                  isChecked = newBool;
                                  isError = false;
                                });
                              },
                              side: BorderSide(
                                width: 0.8,
                                // Change checkbox color based on error status
                                color: isError ? niftiPink : niftiGrey,
                              ),
                              activeColor: niftiLightBlue,
                            ),
                            // T&Cs Prompt Text & Modal
                            InkWell(
                              onTap: () {
                                // Show the Terms & Conditions bottom sheet
                                showBottomSheet();
                              },
                              child: Row(
                                children: [TextDisplay(
                                color: isError ? niftiPink : niftiGrey,
                                text:
                                    'I agree to Nifti\'s',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              TextDisplay(
                                color: isError ? niftiPink : niftiLightBlue,
                                text:
                                    ' Privacy Policy and Conditions',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),],
                              )
                            ),
                          ],
                        ),

                        // Space
                        const SizedBox(height: 20),

                        // ? Clear & Confirm Buttons
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // ? Cancel
                            CTACancelButton(
                              onTap: widget.onTap,
                            ),

                            const SizedBox(
                              width: 25,
                            ),
                            // ? Confirm
                            CTAConfirmButton(
                                text: 'CONFIRM',
                                onTap: () {
                                  // ? Validate the form using the _formKey
                                  if (_formKey.currentState!.validate()) {
                                    // Name
                                    bool isNameValid = validateAndHandleError(
                                        _fullNameController.text,
                                        emptyNameErrorMessage,
                                        (error) =>
                                            setState(() => _nameError = error));
                                    // Email
                                    bool isEmailValid = validateAndHandleError(
                                        _emailController.text,
                                        emptyEmailErrorMessage,
                                        (error) => setState(
                                            () => _emailError = error));

                                    // Password
                                    bool isPasswordValid =
                                        validateAndHandleError(
                                            _passwordController.text,
                                            emptyPasswordErrorMessage,
                                            (error) => setState(
                                                () => _passwordError = error));

                                    // Confirm Password
                                    bool isConfirmPasswordValid =
                                        validateAndHandleError(
                                            _confirmPasswordController.text,
                                            emptyConfirmPasswordErrorMessage,
                                            (error) => setState(() =>
                                                _confirmPasswordError = error));

                                    bool arePasswordsMatching = passwordsMatch(
                                        _passwordController.text,
                                        _confirmPasswordController.text,
                                        passwordsNotMatchingErrorMessage,
                                        (error) => setState(() =>
                                            _confirmPasswordError = error));

                                    // Check if the "Terms & Conditions" checkbox is checked
                                    if (isChecked == false) {
                                      // Display an error message or take appropriate action
                                      setState(() {
                                        isError = true;
                                      });
                                      const Text(
                                          'Please agree to the Terms & Conditions');
                                      return; // Exit the registration process
                                    }

                                    // If all fields are valid == proceed with registration
                                    if (isNameValid &&
                                        isEmailValid &&
                                        isPasswordValid &&
                                        isConfirmPasswordValid &&
                                        arePasswordsMatching) {
                                      register();
                                    }
                                  }
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ])),
          ]),
        )));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *

  // ? PRIVACY POLICY / CONDITIONS MODAL
  void showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          //padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            //width: 400,
            height: 1720,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextDisplay(
                  text: 'Privacy Policy and Conditions',
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(height: 12),
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'Welcome to Nifti, a social contacts app designed to help you connect easily. Protecting your privacy and ensuring a fair user experience are important to us. This Privacy Policy and Conditions document explains how we collect, use, and protect your personal information and the terms and conditions you agree to when using the app.'),
                ),
                const SizedBox(height: 12),
                const TextDisplay(
                  text: 'Last Updated: 27 October, 2023',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                // ? Space & Divider
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1,
                  color: niftiLightBlue,
                ),
                const SizedBox(
                  height: 5,
                ),
                // ? One
                const TextDisplay(
                  text: '1. Acceptance of Terms',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // ? Space & Divider
                const SizedBox(
                  height: 5,
                ),
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'By downloading, accessing, or using the Nifti app, you accept and agree to be bound by these Terms & Conditions and Privacy Policy. If you do not agree with any part of these terms, please refrain from using the app.'),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ? Two
                // Title
                const TextDisplay(
                  text: '2. User Registration',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'You agree to provide accurate and complete information during the registration process. It is your responsibility to maintain the confidentiality of your account details and to keep your PIN secure.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 3
                // Title
                const TextDisplay(
                  text: '3. Privacy',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'Your use of the app is also governed by our Privacy Policy, which outlines how we collect, use, and disclose your personal information. Please review our Privacy Policy for more details.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 4
                // Title
                const TextDisplay(
                  text: '4. Information We Collect',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'User Profile: We collect the information you provide, such as your name, photo, contact info, current work/study, and social links.'),
                ),
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'Usage Data: We collect data about your interactions with the app, including usage patterns, IP address, and device information.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 5
                // Title
                const TextDisplay(
                  text: '5. How We Use Your Information',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const TextDisplay(
                    fontSize: 13,
                    text:
                        'We use your information for the following purposes:'),
                const TextDisplay(
                    fontSize: 13,
                    text: '- To create and maintain your Nifti account.'),
                const TextDisplay(
                    fontSize: 13,
                    text: '- To facilitate connections between users.'),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 6
                // Title
                const TextDisplay(
                  text: '6. Data Security',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'We take data security seriously. Your information is securely stored in Firebase, and we implement measures to protect your data from unauthorized access.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 7
                // Title
                const TextDisplay(
                  text: '7. User Conduct',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'You must use Nifti in compliance with all applicable laws and regulations. You agree not to engage in any activity that may harm, disrupt, or interfere with the app\'s operation or the experience of other users.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 8
                // Title
                const TextDisplay(
                  text: '8. Third-Party Services',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'Nifti may use third-party services, such as Firebase, to provide its features. These services have their own privacy policies, and your use of Nifti implies acceptance of these policies.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 9
                // Title
                const TextDisplay(
                  text: '9. Your Choices',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'You can update or delete your personal information within the app at any time.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 10
                // Title
                const TextDisplay(
                  text: '10. Disclaimers',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'Nifti is provided "as-is" without any warranties. We do not guarantee the accuracy, reliability, or availability of the app. You use it at your own risk.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 11
                // Title
                const TextDisplay(
                  text: '11. Termination',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'We reserve the right to terminate or suspend your account at our discretion for any reason, without prior notice.'),
                ),
                // Space
                const SizedBox(
                  height: 15,
                ),
                // ? 12
                // Title
                const TextDisplay(
                  text: '12. Changes to Privacy Policy and Terms',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const Expanded(
                  flex: 0,
                  child: TextDisplay(
                      fontSize: 13,
                      text:
                          'We may update this Privacy Policy and Terms & Conditions from time to time. You will be notified of any changes. Continued use of the app after updates constitutes acceptance of the new terms.'),
                ),
                // ? Space & Divider
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: niftiLightBlue,
                ),
                // Space
                const SizedBox(
                  height: 10,
                ),
                // Title
                const TextDisplay(
                  text: 'Thank you for using Nifti!',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                // Space
                const SizedBox(
                  height: 5,
                ),
                // Content
                const TextDisplay(fontSize: 13, text: 'The Nifti Team'),
                const TextDisplay(
                    fontSize: 13, text: 'Christchurch, New Zealand'),
                // Space
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  } // End of terms of conditions
}
// * ---------------- * END OF (STATE) CLASS _RegisterPageState (STATE) * ---------------- *


