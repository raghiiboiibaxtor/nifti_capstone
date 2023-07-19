import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/text_field.dart';
import 'package:nifti_locapp/components/button.dart';
import 'package:nifti_locapp/functions/functions.dart';

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

  // Dispose controllers when not using for memory management
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Matching passwords check
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      displayErrorMessage(context, 'Passwords don\'t match. Please try again.');
      return false;
    }
  }

  // Register Method
  Future register() async {
    // create user

    if (passwordConfirmed()) {
      // Registration Check
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      } on FirebaseAuthException catch (error) {
      displayErrorMessage(context, error.message!);
      }
      
      
      // add user details
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
      );
    }
  }

  Future addUserDetails(String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background_gradient.png'),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
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
                  ),
                ),
              ),
            )));
  }
}
