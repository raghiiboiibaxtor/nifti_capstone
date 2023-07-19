import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nifti_locapp/components/text_field.dart';

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
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(252, 250, 245, 1),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                            controller: _profilePicture,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'First Name',
                                contentPadding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                )),
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                      ),
                    ),
                    // Last name
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 25.0),
                      child: Container(
                        width: 168,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(252, 250, 245, 1),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(25)),
                        child: TextField(
                          controller: _pronouns,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name',
                              contentPadding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              )),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Space between next widget
                const SizedBox(height: 20),

                //Email Textfield
                TextFieldComponent(
                  controller: _contactNumberController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                // Space between next widget
                const SizedBox(height: 20),

                //Password Textfield
                TextFieldComponent(
                    controller: _socialLink,
                    hintText: 'Password',
                    obscureText: true),
                // Space between next widget
                const SizedBox(height: 20),

                // Confirm Password Textfield
                TextFieldComponent(
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