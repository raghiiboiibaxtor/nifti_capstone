import 'package:flutter/material.dart';
import 'package:nifti_locapp/pages/login_page.dart';
import 'package:nifti_locapp/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle Method
  void toggelPages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: toggelPages);
    }
    else{
      return RegisterPage(onTap: toggelPages);
    }
  }
}