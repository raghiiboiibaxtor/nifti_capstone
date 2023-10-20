import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:advanced_icon/advanced_icon.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/pages/connection_page.dart';
import 'package:nifti_locapp/pages/contacts_page.dart';
import 'package:nifti_locapp/pages/profile_page.dart';
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
          iconTheme: CupertinoIconThemeData(color: niftiGrey, size: 23),
          elevation: 2,
          shadowColor: niftiGreyShadow,
          surfaceTintColor: niftiOffWhite,
          toolbarHeight: 40,
          centerTitle: true,
          // ? Notifications
          leading: IconButton(
            onPressed: () {
              //FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              CupertinoIcons.bell,
              semanticLabel: 'Notifications',
            ),
          ),
          // ? Nifti Logo
          title: SizedBox(
            width: 70,
            child: Image.asset('images/nifti_logo.png'),
          ),
          // ? Settings
          actions: [
            //const Padding(padding: EdgeInsets.only(right: 7)),
            IconButton(
              onPressed: () {
                //FirebaseAuth.instance.signOut();
              },
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
        /*bottomNavigationBar: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 55,
          
          decoration: BoxDecoration(
              color: niftiOffWhite,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 26,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,

            items: [
              // ? Contacts Icon
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
              // ? Scan Icon
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
              // ? Profile Icon
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
            // ? Logic to show selected page
            currentIndex: currentPage,
            onTap: (int value) {
              setState(() {
                currentPage = value;
              });
            },
          ),
        ))*/

        //child: Icon(CupertinoIcons.group),
        //child: Icon(CupertinoIcons.question),
        //child: Icon(CupertinoIcons.smiley),

        bottomNavigationBar: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: CircleNavBar(
                onTap: (int value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                elevation: 3,
                shadowColor: niftiGreyShadow,
                activeIndex: currentPage,
                cornerRadius:
                    const BorderRadius.only(topLeft: Radius.circular(23)),
                activeIcons: [
                  AdvancedIcon(
                    icon: CupertinoIcons.person_2,
                    gradient: niftiGradient,
                    size: 30,
                  ),
                  const SizedBox(
                    height:  0.01,
                    width: 0.2,
                    child: Image(
                    image: AssetImage('images/nifti_icon_gradient.png'),
                    semanticLabel: 'Connect',
                  ),
                  ),
                   
                  // Profile Active Icon
                  AdvancedIcon(
                    icon: CupertinoIcons.smiley,
                    gradient: niftiGradient,
                    size: 30,
                  ),
                  //Icon(CupertinoIcons.group, color: niftiGrey),
                  //Icon(CupertinoIcons.question, color: niftiGrey),
                  //Icon(CupertinoIcons.smiley, color: niftiGrey),
                ],
                inactiveIcons: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        child: Icon(
                          CupertinoIcons.person_2,
                          color: niftiGrey,
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
                      Image(
                        image: const AssetImage('images/nifti_icon_grey.png'),
                        color: niftiGrey,
                        semanticLabel: 'Connect',
                        height: 25,
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
                          color: niftiGrey,
                          semanticLabel: 'Profile',
                          size: 25,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),
                    ],
                  ),
                ],
                height: 75,
                circleWidth: 53,
                color: niftiOffWhite,
              ),
            ),
            // ? Navbar Text Labels
            Container(
              margin: const EdgeInsets.only(left: 37, top: 42),
              child: Text(
                'Contacts',
                style: TextStyle(
                  color: niftiGrey,
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
                  color: niftiGrey,
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
                  color: niftiGrey,
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
