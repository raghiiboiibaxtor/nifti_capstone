import "package:flutter/material.dart";
import 'package:nifti_locapp/components/contact_card.dart';
import 'package:nifti_locapp/components/button.dart';

//Contact List Page
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
            height: 50,
            child: ButtonComponent(
              color: Colors.cyan,
              text: 'Bottom Sheet',
              onTap: () {
                displayModalBottomSheet(context);
              },
            )));
  }
}
