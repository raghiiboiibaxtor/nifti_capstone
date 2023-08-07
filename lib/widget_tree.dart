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
  List<Widget> pages = const [
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
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.exit_to_app_rounded, color: Color.fromRGBO(115, 142, 247, 1),))
          ],
        ),
        // Body of the page
        body: pages.elementAt(currentPage),
        // ? Navigation Bar containing page options
        bottomNavigationBar: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 60,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(209, 147, 246, 1),
                    Color.fromRGBO(115, 142, 247, 1),
                    Color.fromRGBO(116, 215, 247, 1),
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 26,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            //selectedItemColor:  const Color.fromRGBO(115, 142, 247, 1),

            items: [
              // Contacts Icon
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Color.fromRGBO(252, 250, 245, 1),
                  ),
                  label: 'Contacts',
                  activeIcon: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(252, 250, 245, 0.5),
                          offset: Offset.zero,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromRGBO(252, 250, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Icon(Icons.format_list_bulleted_rounded,
                        color: Color.fromRGBO(
                          209,
                          147,
                          246,
                          1,
                        ),
                        size: 30),
                  )),
              // Scan Icon
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color.fromRGBO(252, 250, 245, 1),
                  ),
                  label: 'Scan',
                  activeIcon: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(252, 250, 245, 0.5),
                          offset: Offset.zero,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromRGBO(252, 250, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Icon(Icons.add_circle,
                        color: Color.fromRGBO(115, 142, 247, 1), size: 30),
                  )),
              // Profile Icon
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.person_pin_rounded,
                    color: Color.fromRGBO(252, 250, 245, 1),
                  ),
                  label: 'Scan',
                  activeIcon: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(252, 250, 245, 0.5),
                          offset: Offset.zero,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromRGBO(252, 250, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Icon(Icons.person_pin_rounded,
                        color: Color.fromRGBO(116, 215, 247, 1), size: 30),
                  )),
            ],
            // Logic to show selected page
            currentIndex: currentPage,
            onTap: (int value) {
              setState(() {
                currentPage = value;
              });
            },
          ),
        )));
  }
} // End of widget_tree