import "package:flutter/material.dart";
import 'package:nifti_locapp/components/contact_card.dart';
import 'package:nifti_locapp/components/button.dart';
import 'package:nifti_locapp/components/contact_list_display.dart';


//Contact List Page
class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          child: Column(children: [
            const SizedBox(height: 10,),
             ButtonComponent(
              color: Colors.cyan,
              text: 'Bottom Sheet',
              onTap: () {
                displayModalBottomSheet(context);
              },
             ),
             // space between
             const SizedBox(height: 5,),
             const ListDisplay(),
             //const ListDisplay(firstName: 'Dylan', lastName: 'Sash', role: 'BC Marketing', email: 'dylan.sash@gmail.com'),
             ]),
        ),);  
  }
}