import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/functions/frontend.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/components/text_display.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:nifti_locapp/components/text_form_field.dart';
import 'package:nifti_locapp/components/text_field_character_limit.dart';
import 'package:nifti_locapp/components/drop_menu.dart';

/*
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/text_display.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

 */

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

  // ? Card Flip
  bool isEditing = false;
  final flip = FlipCardController();

  // ? Text Controllers - used to access the user's input
  Uint8List? _profileImage;
  final _fullNameController = TextEditingController();
  String? _pronouns;
  final _cityController = TextEditingController();
  final _bio = TextEditingController();
  final _industry = TextEditingController();
  final _roleTitle = TextEditingController();
  final _companyName = TextEditingController();
  String? _yearsWorked;
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _instagramController = TextEditingController();
  final _githubController = TextEditingController();
  final _phoneController = TextEditingController();

  // ? Pronoun dropdown list
  final List<String> pronouns = [
    'They / Them',
    'He / Him',
    'She / Her',
    'He / They',
    'She / They',
    'Prefer not to say'
  ];
  // ? Years in company dropdown list
  final List<String> years = [
    '< 1 year',
    '1+ year',
    '2+ years',
    '3+ years',
    '4+ years',
    '5+ years',
  ];

  // ? Profile image selection function
  void selectProfileImage() async {
    Uint8List image = await pickImage();
    setState(() {
      _profileImage = image;
    });
  }

  // ? Get user's data and store in Map<> details
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
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Page title
              Text(
                'PROFILE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: niftiGrey,
                ),
              ),
              const SizedBox(
                width: 208,
              ),
              // ? Edit Button
              TextButton.icon(
                onPressed: () {
                  // Toggle between edit and display mode
                  flip.flipcard();
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                icon: Icon(
                  Icons.mode_edit_outline_rounded,
                  weight: 20,
                  size: 12,
                  color: niftiGrey,
                ),
                label: Text(
                  isEditing ? 'Save' : 'Edit',
                  style: TextStyle(color: niftiGrey),
                ),
              ),
            ],
          ),
          Column(
            children: [
              FlipCard(
                rotateSide: RotateSide.bottom,
                axis: FlipAxis.vertical,
                controller: flip,
                frontWidget: Center(
                  child: SizedBox(
                    child: _profileDisplayView(),
                  ),
                ),
                backWidget: Center(
                  child: SizedBox(
                    child: _buildEditView(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *

  // * ---------------- * (PROFILE DISPLAY) * ---------------- *
  Widget _profileDisplayView() {
    return Stack(
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
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(1),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        // Profile Container
        Container(
          width: 357,
          height: 587,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(1),
              topRight: Radius.circular(49),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
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
                          backgroundImage:
                              AssetImage('images/defaultProfileImage.png'),
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            // Pronouns
                            Container(
                              alignment: AlignmentDirectional.center,
                              width: 97,
                              height: 23,
                              decoration: BoxDecoration(
                                color: niftiWhite,
                                borderRadius: BorderRadius.circular(20),
                              ),
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
                      : const SizedBox(),
                ],
              ),
              // Spacing
              const SizedBox(
                height: 15,
              ),
              // ? Display Full Name
              TextDisplay(
                text: '${details['fullName']}',
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
              // Divider + spacing
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: niftiLightBlue,
              ),
              const SizedBox(
                height: 5,
              ), // End of divider + spacing
              // ? Display About
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                    // Bio + check
                    details['bio'] != ''
                        ? TextDisplay(
                            text: '${details['bio']}',
                            fontSize: 13,
                          )
                        : TextDisplay(
                            text:
                                'EDIT YOUR PROFILE TO GIVE YOUR CONTACTS A CHEEKY INSIGHT TO YOU! 🥳',
                            fontSize: 13,
                            color: niftiDarkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Tags == Industry & City
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Industry
                        details['industry'] != ''
                            ? Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.building_2_fill,
                                    size: 14,
                                    color: niftiGrey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextDisplay(
                                    text: '${details['industry']}',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        // City / Town
                        details['city/town'] != ''
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: niftiGrey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextDisplay(
                                    text: '${details['city/town']}',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              // Divider + spacing
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: niftiLightBlue,
              ),
              const SizedBox(
                height: 5,
              ), // End of divider + spacing
              // ? Display Role / Study
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextDisplay(
                      text: 'Current Role / Study',
                      color: niftiLightGrey,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    details['role'] != ''
                        ? Row(
                            children: [
                              Icon(
                                CupertinoIcons.star,
                                size: 14,
                                color: niftiGrey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TextDisplay(
                                text: '${details['role']}',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    // Tags == Company & Years Worked
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Industry
                        details['company'] != ''
                            ? Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.pin,
                                    size: 13,
                                    color: niftiGrey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextDisplay(
                                    text: '${details['company']}',
                                    fontSize: 13,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        // City / Town
                        details['yearsWorked'] != ''
                            ? Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.time,
                                    size: 13,
                                    color: niftiGrey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextDisplay(
                                    text: '${details['yearsWorked']}',
                                    fontSize: 13,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              // Divider + spacing
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: niftiLightBlue,
              ),
              const SizedBox(
                height: 5,
              ), // End of divider + spacing
              // ? Contact details
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextDisplay(
                      text: 'Get In Touch',
                      color: niftiLightGrey,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),

                    // Display email + copy function
                    details['email'] != ''
                        ? Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              // Base shape
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1.0,
                                      blurRadius: 3.0,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  color: niftiWhite,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(1),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                              // Icon Shape
                              Container(
                                height: 30,
                                width: 40,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.5,
                                      blurRadius: 3.0,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  color: niftiWhite,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(1),
                                    bottomLeft: Radius.circular(17),
                                  ),
                                ),
                                child: Icon(
                                  CupertinoIcons.mail,
                                  color: niftiGrey,
                                  size: 17,
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          // removing spash visuals
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                    ),
                                    onPressed: () {
                                      // ! Copy / Open Mail App Function
                                    },
                                    child: GradientText(
                                      '${details['email']}',
                                      colors: const [
                                        Color.fromRGBO(209, 147, 246, 1),
                                        Color.fromRGBO(115, 142, 247, 1),
                                        Color.fromRGBO(116, 215, 247, 1),
                                      ],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : // If no email, then don't show UI
                        Container(),
                    // Contact Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ? Website, Social, & Contact Links
                        // Website Link
                        details['website'] != ''
                            ? Container(
                                padding: const EdgeInsets.only(right: 23),
                                child: IconButton(
                                  onPressed: () {
                                    // ! open link function
                                  },
                                  icon: const Icon(CupertinoIcons.globe),
                                  color: niftiGrey,
                                  style: ButtonStyle(
                                    overlayColor:
                                        // removing spash visuals
                                        MaterialStateProperty.all(
                                            Colors.transparent),
                                  ),
                                ),
                              )
                            : Container(),
                        // Github Link
                        details['github'] != ''
                            ? Container(
                                padding: const EdgeInsets.only(right: 23),
                                child: SocialMediaButton.github(
                                  onTap: () {
                                    // ! open link function
                                  },
                                  size: 25,
                                  color: niftiGrey,
                                ),
                              )
                            : Container(),
                        // Linkedin Link
                        details['linkedin'] != ''
                            ? Container(
                                padding: const EdgeInsets.only(right: 23),
                                child: SocialMediaButton.linkedin(
                                  onTap: () {
                                    // ! open link function
                                  },
                                  size: 25,
                                  color: niftiGrey,
                                ),
                              )
                            : Container(),
                        // Instagram Link
                        details['instagram'] != ''
                            ? Container(
                                padding: const EdgeInsets.only(right: 23),
                                child: SocialMediaButton.instagram(
                                  onTap: () {
                                    // ! open link function
                                  },
                                  size: 25,
                                  color: niftiGrey,
                                ),
                              )
                            : Container(),
                        // Phone number
                        details['phone'] != ''
                            ? IconButton(
                                onPressed: () {
                                  // ! open link function
                                },
                                icon: const Icon(CupertinoIcons.phone),
                                color: niftiGrey,
                                style: ButtonStyle(
                                  overlayColor:
                                      // removing spash visuals
                                      MaterialStateProperty.all(
                                          Colors.transparent),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // * ---------------- * END OF (PROFILE DISPLAY) * ---------------- *

  // * ---------------- * (EDIT DISPLAY) * ---------------- *
  Widget _buildEditView() {
    return Stack(
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
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(1),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        // Profile Container
        Container(
          width: 357,
          height: 587,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(49),
              topRight: Radius.circular(1),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  // ? Profile Picture Selection
                  Stack(
                    children: [
                      _profileImage != null
                          ? CircleAvatar(
                              radius: 53,
                              backgroundImage: MemoryImage(_profileImage!),
                            )
                          : const CircleAvatar(
                              radius: 53,
                              backgroundImage:
                                  AssetImage('images/defaultProfileImage.png'),
                            ),
                      Positioned(
                        bottom: -9,
                        left: 67,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 23,
                              height: 23,
                              decoration: BoxDecoration(
                                gradient: niftiGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.5,
                                    blurRadius: 2.0,
                                    offset: const Offset(0.5, 1),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            IconButton(
                              color: niftiWhite,
                              onPressed: selectProfileImage,
                              icon: const Icon(
                                CupertinoIcons.add_circled_solid,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // ? Space between next widget
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      // ? Name Textfield
                      TextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: 181,
                        controller: _fullNameController,
                        labelText: 'Name',
                        obscureText: false,
                        hasError: false,
                      ),
                      // Space
                      const SizedBox(
                        height: 15,
                      ),
                      // ? Pronoun dropdown selector
                      DropdownMenuComponent(
                        width: 181,
                        value: pronouns,
                        labelText: 'Pronouns',
                        itemsList: pronouns,
                        onChanged: (value) {
                          setState(() {
                            _pronouns = value as String;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              // Space
              const SizedBox(height: 15),
              // ? Bio Textfield
              TextFieldLimitComponent(
                maxLength: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 325,
                controller: _bio,
                labelText: 'Bio',
                obscureText: false,
                hasError: false,
              ),
              Row(
                children: [
                  // ? Industry Textfield
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 135,
                    controller: _industry,
                    labelText: 'Industry',
                    obscureText: false,
                    hasError: false,
                  ),
                  const SizedBox(width: 7),
                  // ? City/Town Textfield
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 135,
                    controller: _cityController,
                    labelText: 'City / Town',
                    obscureText: false,
                    hasError: false,
                  ),
                ],
              ),
              // ? Role / Degree Textfield
              TextFieldComponent(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 325,
                controller: _roleTitle,
                labelText: 'Current Role or Degree',
                obscureText: false,
                hasError: false,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ? Company Textfield
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 140,
                    controller: _companyName,
                    labelText: 'Company / Institute',
                    obscureText: false,
                    hasError: false,
                  ),
                  const SizedBox(width: 20),
                  // ? Years Worked Dropdown
                  DropdownMenuComponent(
                    width: 130,
                    value: pronouns,
                    labelText: 'Years Worked',
                    itemsList: years,
                    onChanged: (value) {
                      setState(() {
                        _yearsWorked = value as String;
                      });
                    },
                  ),
                ],
              ),
              // ? Email Textfield
                  TextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 325,
                    controller: _emailController,
                    labelText: 'Email',
                    obscureText: false,
                    hasError: false,
                  ),
            ],
          ),
        ),
      ],
    );
  }
  // * ---------------- * END OF (EDIT DISPLAY) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ProfilePageState (STATE) * ---------------- *
