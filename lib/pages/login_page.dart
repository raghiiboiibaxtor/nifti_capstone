import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/button.dart';
import 'package:nifti_locapp/components/text_field.dart';
import 'package:nifti_locapp/functions/functions.dart';

/* * ---------------- * (STATEFUL WIDGET) CLASS LoginPage (STATEFUL WIDGET) * ---------------- * */
class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
/* * ---------------- * END OF (STATE) CLASS RegisterPage (STATE) * ---------------- * */

/* * ---------------- * (STATE) CLASS _LoginPageState (STATE) * ---------------- * */
class _LoginPageState extends State<LoginPage> {
  // Text Controllers - used to access the user's input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Dispose controllers when not using for memory management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ? Email & Password Login Method
  Future login() async {
    // Loading Animation
    displayLoadingCircle(context);
    
    // Sign in check
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // pop loading circle
      if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      // pop loading circle
      Navigator.pop(context);
      // Display error message
      displayErrorMessage(context, error.message!);
    }
  }

  /* * ---------------- * (BUILD WIDGET) * ---------------- * */
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

                      // Email Textfield
                      TextFieldComponent(
                          controller: _emailController,
                          hintText: 'Email',
                          obscureText: false),
                      // Space between next widget
                      const SizedBox(height: 20),

                      //Password Textfield
                      TextFieldComponent(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: true),
                      // Space between next widget
                      const SizedBox(height: 25),

                      // Login Button
                      ButtonComponent(onTap: login, text: 'LOGIN', color: const Color.fromRGBO(79, 219, 245, 1),),
                      // Space between next widget
                      const SizedBox(height: 30),

                      // Register button - Redirects user to registration process
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Color.fromRGBO(252, 250, 245, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Register now',
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
  /* * ---------------- * END OF (BUILD WIDGET) * ---------------- * */
}
/* * ---------------- * END OF (STATE) CLASS _LoginPageState (STATE) * ---------------- * */
