//import 'dart:js_interop';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
/* * ---------------- * END OF PACKAGES * ---------------- * */

/* * ---------------- * BACKEND FUNCTIONS * ---------------- * */

// ? Creating random code for user
class CreateRandom {
  static createRandom() async {
    late String code;
    dynamic secure = Random.secure();
    dynamic secList = List.generate(4, (_) => secure.nextInt(10));
    code = secList
        .toString()
        .replaceAll('[', '')
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .replaceAll(']', '');
    return code;
  }
}

// ! FIRESTORE 🔥 ------------------------------- 🔥
// ! Following functions access FirebaseFirestore * * * * *

// Object created for passing user information between widgets
class UserPincode {
  // ? Definfing and constructing the pincode object
  String pincode;
  UserPincode({required this.pincode});
  set setPincode(String pincode) => pincode; // ? setting pincode
  get getPincode => pincode; // ? getting pincode

  // ? Static getter allowing pincode to be accessed through ui
  static getStaticPincode(String pincode) {
    String staticPin = pincode;
    return staticPin;
  }
}

// Object created for dynamically reading user data from Firestore
class ReadUserData {
  // ? Reading user data from Firestore as map
  static getProfileData() async {
    // ? Instantiating Firestore references
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collectionReference.doc(niftiFireUser).get();
    Map<String, dynamic> data = {};
    if (docSnapshot.exists) {
      data = docSnapshot
          .data()!; // ? Assigning valid snapshot to map and returning object
    }
    return data;
  }

  //  Reading connection data from Firestore using UserPincode object
  static getConnectionData(String pincode) async {
    late Map<String, dynamic> data = {};
    // ? Instantiating Firestore reference
    var collectionReference = FirebaseFirestore.instance.collection('users');
    await collectionReference
        .where("pincode",
            isEqualTo: pincode) // ? Finding the pincode in Firestore
        .get()
        .then((querySnapshot) {
      // ? Grabbing querySnapshot (list of all documents)
      for (var docSnapshot in querySnapshot.docs) {
        data = docSnapshot
            .data(); // ? Assigning valid snapshot to map and returning object
      }
    });
    return data;
  }

  // ? Reading connection data from Firestore using otp
  static getPincodeList() async {
    // ? Instantiating Firestore references
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(niftiFireUser)
            .get();
    late dynamic data = [];
    if (documentSnapshot.exists) {
      final List<dynamic>? codelist = documentSnapshot.data()?[
          'connections']; // ? Copying Firestore connections data into array
      if (codelist != null) {
        data =
            codelist; // ? Assigning dynamic List into array so that data is easily extracted
      } else {
        data = [
          'Sorry! We cant find this connection. Please try again later :)'
        ];
      }
    } else {
      data = ['You have no connections'];
    }
    return data;
  }
} // END OF ReadUserData object

// Object created for dynamically adding user data to Firestore
class StoreUserData {
  // ? Instantiating Firestore references
  String userRef = '';
  final _collectionReference = FirebaseFirestore.instance.collection('users');
  final _niftiFireUser = FirebaseAuth.instance.currentUser?.uid;

  // ? Add user info to Firestore
  Future addUserDetails(
    // ? Listing required variables to be added
    String firstName,
    String lastName,
    String email,
    String city,
    String pronouns,
    Uint8List profileImage,
    String bio,
    String role,
    String industry,
    String company,
    String yearsWorked,
    String code,
    String userID,
  ) async {
    // ? Error variable
    String response = "Error Occured";
    try {
      // ? Trying to set the document
      await _collectionReference.doc(_niftiFireUser).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'city/town': city,
        'pronouns': pronouns,
        'imageLink': '',
        'bio': bio,
        'role': role,
        'industry': industry,
        'company': company,
        'yearsWorked': yearsWorked,
        'pincode': code,
        'userID': _niftiFireUser,
      });
      response = 'Success';
    } catch (error) {
      // ? Error catch
      response = error.toString();
    }
    return response;
  }

  // ? Appending Firestore document data
  static updateConnectionsPincode(String pincode) async {
    // ? Instantiating Firestore references
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    String pin = await UserPincode.getStaticPincode(
        pincode); // ? Ensuring we grab the correct pincode by accessing the static pincode getter
    try {
      late dynamic code = [];
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await collectionReference
              .doc(niftiFireUser)
              .get(); // ? Grabbing the user document

      if (docSnapshot.exists) {
        final List<dynamic>? snapshot = docSnapshot.data()?[
            'connections']; // ? Duplicating the 'connections' array from user firestore document

        if (snapshot!.isEmpty) {
          await collectionReference.doc(niftiFireUser).update({
            'connections': FieldValue.arrayUnion([pin])
          });
        } else {
          for (int i = 0; i < (snapshot.length + 1); i++) {
            if (snapshot.contains(pin)) {
              // ? do nothing;
              code = [...snapshot];
            } else {
              code = [
                ...snapshot,
                pin
              ]; // ? Copying the existing data and adding the new pincode to the array
            }
          }
          await collectionReference.doc(niftiFireUser).update({
            'connections':
                code, // ? Pushing the new array for appending within the desired firestore document
          });
        }
      } else {}
    } catch (e) {
      // ? Catching errors
      return "Sorry! Error adding connection.";
    }
  }

// ! FIREBASE-STORAGE 🔥💿 ------------------------------------------- 💿🔥
// ! Following functions target FirebaseStorage (media database) * * * * *

  // ? Update Add profile image to storage
  Future addUserImage(Uint8List file) async {
    // ? Reference points to object in memory
    // ignore: unused_local_variable
    Reference ref =
        FirebaseStorage.instance.ref().child(_niftiFireUser.toString());
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // ? Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('profileImage');

    // ? UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // ? TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ? Update ImageUrl in firestore (change profile picture)
  Future updateFirestoreImageLink(Uint8List file) async {
    // ? this relies on the userImage being added to storage
    String imageUrl = await addUserImage(file);
    var docRef = _collectionReference.doc(_niftiFireUser);
    docRef.update({
      'imageLink': imageUrl,
    });
  }
}

// ? Adding User Details to FireStore & Storage
class StoreUserImages {
  final _collectionReference = FirebaseFirestore.instance.collection('users');
  final _niftiFireUser = FirebaseAuth.instance.currentUser?.uid;

  // ? Update Add profile image to storage
  Future addBannerImage(Uint8List file) async {
    // ? Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // ? Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('banner');
    // ? UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // ? TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ? Update Add profile image to storage
  Future addSquare1Image(Uint8List file) async {
    // ? Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // ? Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('square1');
    // ? UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // ? TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future addSquare2Image(Uint8List file) async {
    // ? Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // ? Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('square2');
    // ? UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // ? TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future addSquare3Image(Uint8List file) async {
    // ? Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // ? Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('square3');
    // ? UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // ? TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ? Update ImageUrl in firestore
  Future updateFirestoreImageLinks(
    Uint8List banner,
    Uint8List square1,
    Uint8List square2,
    Uint8List square3,
  ) async {
    // ? This relies on the userImage being added to storage
    String bannerUrl = await addBannerImage(banner);
    String square1Url = await addSquare1Image(square1);
    String square2Url = await addSquare2Image(square2);
    String square3Url = await addSquare3Image(square3);
    var docRef = _collectionReference.doc(_niftiFireUser);
    docRef.update({
      'bannerImageLink': bannerUrl,
      'square1ImageLink': square1Url,
      'square2ImageLink': square2Url,
      'square3ImageLink': square3Url,
    });
  }
}
// ! END OF FIREBASE RELATED FUNCTIONS 🔥 ------------------------------ 🔥

// * * --------------------------------- * END OF BACKEND FUNCTIONS * ---------------------- * */
