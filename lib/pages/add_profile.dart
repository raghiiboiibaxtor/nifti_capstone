/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nifti_locapp/components/gradient_text_field.dart';

//User's Profile Page
class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  /*int contactNumber, String pronouns, Image profilePicure, String bio, 
String socialLink, String roleTitle, String companyName, int timeWorked*/

  // Text Controllers - used to access the user's input
  final _contactNumberController = TextEditingController();
  final _pronouns = TextEditingController();
  final _profilePicture = TextEditingController();
  final _bio = TextEditingController();
  final _socialLink = TextEditingController();
  final _roleTitle = TextEditingController();
  final _companyName = TextEditingController();
  final _timeWorked = TextEditingController();

  // Dispose controllers when not using for memory management
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
      // Top bar that contains Nifti Logo
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
        title: SizedBox(
          width: 100,
          child: Image.asset('images/nifti_logo.png'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Name prompt
                Row(
                  children: [
                    // First name
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.only(left: 25.0),
                      width: 150,
                      controller: _contactNumberController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    // Last name
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      width: 160,
                      controller: _contactNumberController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                  ],
                ),
                // Space between next widget
                const SizedBox(height: 20),

                //Email Textfield
                GradientTextFieldComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  width: 350,
                  controller: _contactNumberController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                // Space between next widget
                const SizedBox(height: 20),

                //Password Textfield
                GradientTextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    width: 350,
                    controller: _socialLink,
                    hintText: 'Password',
                    obscureText: true),
                // Space between next widget
                const SizedBox(height: 20),

                // Confirm Password Textfield
                GradientTextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    width: 350,
                    controller: _bio,
                    hintText: 'Confirm Password',
                    obscureText: true),
                // Space between next widget
                const SizedBox(height: 25),

                // Register Button
                /*ButtonComponent(onTap: (register), text: 'REGISTER'),
                      // Space between next widget
                      const SizedBox(height: 30),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/