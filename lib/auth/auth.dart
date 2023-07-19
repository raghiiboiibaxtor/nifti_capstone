import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:nifti_locapp/auth/login_or_register.dart';
import 'package:nifti_locapp/widget_tree.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const WidgetTree(); 
        } else {
          return const LoginOrRegister();
        }
      },
      ),
    );
  }
}