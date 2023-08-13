import "package:flutter/material.dart";
import 'package:nifti_locapp/components/connection_modal.dart';
import 'package:nifti_locapp/components/button.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/contact_list_display.dart';

//Contact List Page
class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String pincode = '7128';
  late Map<String, Object?> friend = {};
  _getConnectionData() async {
    friend = await ReadUserData.getConnectionData(pincode);
    setState(() {});
    return friend;
  }

  @override
  void initState() {
    _getConnectionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          ButtonComponent(
            color: Colors.cyan,
            text: 'Bottom Sheet',
            onTap: () {
              displayModalBottomSheet(
                context,
                '${friend['firstName']}' ' ${friend['lastName']}',
                '${friend['bio']}',
                '${friend['pronouns']}',
                '${friend['industry']}',
                '${friend['city/town']}',
                '${friend['role']}',
                '${friend['company']}',
                '${friend['yearsWorked']}',
              );
            },
          ),
          // space between
          const SizedBox(
            height: 5,
          ),
          const ListDisplay(),
          //const ListDisplay(firstName: 'Dylan', lastName: 'Sash', role: 'BC Marketing', email: 'dylan.sash@gmail.com'),
        ]),
      ),
    );
  }
}
