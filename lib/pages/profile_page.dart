import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/text_display.dart';

// ? ProfilePage == display user's details + edit to choose banner images

// * ---------------- * (STATEFUL WIDGET) CLASS ProfilePage (STATEFUL WIDGET) * ---------------- *
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
// * ---------------- * END OF (STATE) CLASS ProfilePage (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _ProfilePageState (STATE) * ---------------- *
class _ProfilePageState extends State<ProfilePage> {
  // ? Grabbing user
  final currentUser = FirebaseAuth.instance.currentUser!;

  late Map<String, Object?> details = {};

  // ? get user's data and store in Map<> details
  _getProfileData() async {
    details = await ReadUserData.getProfileData();
    if (details.isNotEmpty) {
      for (int i = 0; i < details.length; i++) {
        setState(() {});
      }
    }
    return details;
  }

  // ? Run functions on page load
  @override
  void initState() {
    super.initState();
    _getProfileData();
  }

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.topLeft,
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Page title
                  Text('PROFILE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: niftiGrey,
                      )),
                  const SizedBox(
                    width: 213,
                  ),
                  // ? Edit Button
                  TextButton.icon(
                    onPressed: () {
                      // ! Action for edit pop-up
                    },
                    icon: Icon(
                      Icons.mode_edit_outline_rounded,
                      weight: 20,
                      size: 12,
                      color: niftiGrey,
                    ),
                    label: Text(
                      'Edit',
                      style: TextStyle(color: niftiGrey),
                    ),
                  ),
                ],
              ),
              // ? Profile Card
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  // Gradient "border container"
                  Container(
                    height: 590,
                    decoration: BoxDecoration(
                        gradient: niftiGradient,
                        boxShadow: [
                          BoxShadow(
                              color: niftiGreyShadow,
                              spreadRadius: 1.0,
                              blurRadius: 3.0,
                              offset: const Offset(0, 1)),
                        ],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(1),
                          topRight: Radius.circular(70),
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        )),
                  ),
                  // Profile Container
                  Container(
                    width: 357,
                    height: 587,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(70),
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70),
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        // ? PROFILE INFO
                        // profile image stack + check
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            details['imageLink'] != ''
                                ? CircleAvatar(
                                    radius: 75,
                                    backgroundImage: const AssetImage(
                                        'images/defaultProfileImage.png'),
                                    child: CircleAvatar(
                                      radius: 72,
                                      backgroundImage: NetworkImage(
                                          '${details['imageLink']}',
                                          scale: 1.0),
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 75,
                                    backgroundImage: AssetImage(
                                        'images/defaultProfileImage.png'),
                                  ),
                            // Pronoun Stack + check
                            details['pronouns'] != ''
                                ? Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      // Gradient Border
                                      Container(
                                        width: 100,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            gradient: niftiGradient,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      // Pronouns
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        width: 97,
                                        height: 23,
                                        decoration: BoxDecoration(
                                            color: niftiWhite,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          '${details['pronouns']}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: niftiGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // ? Display Full Name
                        TextDisplay(
                          text: '${details['firstName']}'
                              ' ${details['lastName']}',
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                          color: niftiLightBlue,
                        ),
                        // ? Display About
                        Container(
                            alignment: AlignmentDirectional.topStart,
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextDisplay(
                                  text: 'About Me',
                                  color: niftiLightGrey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextDisplay(
                                  text: '${details['bio']}',
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          /*child: ListView(
              children: [
                // ? Primary Info
                Stack(
                  children: [
                    details['imageLink'] != null
                        ? CircleAvatar(
                            radius: 45,
                            backgroundImage: const AssetImage(
                                'images/defaultProfileImage.png'),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  '${details['imageLink']}',
                                  scale: 1.0),
                            ),
                          )
                        : const CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                AssetImage('images/defaultProfileImage.png'),
                          ),
                  ],
                ),
                // ? Display Full Name

                TextDisplay(
                  text: '${details['firstName']}' ' ${details['lastName']}',
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(133, 157, 194, 1),
                ),
                // ? Space between first & last name
                const SizedBox(
                  width: 8,
                ), // ? End of name ROW

                // ? Display Bio
                TextDisplay(
                  text: '${details['bio']}',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(133, 157, 194, 1),
                ),
                // ? Space between bio and tags
                const SizedBox(
                  height: 5,
                ),

                // ? Tags = Pronouns, Industry, City
                Wrap(children: [
                  // ? Pronouns
                  TextDisplay(
                    text: '${details['pronouns']}   |',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(116, 215, 247, 1),
                  ),
                  // ? Space between tags
                  const SizedBox(
                    width: 10,
                  ),
                  // ? Industry / Field
                  TextDisplay(
                    text: '${details['industry']}   |',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(115, 142, 247, 1),
                  ),
                  // ? Space between tags
                  const SizedBox(
                    width: 10,
                  ),
                  // ? City / Town
                  TextDisplay(
                    text: '${details['city/town']}',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(209, 147, 246, 1),
                  )
                ]), // ? End of Tag ROW

                // ? faint DIVIDE line
                // ? Divide line
                const Divider(
                    thickness: 0.5,
                    color: Color.fromRGBO(133, 157, 194, 0.422)),

                // ? Space between divide & role
                const SizedBox(
                  height: 7,
                ),
                // ? Current Role Title
                const TextDisplay(
                  text: 'Current Role',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(133, 157, 194, 1),
                ),
                const SizedBox(
                  height: 10,
                ),

                // ? ROW == icon & role title
                Row(
                  children: [
                    const Icon(
                      Icons.diamond_outlined,
                      size: 15,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),
                    // ? Space between icon & role
                    const SizedBox(
                      width: 5,
                    ),
                    // ? Role
                    TextDisplay(
                      text: '${details['role']}',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),

                // ? ROW == icon & company
                Row(
                  children: [
                    const Icon(
                      Icons.push_pin_outlined,
                      size: 14,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),
                    // ? Space between icon & company
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Company
                    TextDisplay(
                      text: '${details['company']}',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),
                // ? Space between
                const SizedBox(
                  height: 5,
                ),

                // ? ROW == icon & years worked
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),
                    // ? Space between icon & years
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Years worked
                    TextDisplay(
                      text: '${details['yearsWorked']}',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),
                // ? Space between
                const SizedBox(
                  height: 5,
                ),

                // ? Contact Info
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 15,
                      color: Color.fromRGBO(209, 147, 246, 1),
                    ),
                    // ? Space between icon & years
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Email display + copy
                    GestureDetector(
                      child: CopyTool(
                        text: '${details['email']}',
                        fontSize: 14,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                // ? faint DIVIDE line
                // ? Divide line
                const Divider(
                    thickness: 0.5,
                    color: Color.fromRGBO(133, 157, 194, 0.422)),
                // ? Space between divide & role
                const SizedBox(
                  height: 7,
                ),
              ],
            )*/
        ));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ProfilePageState (STATE) * ---------------- *
