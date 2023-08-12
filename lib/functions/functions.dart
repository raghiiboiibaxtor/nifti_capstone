//import 'dart:js_interop';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

/* * ---------------- * BACKEND * ---------------- * */
// ! FIREBASE 🔥 ------------------------------- 🔥

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
    // ignore: unused_local_variable
    Reference ref =
        FirebaseStorage.instance.ref().child(_niftiFireUser.toString());
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory =
        referenceRoot.child(_niftiFireUser.toString());
    // Create reference for image storage
    Reference referenceImageUpload = referenceDirectory.child('profileImage');

    // UploadTask upload data to remote storage
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

class ReadUserData {
  String firstName;
  String lastName;
  String email;
  String city;
  String pronouns;
  Uint8List profileImage;
  String bio;
  String role;
  String industry;
  String company;
  String yearsWorked;
  String code;

  ReadUserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.pronouns,
    required this.profileImage,
    required this.bio,
    required this.role,
    required this.industry,
    required this.company,
    required this.yearsWorked,
    required this.code,
  });

  static readUserCode() async {
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collectionReference.doc(niftiFireUser).get();
    var code = '';
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      code = data['pincode']; // Targeting pincode var read
    }
    return code;
  }

  static readMyProfile() async {
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collectionReference.doc(niftiFireUser).get();
    var code = '';
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      code = data.toString(); // Targeting pincode var read
    }
    return code;
  }

  static getProfileData() async {
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collectionReference.doc(niftiFireUser).get();
    //late dynamic connection;
    Map<String, dynamic> data = {};
    //late var j = '';
    if (docSnapshot.exists) {
      data = docSnapshot.data()!;
    }
    return data;
  }
}

class CreateUserJson {
  String firstName;
  String lastName;
  String email;
  String city;
  String pronouns;
  Uint8List profileImage;
  String bio;
  String role;
  String industry;
  String company;
  String yearsWorked;
  String code;

  CreateUserJson({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.pronouns,
    required this.profileImage,
    required this.bio,
    required this.role,
    required this.industry,
    required this.company,
    required this.yearsWorked,
    required this.code,
  });

  factory CreateUserJson.fromSnapshot(DocumentSnapshot docSnapshot) {
    return CreateUserJson(
      firstName: docSnapshot.get('firstName'),
      lastName: docSnapshot.get('lastName'),
      email: docSnapshot.get('email'),
      city: docSnapshot.get('city'),
      pronouns: docSnapshot.get('pronouns'),
      profileImage: docSnapshot.get('profileImage'),
      bio: docSnapshot.get('bio'),
      role: docSnapshot.get('role'),
      industry: docSnapshot.get('industry'),
      company: docSnapshot.get('company'),
      yearsWorked: docSnapshot.get('yearsWorked'),
      code: docSnapshot.get('code'),
    );
    // connection = data;

    /*connection = ReadUserData(
          firstName: firstName,
          lastName: lastName,
          email: email,
          city: city,
          pronouns: pronouns,
          profileImage: profileImage,
          bio: bio,
          role: role,
          industry: industry,
          company: company,
          yearsWorked: yearsWorked,
          code: code) as Map<String, dynamic>;*/
  }

  static findConnection() async {
    final niftiFireUser = FirebaseAuth.instance.currentUser?.uid;
    var collectionReference = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collectionReference.doc(niftiFireUser).get();
    Map<String, dynamic> connection = {};
    //late var j = '';
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      connection = data;
    }
    return connection;
  }
}

// ! FIREBASE 🔥 ------------------------------ 🔥

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

/* * ---------------- * BACKEND * ---------------- * */


// ? Select profile image functions
pickImage() async {
  final picker = ImagePicker();
  XFile? selectedFile = await picker.pickImage(source: ImageSource.gallery);
  if (selectedFile != null) {
    return await selectedFile.readAsBytes();
  }
}

/* * ---------------- * FRONTEND * ---------------- * */

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
