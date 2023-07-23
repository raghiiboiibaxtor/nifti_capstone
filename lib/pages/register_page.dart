import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/gradient_text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Controllers - used to access the user's input
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _contactNumberController = TextEditingController();
  final _pronouns = TextEditingController();
  final _profilePicture = TextEditingController();
  final _bio = TextEditingController();
  //final _socialLink = TextEditingController();
  final _roleTitle = TextEditingController();
  final _industry = TextEditingController();
  final _companyName = TextEditingController();
  final _timeWorked = TextEditingController();

  // Variables
  int currentStep = 0;

  // ? Dispose controllers when not using for memory management
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      // Registration Check
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        // pop loading circle
        Navigator.pop(context);
        displayErrorMessage(context, error.message!);
      }

      // ? Adds user info to Firestore
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
      );
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
                    
                    const Text('Welcome to Nifti!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600, 
                    ),),
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
                          hintText: 'First Name',
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
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),

                    //Password Textfield
                    GradientTextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        width: 350,
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: true),
                    // Space between next widget
                    const SizedBox(height: 20),

                    // Confirm Password Textfield
                    GradientTextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        width: 350,
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true),
                    // Space between next widget
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            )),

        // ? Second Step == Account Details (First Name, Last Name, Email, Password)
        Step(
            isActive: currentStep >= 1,
            state: currentStep <= 1 ? StepState.editing : StepState.complete,
            title: const Text('Create Profile'),
            content: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  // Personal prompt
                  const Text('A little about you...                                                  ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400, 
                    ),),
                    // Space between next widget
                    const SizedBox(height: 20),
      
                    
                    Row(
                      children: [
                        // Profile Picture
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 0),
                          width: 150,
                          controller: _profilePicture,
                          hintText: 'Image',
                          obscureText: false,
                        ),
                        // Pronouns 
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 20.0),
                          width: 170,
                          controller: _pronouns,
                          hintText: 'Pronouns',
                          obscureText: false,
                        ),
                      ],
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),

                    //Bio Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 350,
                      controller: _bio,
                      hintText: 'Bio',
                      obscureText: false,
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),
                    
                    //Contact Number Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 350,
                      controller: _contactNumberController,
                      hintText: 'Contact Number',
                      obscureText: false,
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),

                    /*//Social Media Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 350,
                      controller: _socialLink,
                      hintText: 'URL',
                      obscureText: false,
                    ),
                    // Space between next widget
                    const SizedBox(height: 20),*/

                    // Role prompt
                    const Text('...and your current role                                            ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400, 
                    ),),
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
                          width: 230,
                          controller: _companyName,
                          hintText: 'Place of Work/Study',
                          obscureText: false,
                        ),
                        // Work Time
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 20.0),
                          width: 90,
                          controller: _timeWorked,
                          hintText: 'Years',
                          obscureText: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ];

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
        body: Theme(
          data: ThemeData(
            // canvasColor: const Color.fromRGBO(252, 250, 245, 1),
            //scaffoldBackgroundColor: const Color.fromRGBO(252, 250, 245, 1),
            shadowColor: Colors.transparent,
            colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(115, 142, 247, 1)),
            // gradient: const LinearGradient(colors: [Color.fromRGBO(209, 147, 246, 1), Color.fromRGBO(115, 142, 247, 1), Color.fromRGBO(116, 215, 247, 1)]),
            fontFamily: 'Montserrat',
          ),
          child: Stepper(
            steps: stepList(),
            currentStep: currentStep,
            // ? Changes to next step
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
            // ? Changes to previous step
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
            type: StepperType.horizontal,
          ),
        ));
  }
}

/*
 child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nifti Logo
                      const Image(
                          image: AssetImage('images/nifti_logo_white.png')),

                      // Name prompt
                      Row(
                        children: [
                          // First name
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(252, 250, 245, 1),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextField(
                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'First Name',
                                    contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    )),
                                style: const TextStyle(
                                fontSize: 15,)
                            ),
                            ),
                          ),
                          // Last name
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, right: 25.0),
                            child: Container(
                              width: 168,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(252, 250, 245, 1),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Last Name',
                                    contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    )),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Space between next widget
                      const SizedBox(height: 20),

                      //Email Textfield
                      TextFieldComponent(
                        controller: _emailController, 
                        hintText: 'Email', 
                        obscureText: false,
                        ),
                      // Space between next widget
                      const SizedBox(height: 20),

                      //Password Textfield
                      TextFieldComponent(
                        controller: _passwordController, 
                        hintText: 'Password', 
                        obscureText: true),
                      // Space between next widget
                      const SizedBox(height: 20),

                      // Confirm Password Textfield
                      TextFieldComponent(
                        controller: _confirmPasswordController, 
                        hintText: 'Confirm Password', 
                        obscureText: true),
                      // Space between next widget
                      const SizedBox(height: 25),

                      // Register Button
                      ButtonComponent(onTap: register, text: 'REGISTER'),
                      // Space between next widget
                      const SizedBox(height: 30),

                      // Login prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Color.fromRGBO(252, 250, 245, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromRGBO(79, 219, 245, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 0.5),
                            ),
                          )
                        ],
                      )
                    ],
                  ), */
