import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Error Message Snackbar Function
void displayErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(99, 145, 255, 1)),
      ),
      duration: const Duration(seconds: 8),
      width: 300.0, // Width of the SnackBar.
      padding: const EdgeInsets.all(
        10.0, // Inner padding for SnackBar content.
      ),
      backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      )));
}

// Loading Circle Animation Function
void displayLoadingCircle(BuildContext context,){
  showDialog(context: context, 
  builder: (context) => const Center(
    child: CircularProgressIndicator(),
  ),);
}

// Adding User Details to FireStore
Future addUserDetails(String firstName, String lastName, String email, String contactNumber, String pronouns, String profilePicure, String bio, String role, String industry, String company, String yearsWorked ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'contact number': contactNumber,
      'pronouns': pronouns, 
      'profile picture': profilePicure,
      'bio': bio,
      'role': role,
      'industry': industry,
      'company': company,
      'years worked': yearsWorked,
    });
}