import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/button.dart';
import 'package:nifti_locapp/components/text_field.dart';
import 'package:nifti_locapp/functions/functions.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

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

  //Login Method
  Future login() async {
    // Sign in check
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      displayErrorMessage(context, error.message!);
    }
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

                      //Email Textfield
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
                      ButtonComponent(onTap: login, text: 'LOGIN'),
                      // Space between next widget
                      const SizedBox(height: 30),

                      // Register button
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
}