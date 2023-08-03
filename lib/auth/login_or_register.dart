import 'package:flutter/material.dart';
import 'package:nifti_locapp/pages/login_page.dart';
import 'package:nifti_locapp/pages/register_page.dart';

/* * ---------------- * (STATEFUL WIDGET) CLASS LoginOrRegister (STATEFUL WIDGET) * ---------------- * */
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}
/* * ---------------- * END OF (STATEFUL WIDGET) CLASS LoginOrRegister (STATE) * ---------------- * */

/* * ---------------- * (STATE) CLASS _LoginOrRegisterState (STATE) * ---------------- * */
class _LoginOrRegisterState extends State<LoginOrRegister> {
  // ? Initially show login page
  bool showLoginPage = true;

  // ? Toggle Method - Either show login or registration page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  /* * ---------------- * (BUILD WIDGET) * ---------------- * */
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    }
    else{
      return RegisterPage(onTap: togglePages);
    }
  }
  /* * ---------------- * END OF (BUILD WIDGET) * ---------------- * */
}
/* * ---------------- * END OF (STATE) CLASS _LoginOrRegisterState (STATE) * ---------------- * */
