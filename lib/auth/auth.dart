import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:nifti_locapp/auth/login_or_register.dart';
import 'package:nifti_locapp/widget_tree.dart';


/* * ---------------- * (STATELESS WIDGET) CLASS AuthPage (STATELESS WIDGET) * ---------------- * */
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  /* * ---------------- * (BUILD WIDGET) * ---------------- * */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        // ? Check if user is logged in to the app
        if(snapshot.hasData){
          // Display the app contents if logged in
          return const WidgetTree(); 
        } else {
          // Display the Login/Register pages if not logged in
          return const LoginOrRegister();
        }
      },
      ),
    );
  }
  /* * ---------------- * END OF (BUILD WIDGET) * ---------------- * */
}
/* * ---------------- * END OF (STATELESS WIDGET) CLASS AuthPage (STATELESS WIDGET) * ---------------- * */
