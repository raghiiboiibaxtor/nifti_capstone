import "package:flutter/material.dart";
import "package:nifti_locapp/components/copy_tool.dart";
import "package:nifti_locapp/components/text_display.dart";

import "../functions/functions.dart";

class ListDisplay extends StatefulWidget {
   //final String firstName;
 //  final String lastName;
//   final String role;
//   final String email;

   const ListDisplay({super.key /*, required this.firstName, required this.lastName, required this.role, required this.email,*/ });

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {

  //late final String firstName;
 // late final String lastName;
 // late final String role;
//  late final String email;
  late String code = '';
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
    _getProfileData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      // color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: AlignmentDirectional.topStart,
        width: 360,
        height: 90,
        child: Row(
          children: [
            const Stack(
              children: [
                // Profile picture
                /*userData['imageLink'] != null
                            ? 
                            CircleAvatar(
                                radius: 45,
                                backgroundImage: const AssetImage(
                                    'images/defaultProfileImage.png'),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(imageUrl, scale: 1.0),
                                ),
                              )
                            : */
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('images/defaultProfileImage.png'),
                ),
              ],
            ),
            // space between
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                 const TextDisplay(
                    text: 'Dylan Sash',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(133, 157, 194, 1)),
                const TextDisplay(
                    text: 'BC Marketing & Communication',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(133, 157, 194, 1)),

                // space between
                const SizedBox(
                  height: 2,
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
                      child:  CopyTool(
                        text: '${details['email']}',
                        fontSize: 13,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
child:  ListTile(
              contentPadding:EdgeInsets.symmetric(horizontal: 15),
              
              leading: Stack(
                children: [
                  // Profile picture
                  /*userData['imageLink'] != null
                            ? 
                            CircleAvatar(
                                radius: 45,
                                backgroundImage: const AssetImage(
                                    'images/defaultProfileImage.png'),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(imageUrl, scale: 1.0),
                                ),
                              )
                            : */
                  CircleAvatar(
                    
                    radius: 45,
                    backgroundImage:
                        AssetImage('images/defaultProfileImage.png'),
                  ),
                ],
              ),
              title: Text('Full Name'),
              subtitle:
                  Text('Role'), 
              
              isThreeLine: true,
            ),
 */