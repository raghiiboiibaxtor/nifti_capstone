import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nifti_locapp/auth/auth.dart';

/* * ---------------- * MAIN FUNCTION * ---------------- * */
void main() async {
  // Access to native code
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/* * ---------------- * CLASS MY APP * ---------------- * */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromRGBO(252, 250, 245, 1),
        ),
        fontFamily: 'Montserrat',
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}
