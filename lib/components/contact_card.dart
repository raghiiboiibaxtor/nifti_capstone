import "package:flutter/material.dart";
import 'package:nifti_locapp/components/text_display.dart';
import 'package:nifti_locapp/components/button.dart';

// ? CONTACT CARD MODAL
displayModalBottomSheet(context) {
  String firstName = 'Dylan';
  String lastName = 'Sash';
  String bio = 'Born to travel & do cool things.';
  String pronouns = 'She / They';
  String industry = 'Marketing';
  String city = 'Dunedin';
  String role = 'Bachelor of Marketing & Communication';
  String company = 'Otago University';
  String yearsWorked = '3+ years';

  // ? Build Context 
  showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(55))),
      builder: (BuildContext context) {
        return Container(
            alignment: Alignment.topLeft,
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
            child: ListView(children: [
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
                    radius: 45,
                    backgroundImage:
                        AssetImage('images/defaultProfileImage.png'),
                  ),
                ],
              ),
              // Space between
              const SizedBox(
                height: 5,
              ),
              // ? Display Full Name
              Row(children: [
                // First Name
                TextDisplay(
                  text: firstName,
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
                  text: lastName,
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(133, 157, 194, 1),
                ),
              ]),

              // ? Display Bio
              TextDisplay(
                text: bio,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(133, 157, 194, 1),
              ),
              // Space between bio and tags
              const SizedBox(
                height: 5,
              ),

              // ? Tags = Pronouns, Industry, City
              Wrap(children: [
                // Pronouns
                TextDisplay(
                  text: '$pronouns   |',
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
                  text: '$industry   |',
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
                  text: city,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(209, 147, 246, 1),
                )
              ]), // End of Tag ROW

              // Space between
              const SizedBox(
                height: 7,
              ),

              // Divide line
              const Divider(
                  thickness: 0.5, color: Color.fromRGBO(133, 157, 194, 0.422)),

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

              // Space between
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
                    text: role,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(133, 157, 194, 1),
                  ),
                ],
              ),

              // Space between
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
                    text: company,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(133, 157, 194, 1),
                  ),
                ],
              ),

              // Space between
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
                    text: yearsWorked,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(133, 157, 194, 1),
                  ),
                ],
              ),

              const SizedBox(
                height: 5,
              ),

              // Divide line
              const Divider(
                  thickness: 0.5, color: Color.fromRGBO(133, 157, 194, 0.422)),

              const SizedBox(
                height: 10,
              ),

              // ? Buttons
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    // Button borader & drop shadow
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      height: 42,
                      width: 107,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(203, 211, 223, 1),
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                          ],
                          color: Color.fromRGBO(255, 159, 180, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    // Cancel Button
                    ButtonComponent(
                      onTap: () {},
                      text: 'Cancel',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(252, 247, 244, 1),
                      fontColor: const Color.fromRGBO(255, 159, 180, 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                    ),
                  ],
                ),

                // Confirm Button
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    // Button borader & drop shadow
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      height: 49,
                      width: 191,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(203, 211, 223, 1),
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                          ],
                          color: Color.fromRGBO(121, 212, 189, 1),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),

                    ButtonComponent(
                      onTap: () {},
                      text: 'Connect',
                      color: const Color.fromRGBO(235, 254, 244, 1),
                      fontColor: const Color.fromRGBO(121, 212, 189, 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                    ),
                  ],
                ),
              ]),
            ]));
      });
} // END OF *** CONTACT CARD MODAL