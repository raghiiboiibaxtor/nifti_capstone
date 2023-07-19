import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nifti_locapp/auth/auth.dart';

void main() async{
  // Access to native code
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
    
  }
}
