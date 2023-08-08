import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

// ? Error Message Snackbar Function
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

// ? Loading Circle Animation Function
void displayLoadingCircle(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

// ? Adding User Details to FireStore & Storage
class StoreUserData {
  String userRef = '';
  final _collectionReference = FirebaseFirestore.instance.collection('users');
  final _niftiFireUser = FirebaseAuth.instance.currentUser?.uid;

  // ? Add user info to Firestore
  Future addUserDetails(
      String firstName,
      String lastName,
      String email,
      String city,
      String pronouns,
      Uint8List profileImage,
      Uint8List bannerImage,
      Uint8List squareImage1,
      Uint8List squareImage2,
      Uint8List squareImage3,
      String bio,
      String role,
      String industry,
      String company,
      String yearsWorked) async {
    // Error Variable
    String response = "Error Occured";
    try {
      await _collectionReference.doc(_niftiFireUser).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'city/town': city,
        'pronouns': pronouns,
        'imageLink': '',
        'bannerImageLink': '',
        'squareImage1Link': '',
        'squareImage2Link': '',
        'squareImage3Link': '',
        'bio': bio,
        'role': role,
        'industry': industry,
        'company': company,
        'yearsWorked': yearsWorked,
      });
      response = 'Success';
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  // ? Update Add profile image to storage
  Future addUserImage(Uint8List file) async {
    // Reference points to object in memory
    Reference ref = FirebaseStorage.instance.ref().child(_niftiFireUser.toString());
    //userRef = users.id;
    // UploadTask upload data to remote storage
    UploadTask uploadTask = ref.putData(file);
    // TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ? Update ImageUrl in firestore
  Future updateFirestoreImageLink(Uint8List file) async {
    // this relies on the userImage being added to storage
    String imageUrl = await addUserImage(file);
    var docRef = _collectionReference.doc(_niftiFireUser);
    docRef.update({
      'imageLink': imageUrl,
    });
  }
}

// ? Select profile image functions
pickImage() async {
  final picker = ImagePicker();
  XFile? selectedFile = await picker.pickImage(source: ImageSource.gallery);
  if (selectedFile != null) {
    return await selectedFile.readAsBytes();
  }
}

