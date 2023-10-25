import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nifti_locapp/components/app_theme.dart';

// ? FRONT END FUNCTIONS

// * ---------------- * (displayErrorMessage) * ---------------- *
// ? Error Message Snackbar Function
void displayErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    margin: EdgeInsets.only(left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
      // ? Inner padding for SnackBar content.
      padding: const EdgeInsets.all(15),
      backgroundColor: niftiWhite,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: niftiPink, width: 1.5),
        borderRadius:const BorderRadius.only(topLeft: Radius.circular(1), topRight: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30),),
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
