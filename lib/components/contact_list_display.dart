import "package:flutter/material.dart";
import "package:nifti_locapp/components/copy_tool.dart";
import "package:nifti_locapp/components/text_display.dart";

import "../functions/functions.dart";

class ListDisplay extends StatefulWidget {
  const ListDisplay({super.key});

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  late String code = '';
  late Map<String, Object?> friend = {};

  _getConnectionData() async {
    friend = await ReadUserData.getConnectionData(code);
    setState(() {});
    return friend;
  }

  @override
  void initState() {
    _getConnectionData();
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
                /*friend['imageLink']  != null
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
                // Full Name
                TextDisplay(
                    text: '${friend['firstName']}' ' ${friend['lastName']}',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(133, 157, 194, 1)),
                // Role
                SizedBox(
                  width: 260,
                  child: TextDisplay(
                      text: '${friend['role']}',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1)),
                ),

                // space between
                const SizedBox(
                  height: 3,
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
                        text: '${friend['email']}',
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
