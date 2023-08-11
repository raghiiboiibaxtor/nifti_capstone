import "package:flutter/material.dart";

//Contact List Page
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Text('you have no friends...')),
    );
  }
}
