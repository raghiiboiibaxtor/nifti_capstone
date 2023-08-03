import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

//User's Profile Page
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(currentUser.email!)),
    );
  }
}
