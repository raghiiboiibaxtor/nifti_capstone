//import 'dart:js_interop';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';

/* * ---------------- * BACKEND * ---------------- * */

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

/////\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\\\\\\\\\
// ! FIRESTORE 🔥 ------------------------------- 🔥
//

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

// ? Reading user data
class ReadUserData {
  // ? Reading user data from Firestore as map
  static getProfileData() async {
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collectionReference.doc(niftiFireUser).get();
    Map<String, dynamic> data = {};
    if (docSnapshot.exists) {
      data = docSnapshot.data()!;
    }
    return data;
  }

  // ? Reading connection data from Firestore using otp
  static getConnectionData(String pincode) async {
    // ? Finding the pincode in Firestore
    late Map<String, dynamic> data = {};
    var collectionReference = FirebaseFirestore.instance.collection('users');
    await collectionReference
        .where("pincode", isEqualTo: pincode)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        data = docSnapshot.data();
      }
    });
    return data;
  }

  // ? Reading connection data from Firestore using otp
  static getPincodeList() async {
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(niftiFireUser)
            .get();
    late dynamic data = [];
    if (documentSnapshot.exists) {
      final List<dynamic>? codelist = documentSnapshot.data()?['connections'];
      if (codelist != null) {
        data = codelist;
      } else {
        data = ['not found'];
      }
    } else {
      data = ['not exist'];
    }
    return data;
  }
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
    String bio,
    String role,
    String industry,
    String company,
    String yearsWorked,
    String code,
    String userID,
  ) async {
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
      response = error.toString();
    }
    return response;
  }

  static updateConnectionsPincode(String pincode) async {
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    String pin = await UserPincode.getStaticPincode(pincode);
    try {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await collectionReference.doc(niftiFireUser).get();

      if (docSnapshot.exists) {
        final List<dynamic>? snapshot = docSnapshot.data()?['connections'];

        if (snapshot != null) {
          final code = [...snapshot, pin]; // Add your new element

          await collectionReference.doc(niftiFireUser).update({
            'connections': code,
          });
        }
      } else {}
    } catch (e) {
      //print('Error updating array: $e');
    }

    /*  if (pincode != '') {
      pincode = 'notnull';
      await collectionReference
          .doc(niftiFireUser)
          .update({"connections": pincode});
      return pincode;
    } else {
      return pincode = 'lame';
    }*/
  }

// ! FIREBASE-STORAGE 🔥💿 ------------------------------- 💿🔥

  // ? Update Add profile image to storage
  Future addUserImage(Uint8List file) async {
    // Reference points to object in memory
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

// ? Adding User Details to FireStore & Storage
class StoreUserImages {
  final _collectionReference = FirebaseFirestore.instance.collection('users');
  final _niftiFireUser = FirebaseAuth.instance.currentUser?.uid;

  // ? Update Add profile image to storage
  Future addBannerImage(Uint8List file) async {
    // Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('banner');
    // UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ? Update Add profile image to storage
  Future addSquare1Image(Uint8List file) async {
    // Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('square1');
    // UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future addSquare2Image(Uint8List file) async {
    // Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('square2');
    // UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // TaskSnapshot represents current state of an aync task
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future addSquare3Image(Uint8List file) async {
    // Reference points to object in memory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('square3');
    // UploadTask upload data to remote storage
    UploadTask uploadTask = referenceImageUpload.putData(file);
    // TaskSnapshot represents current state of an aync task
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
    // this relies on the userImage being added to storage
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
// ! FIREBASE 🔥 ------------------------------ 🔥
