import 'dart:async';
import 'dart:typed_data';
//import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nifti_locapp/components/image_edit_display.dart';
import 'package:nifti_locapp/components/image_display.dart';
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/image_selection_placeholder.dart';
import 'package:nifti_locapp/components/text_display.dart';
import 'package:nifti_locapp/components/copy_tool.dart';

//User's Profile Page
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Storage image variables
  final storage = FirebaseStorage.instance.ref();
  String imageUrl = '';
  String bannerUrl = '';
  String square1Url = '';
  String square2Url = '';
  String square3Url = '';
  Uint8List? _bannerImage;
  Uint8List? _squareImage1;
  Uint8List? _squareImage2;
  Uint8List? _squareImage3;

  // get profileImage from storage
  getProfileImageUrl(String profileImage) async {
    // get reference to image file in Firebase Storage
    final storageReference = storage.child(currentUser.uid);
    Reference referenceGetImage = storageReference.child('profileImage');
    // get the imageUrl to downloadURL
    final url = await referenceGetImage.getDownloadURL();
    //imageUrl = url;
    setState(() {
      imageUrl = url;
    });
  }

  // ? get pageImages from storage
  Future getUserImagesUrl(
    String banner,
    String square1,
    String square2,
    String square3,
  ) async {
    // get reference to image file in Firebase Storage
    final storageReference = storage.child(currentUser.uid);
    Reference referenceGetBanner = storageReference.child('banner');
    Reference referenceGetSquare1 = storageReference.child('square1');
    Reference referenceGetSquare2 = storageReference.child('square2');
    Reference referenceGetSquare3 = storageReference.child('square3');

    // get the imageUrl to downloadURL
    final url = await referenceGetBanner.getDownloadURL();
    final url1 = await referenceGetSquare1.getDownloadURL();
    final url2 = await referenceGetSquare2.getDownloadURL();
    final url3 = await referenceGetSquare3.getDownloadURL();

    setState(() {
      bannerUrl = url;
      square1Url = url1;
      square2Url = url2;
      square3Url = url3;
    });
  }

  // ? Save images when save icon selected
  Future saveImages() async {
    StoreUserImages().addBannerImage(_bannerImage!);
    StoreUserImages().addSquare1Image(_squareImage1!);
    StoreUserImages().addSquare2Image(_squareImage2!);
    StoreUserImages().addSquare3Image(_squareImage3!);
    StoreUserImages().updateFirestoreImageLinks(
      _bannerImage!,
      _squareImage1!,
      _squareImage2!,
      _squareImage3!,
    );
  }

  // ? image selection function
  void selectBanner() async {
    Uint8List banner = await pickImage();
    _bannerImage = banner;
    setState(() {
      //_bannerImage = banner;
    });
  }

  // ? image selection function
  void selectSquare1() async {
    Uint8List square1 = await pickImage();
    _squareImage1 = square1;
    setState(() {
      //_squareImage1 = square1;
    });
  }

  // ? image selection function
  void selectSquare2() async {
    Uint8List square2 = await pickImage();
    _squareImage2 = square2;

    setState(() {
      //_squareImage2 = square2;
    });
  }

  // ? image selection function
  void selectSquare3() async {
    Uint8List square3 = await pickImage();
    _squareImage3 = square3;
    setState(() {
      //_squareImage3 = square3;
    });
  }

  bool displayImageEdit = false;
  bool displayImages = true;

  late Map<String, Object?> details = {};

  _getProfileData() async {
    details = await ReadUserData.getProfileData();
    if (details.isNotEmpty) {
      for (int i = 0; i < details.length; i++) {
        setState(() {});
      }
    }
    return details;
  }

  @override
  void initState() {
    super.initState();
    getProfileImageUrl('profileImage');
    _getProfileData();
    getUserImagesUrl('banner', 'square1', 'square2', 'square3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: ListView(
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
                              backgroundImage:
                                  NetworkImage(imageUrl, scale: 1.0),
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
                Row(children: [
                  // First Name
                  TextDisplay(
                    text: details['firstName'].toString(),
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(133, 157, 194, 1),
                  ),
                  // Space between first & last name
                  const SizedBox(
                    width: 8,
                  ),
                  // Last Name
                  TextDisplay(
                    text: details['lastName'].toString(),
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(133, 157, 194, 1),
                  ),
                ]), // End of name ROW

                // ? Display Bio
                TextDisplay(
                  text: details['bio'].toString(),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(133, 157, 194, 1),
                ),
                // Space between bio and tags
                const SizedBox(
                  height: 5,
                ),

                // ? Tags = Pronouns, Industry, City
                Row(children: [
                  // Pronouns
                  TextDisplay(
                    text: '${details['pronouns']}   |',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(116, 215, 247, 1),
                  ),
                  // Space between tags
                  const SizedBox(
                    width: 10,
                  ),
                  // Industry / Field
                  TextDisplay(
                    text: '${details['industry']}   |',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(115, 142, 247, 1),
                  ),
                  // Space between tags
                  const SizedBox(
                    width: 10,
                  ),
                  // City / Town
                  TextDisplay(
                    text: details['city/town'].toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(209, 147, 246, 1),
                  )
                ]), // End of Tag ROW

                // faint DIVIDE line
                const TextDisplay(
                  text:
                      '____________________________________________________________________',
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                  color: Color.fromRGBO(133, 157, 194, 0.422),
                ),
                // Space between divide & role
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
                    // Space between icon & role
                    const SizedBox(
                      width: 5,
                    ),
                    // Role
                    TextDisplay(
                      text: details['role'].toString(),
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
                    // Space between icon & company

                    const SizedBox(
                      width: 7,
                    ),
                    // Company
                    TextDisplay(
                      text: details['company'].toString(),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),

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
                    // Space between icon & years
                    const SizedBox(
                      width: 7,
                    ),
                    // Years worked
                    TextDisplay(
                      text: details['yearsWorked'].toString(),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),

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
                    // Space between icon & years
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Email display + copy
                    GestureDetector(
                      child: CopyTool(
                        text: details['email'].toString(),
                        fontSize: 14,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                // faint DIVIDE line
                const TextDisplay(
                  text:
                      '____________________________________________________________________',
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                  color: Color.fromRGBO(133, 157, 194, 0.422),
                ),
                // Space between divide & role
                const SizedBox(
                  height: 7,
                ),
                // ? Current Role Title
                const TextDisplay(
                  text: 'Media & Content',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(133, 157, 194, 1),
                ),
                const SizedBox(
                  height: 5,
                ),

                // ? Media & Content
                // if no content = show "Welcome to your media space, add some photos that represent you! + add button"
                // else == display media content
                Row(children: [
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextDisplay(
                          text: 'A SNEAK PEAK OF ME',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(133, 157, 194, 1),
                        ),
                        TextDisplay(
                          text: "and what I'm about",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(133, 157, 194, 1),
                        ),
                      ]),
                  // space between
                  const SizedBox(width: 99),

                  if (!displayImageEdit)
                    // Edit Button
                    IconButton(
                      color: const Color.fromRGBO(115, 142, 247, 1),
                      iconSize: 25,
                      onPressed: () {
                        setState(() {
                          displayImageEdit = true;
                          displayImages = false;
                        });
                      },
                      icon: const Icon(Icons.add_circle),
                    )
                  else
                    // Save Button
                    IconButton(
                      color: const Color.fromRGBO(115, 142, 247, 1),
                      iconSize: 25,
                      onPressed: () {
                        // Save selected images
                        saveImages();
                        // Timer delay added to show updated images
                        Timer(const Duration(seconds: 1), () {
                          // get images to display on profile
                          getUserImagesUrl(
                              'banner', 'square1', 'square2', 'square3');
                          setState(() {
                            displayImageEdit = false;
                            displayImages = true;
                          });
                        });
                      },
                      icon: const Icon(Icons.check_circle),
                    )
                ]),

                const SizedBox(
                  height: 7,
                ),

                // ? Display Banner & Square Images
                displayImages
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              details['bannerImageLink'] != null
                                  ? ImageDisplay(
                                      width: 360,
                                      height: 110,
                                      onPressed: selectBanner,
                                      image:
                                          NetworkImage(bannerUrl, scale: 1.0))
                                  : // Prompt text
                                  Container(
                                      alignment: Alignment.center,
                                      width: 360,
                                      height: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: const Text(
                                        'Tap + to add some photos!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                115, 142, 247, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )
                            ],
                          ),
                          // Space between
                          const SizedBox(
                            height: 15,
                          ),
          onTap: () {},
                        ),
                      ],
                    ),
                    // faint DIVIDE line
                    // Divide line
                    const Divider(thickness: 0.5,
                    color: Color.fromRGBO(133, 157, 194, 0.422)),
                    // Space between divide & role
                    const SizedBox(
                      height: 7,
                    ),
                    // ? Current Role Title
                    const TextDisplay(
                      text: 'Media & Content',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    // ? Media & Content
                    // if no content = show "Welcome to your media space, add some photos that represent you! + add button"
                    // else == display media content
                    Row(children: [
                      const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextDisplay(
                              text: 'A SNEAK PEAK OF ME',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(133, 157, 194, 1),
                            ),
                            TextDisplay(
                              text: "and what I'm about",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(133, 157, 194, 1),
                            ),
                          ]),
                      // space between
                      const SizedBox(width: 99),

                      if (!displayImageEdit)
                        // Edit Button
                        IconButton(
                          color: const Color.fromRGBO(115, 142, 247, 1),
                          iconSize: 25,
                          onPressed: () {
                            setState(() {
                              displayImageEdit = true;
                              displayImages = false;
                            });
                          },
                          icon: const Icon(Icons.add_circle),
                        )
                      else
                        // Save Button
                        IconButton(
                          color: const Color.fromRGBO(115, 142, 247, 1),
                          iconSize: 25,
                          onPressed: () {
                            // Save selected images
                            saveImages();
                            // Timer delay added to show updated images
                            Timer(const Duration(seconds: 1), () {
                              // get images to display on profile
                              getUserImagesUrl(
                                  'banner', 'square1', 'square2', 'square3');
                              setState(() {
                                displayImageEdit = false;
                                displayImages = true;
                              });
                            });
                          },
                          icon: const Icon(Icons.check_circle),
                        )
                    ]),

                    const SizedBox(
                      height: 7,
                    ),

                          // Square Row
                          Row(
                            children: [
                              Stack(
                                children: [
                                  details['square1ImageLink'] != null
                                      ? ImageDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare1,
                                          image: NetworkImage(square1Url,
                                              scale: 1.0))
                                      :
                                      // Will show as empty space while keeping image spacing the same
                                      Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Stack(
                                children: [
                                  details['square2ImageLink'] != null
                                      ? ImageDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare2,
                                          image: NetworkImage(square2Url,
                                              scale: 1.0))
                                      : // Will show as empty space while keeping image spacing the same
                                      Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Stack(
                                children: [
                                  details['square3ImageLink'] != null
                                      ? ImageDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare3,
                                          image: NetworkImage(square3Url,
                                              scale: 1.0))
                                      : // Will show as empty space while keeping image spacing the same
                                      Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),

                // ? Edit Banner & Square Images
                displayImageEdit
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              _bannerImage != null
                                  ? ImageEditDisplay(
                                      width: 360,
                                      height: 110,
                                      onPressed: selectBanner,
                                      image:
                                          MemoryImage(_bannerImage!, scale: 1))
                                  : ImageSelectionBox(
                                      width: 360,
                                      height: 110,
                                      onPressed: selectBanner,
                                    )
                            ],
                          ),
                          // Space between
                          const SizedBox(
                            height: 15,
                          ),

                          // Banner

                          // Square Row
                          Row(
                            children: [
                              Stack(
                                children: [
                                  _squareImage1 != null
                                      ? ImageEditDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare1,
                                          image: MemoryImage(_squareImage1!,
                                              scale: 1))
                                      : ImageSelectionBox(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare1,
                                        )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Stack(
                                children: [
                                  _squareImage2 != null
                                      ? ImageEditDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare2,
                                          image: MemoryImage(_squareImage2!,
                                              scale: 1))
                                      : ImageSelectionBox(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare2,
                                        )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Stack(
                                children: [
                                  _squareImage3 != null
                                      ? ImageEditDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare3,
                                          image: MemoryImage(_squareImage3!,
                                              scale: 1))
                                      : ImageSelectionBox(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare3,
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            )));
  }
  //return const Center(child: CircularProgressIndicator());
}
