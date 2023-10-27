import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nifti_locapp/components/app_theme.dart';

// ? FRONT END FUNCTIONS

// * ---------------- * (displayErrorMessage) * ---------------- *
// ? Error Message Snackbar Function
void displayErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      showCloseIcon: true,
      closeIconColor: niftiPink,
      content: Text(
        message,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: niftiPink),
      ),
      duration: const Duration(seconds: 5),
      // ? Inner padding for SnackBar content.
      padding: const EdgeInsets.all(15),
      backgroundColor: niftiWhite,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: niftiPink, width: 1.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(1),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      )));
}
// * ---------------- * END OF (displayErrorMessage) * ---------------- *

// * ---------------- * (Text Field Error Messages) * ---------------- *
// ? Defined error messages
const String emptyNameErrorMessage = 'Please enter your name';
const String emptyEmailErrorMessage = 'Please enter your email';
const String emptyPasswordErrorMessage = 'Please enter a password';
const String emptyConfirmPasswordErrorMessage = 'Please confirm your password';
const String passwordsNotMatchingErrorMessage = 'Passwords do not match';
const String invalidEmailFormat = 'Invalid email format';
const String emailInUse = 'This email is already in use';
const String weakPassword = 'Password must be 6+ characters';

// ? Check if fields are empty
bool validateAndHandleError(
    String fieldValue, String? errorMessage, Function(String?) setError) {
  if (fieldValue.isEmpty) {
    // Setting error message
    setError(errorMessage);
    return false;
  }
  // Clear the error message if the field is no longer empty
  setError(null);
  return true;
}

// ? Match required fields
bool passwordsMatch(String fieldValue, String fieldValue2, String? errorMessage,
    Function(String?) setError) {
  if (fieldValue != fieldValue2) {
    // Setting error message
    setError(errorMessage);
    return false;
  }
  // Clear the error message if the field is valid
  setError(null);
  return true;
}

// ? Check email format (based on Firebase Auth Error code)
bool emailFormatError(
    String fieldValue, String? errorMessage, Function(String?) setError) {
  // Setting error message
  setError(errorMessage);
  return false;
}

// ? Check password format (based on Firebase Auth Error code)
bool passwordFormatError(
    String fieldValue, String? errorMessage, Function(String?) setError) {
  // Setting error message
  setError(errorMessage);
  return false;
}

// ? Check if email is in use (based on Firebase Auth Error code)
bool emailInUseError(
    String fieldValue, String? errorMessage, Function(String?) setError) {
  // Setting error message
  setError(errorMessage);
  return false;
}
// * ---------------- * END OF (Text Field Error Messages) * ---------------- *

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
