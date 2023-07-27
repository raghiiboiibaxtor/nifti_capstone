import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/pages/scan_page.dart';
import 'package:nifti_locapp/pages/contacts_page.dart';
import 'package:nifti_locapp/pages/profile_page.dart';


// THIS FILE CONTAINS THE LOGIC FOR THE APP'S TOP & BOTTOM NAV BAR

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}
  
class _WidgetTreeState extends State<WidgetTree> {
  // Variables
  int currentPage = 1; // set to scanning page
  // List of page widgets 
  List<Widget> pages = const[
    ContactsPage(), 
    ScanPage(), 
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bar that contains Nifti Logo
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
        title: SizedBox(
          width: 100,
          child: Image.asset('images/nifti_logo.png'),
      ), 
      actions: [
        IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();}, 
          icon: const Icon(Icons.logout_rounded))
      ],

      ),
      // Body of the page
      body: pages.elementAt(currentPage),
      // Navigation Bar containing page options
      bottomNavigationBar: NavigationBar(
        destinations: const [
        NavigationDestination(icon: Icon(Icons.format_list_bulleted_rounded), label: 'Contacts'),
        NavigationDestination(icon: Icon(Icons.add_circle), label: 'Scan'),
        NavigationDestination(icon: Icon(Icons.person_pin_rounded), label: 'Profile'),
      ],
      // Logic to show selected page
      selectedIndex: currentPage,
      onDestinationSelected:(int value) {
        setState(() {
          currentPage = value;
        });
      },
      ),
    );
  }
} // End of widget_tree