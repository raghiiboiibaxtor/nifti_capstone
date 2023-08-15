import "package:flutter/material.dart";
import "package:nifti_locapp/components/copy_tool.dart";
import "package:nifti_locapp/components/text_display.dart";

// ? ListDisplay == widget to display a card with contact details

// * ---------------- * (STATEFUL WIDGET) ListDisplay (STATEFUL WIDGET) * ---------------- *
class ListDisplay extends StatefulWidget {
  // Component Variables
  final String name;
  final String role;
  final String email;
  final String profileImageUrl;
  // Required variables to be passed
  const ListDisplay({
    super.key,
    this.name = '',
    this.role = '',
    this.email = '',
    this.profileImageUrl = '',
  });

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}
// * ---------------- * END OF (STATE) CLASS ListDisplay (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _ListDisplayState (STATE) * ----------------
class _ListDisplayState extends State<ListDisplay> {
  @override
  void initState() {
    super.initState();
  }

  // * ---------------- * (BUILD WIDGET) * ---------------- *
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
            Stack(
              children: [
                // Profile picture
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      const AssetImage('images/defaultProfileImage.png'),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage:
                        NetworkImage(widget.profileImageUrl, scale: 1.0),
                  ),
                )
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
                    text: widget.name,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(133, 157, 194, 1)),
                // Role
                SizedBox(
                  width: 260,
                  child: TextDisplay(
                      text: widget.role,
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
                        text: widget.email,
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
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ListDisplayState (STATE) * ---------------- *
