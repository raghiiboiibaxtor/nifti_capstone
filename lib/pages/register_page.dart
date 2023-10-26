import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/text_display.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/functions/frontend.dart';
import 'package:nifti_locapp/components/gradient_text_field.dart';
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
      //StoreUserData().addUserImage(_profileImage!);
      //StoreUserData().updateFirestoreImageLink(_profileImage!);
    }
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
              height: 180,
              child: Image(image: AssetImage('images/nifti_logo_white.png')),
            ),
            // White container
            Container(
                height: 624,
                width: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: niftiOffWhite,
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(50))),
                child: Stack(children: [
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
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          width: 360,
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
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          width: 360,
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
                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          width: 350,
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          obscureText: true,
                          hasError: _confirmPasswordError != null,
                          errorText: _confirmPasswordError,
                        ),
                        // ? Space between next widget
                        const SizedBox(height: 15),

                        const TextDisplay(
                          text:
                              '[   ] Agree to Nifti\'s Terms & Conditions and Privacy Policy',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),

                        const SizedBox(height: 25),

                        // ? Clear & Confirm Buttons
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // ? Cancel
                            CTACancelButton(
                              onTap: widget.onTap,
                            ),

                            const SizedBox(
                              width: 6,
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
                                    bool isPasswordValid = validateAndHandleError(
                                        _passwordController.text,
                                        emptyPasswordErrorMessage,
                                        (error) => setState(
                                            () => _passwordError = error));

                                    // Confirm Password
                                    bool isConfirmPasswordValid = validateAndHandleError(
                                        _confirmPasswordController.text,
                                        emptyConfirmPasswordErrorMessage,
                                        (error) => setState(
                                            () => _confirmPasswordError = error));

                                    // If all fields are valid == proceed with registration
                                    if (isNameValid && isEmailValid && isPasswordValid && isConfirmPasswordValid) {
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
}
// * ---------------- * END OF (STATE) CLASS _RegisterPageState (STATE) * ---------------- *

