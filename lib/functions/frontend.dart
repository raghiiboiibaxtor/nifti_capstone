import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ? FRONT END FUNCTIONS

// * ---------------- * (displayErrorMessage) * ---------------- *
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
      duration: const Duration(seconds: 5),
      width: 300.0, // ? Width of the SnackBar.
      padding: const EdgeInsets.all(
        10.0, // ? Inner padding for SnackBar content.
      ),
      backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      )));
}
// * ---------------- * END OF (displayErrorMessage) * ---------------- *

// * ---------------- * (displayLoadingCircle) * ---------------- *
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
// * ---------------- * END OF (displayLoadingCircle) * ---------------- *

// * ---------------- * (pickImage) * ---------------- *
// ? Select profile image functions
pickImage() async {
  final picker = ImagePicker();
  XFile? selectedFile = await picker.pickImage(source: ImageSource.gallery);
  if (selectedFile != null) {
    return await selectedFile.readAsBytes();
  }
}
// * ---------------- * END OF (pickImage) * ---------------- *
