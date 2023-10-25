import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/pages/connection_page.dart';
import 'package:nifti_locapp/pages/contacts_page.dart';
import 'package:nifti_locapp/pages/profile_page.dart';
import 'package:nifti_locapp/pages/settings_page.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

// ? WidgetTree == App navigation through bottom nav bar + app bar

// * ---------------- * (STATEFUL WIDGET) CLASS WidgetTree (STATEFUL WIDGET) * ---------------- *
class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}
// * ---------------- * END OF (STATE) CLASS WidgetTree (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _LoginPageState (STATE) * ---------------- *
class _WidgetTreeState extends State<WidgetTree> {
  // ? Variables
  int currentPage = 1; // set to scanning page

  // ? List of page widgets
  List<Widget> pages = const [
    ContactsPage(),
    ConnectPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // ? Top bar that contains Nifti Logo
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(40))),
          // ? Appbar Theme
          iconTheme: CupertinoIconThemeData(color: niftiOffWhite, size: 23),
          elevation: 2,
          shadowColor: niftiGreyShadow,
          surfaceTintColor: niftiOffWhite,
          toolbarHeight: 40,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: niftiGradient,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(40))),
          ),
          // ? Notifications
          leading: IconButton(
            onPressed: () {
              // ! Notification pop-up logic
            },
            icon: const Icon(
              CupertinoIcons.bell,
              semanticLabel: 'Notifications',
            ),
          ),
          // ? Nifti Logo
          title: SizedBox(
            width: 70,
            child: Image.asset('images/nifti_logo_white.png'),
          ),
          // ? Settings
          actions: [
            //const Padding(padding: EdgeInsets.only(right: 7)),
            IconButton(
              // ? Settings page redirection
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SettingsPage();
                },
              )),
              //icon: Image.asset('images/settings_icon.png'),
              icon: const Icon(
                CupertinoIcons.gear,
                semanticLabel: 'Settings',
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 7)),
          ],
        ),
        // ? Body of the page
        body: pages.elementAt(currentPage),
        // ? Navigation Bar containing page options
        bottomNavigationBar: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: CircleNavBar(
                // ? show selected page
                onTap: (int value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                elevation: 3,
                shadowColor: niftiGreyShadow,
                activeIndex: currentPage,
                height: 75,
                circleWidth: 53,
                gradient: niftiGradient,
                circleGradient: niftiGradient,
                color: niftiOffWhite,
                cornerRadius:
                    const BorderRadius.only(topLeft: Radius.circular(33)),
                // ? Selected Icons
                activeIcons: [
                  Icon(CupertinoIcons.person_2, color: niftiOffWhite, size: 30),
                  Icon(
                    Icons.share_outlined,
                    color: niftiOffWhite,
                    size: 30,
                  ),
                  Icon(CupertinoIcons.smiley, color: niftiOffWhite, size: 30),
                ],
                // ? Unselected Icons
                inactiveIcons: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        child: Icon(
                          CupertinoIcons.person_2,
                          color: niftiOffWhite,
                          semanticLabel: 'Contacts',
                          size: 25,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        child: Icon(
                          Icons.share_outlined,
                          color: niftiOffWhite,
                          semanticLabel: 'Connect',
                          size: 25,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        child: Icon(
                          CupertinoIcons.smiley,
                          color: niftiOffWhite,
                          semanticLabel: 'Profile',
                          size: 25,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),
                    ],
                  ),
                ],
              ),
            ),
            // ? Navbar Text Labels
            Container(
              margin: const EdgeInsets.only(left: 37, top: 42),
              child: Text(
                'Contacts',
                style: TextStyle(
                  color: niftiOffWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 168, top: 42),
              child: Text(
                'Connect',
                style: TextStyle(
                  color: niftiOffWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 305, top: 42),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: niftiOffWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _WidgetTreeState (STATE) * ---------------- *
