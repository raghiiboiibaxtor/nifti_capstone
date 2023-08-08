import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final storage = FirebaseStorage.instance;
  String imageUrl = '';
  Uint8List? _bannerImage;
  Uint8List? _squareImage1;
  Uint8List? _squareImage2;
  Uint8List? _squareImage3;

  // get profileImage from storage
  Future getProfileImageUrl() async {
    // get reference to image file in Firebase Storage
    final ref = storage.ref().child(currentUser.uid);
    // get the imageUrl to downloadURL
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  // ? image selection function
  void selectBanner() async {
    Uint8List banner = await pickImage();
    setState(() {
      _bannerImage = banner;
    });
  }

  // ? image selection function
  void selectSquare1() async {
    Uint8List square1 = await pickImage();
    setState(() {
      _squareImage1 = square1;
    });
  }

  // ? image selection function
  void selectSquare2() async {
    Uint8List square2 = await pickImage();
    setState(() {
      _squareImage2 = square2;
    });
  }

  // ? image selection function
  void selectSquare3() async {
    Uint8List square3 = await pickImage();
    setState(() {
      _squareImage3 = square3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            getProfileImageUrl();
            return Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: ListView(
                  children: [
                    // ? Primary Info
                    Stack(
                      children: [
                        userData['imageLink'] != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: const AssetImage(
                                    'images/defaultProfileImage.png'),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(imageUrl),
                                ),
                              )
                            : const CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                    'images/defaultProfileImage.png'),
                              ),
                      ],
                    ),
                    // ? Display Full Name
                    Row(children: [
                      // First Name
                      TextDisplay(
                        text: userData['firstName'],
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
                        text: userData['lastName'],
                        fontSize: 33,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(133, 157, 194, 1),
                      ),
                    ]), // End of name ROW

                    // ? Display Bio
                    TextDisplay(
                      text: userData['bio'],
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
                        text: userData['pronouns'] + '   |',
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
                        text: userData['industry'] + '   |',
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
                        text: userData['city/town'],
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
                          text: userData['role'],
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
                          text: userData['company'],
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
                          text: userData['yearsWorked'],
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
                            text: userData['email'],
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
                    //
                    const TextDisplay(
                      text: 'A SNEAK PEAK OF ME',
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),
                    const TextDisplay(
                      text: "and what I'm about",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),

                    const SizedBox(
                      height: 7,
                    ),
                    // Banner
                    Row(
                      children: [
                        Stack(
                          children: [
                            _bannerImage != null
                                ? Container(
                                    width: 360,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(_bannerImage!,
                                              scale: 1)),
                                    ),
                                  )
                                : ImageSelectionBox(
                                    width: 360,
                                    height: 110,
                                    onPressed: selectBanner,
                                  )
                          ],
                        ),
                      ],
                    ),
                    // Space between
                    const SizedBox(
                      height: 15,
                    ),
                    // Square Row
                    Row(
                      children: [
                        Stack(
                          children: [
                            _squareImage1 != null
                                ? Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(_squareImage1!,
                                              scale: 1)),
                                    ),
                                  )
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
                                ? Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(_squareImage2!,
                                              scale: 1)),
                                    ),
                                  )
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
                                ? Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(_squareImage3!,
                                              scale: 1)),
                                    ),
                                  )
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
                ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
