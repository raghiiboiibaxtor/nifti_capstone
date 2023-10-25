import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nifti_locapp/components/app_theme.dart';

// ? FRONT END FUNCTIONS

// * ---------------- * (displayErrorMessage) * ---------------- *
// ? Error Message Snackbar Function
void displayErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    showCloseIcon: true,
    closeIconColor: niftiPink,
      content: Text(
        message,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: niftiPink),
      ),
      duration: const Duration(seconds: 5),
       // ? Width of the SnackBar.
      //width: 340,
      // ? Inner padding for SnackBar content.
      padding: const EdgeInsets.all(15),
      backgroundColor: niftiWhite,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius:BorderRadius.only(topLeft: Radius.circular(1), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),),
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
