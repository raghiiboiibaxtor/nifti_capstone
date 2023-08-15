import "package:flutter/material.dart";
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/contact_list_display.dart';
import 'package:nifti_locapp/components/text_display.dart';

// * ---------------- * (STATEFUL WIDGET) CLASS ContactsPage (STATEFUL WIDGET) * ---------------- *
class ContactsPage extends StatefulWidget {
  const ContactsPage({
    super.key,
  });

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}
// * ---------------- * END OF (STATE) CLASS ContactsPage (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _ContactsPageState (STATE) * ---------------- *
class _ContactsPageState extends State<ContactsPage> {
  // Variables
  late dynamic pincodes = [];
  late String code = '';
  late List<Map<String, Object?>> friends = [];
  String imageUrl = '';

  // ? get connection data that matches array of pincodes and store in Map<> friends
  _getAllConnectionsData() async {
    pincodes = await ReadUserData
        .getPincodeList(); // ? Assigning pincodes with map of Firestore > document > connections []
    if (pincodes != null) {
      friends = [];
      for (int i = 0; i <= pincodes.length; i++) {
        code = pincodes[i]; // ? Extracting the user pincode
        Map<String, Object?> friendData = await ReadUserData.getConnectionData(
            code); // ? grabbing the object associated with user pincode
        friends.add(friendData); // ? Copying obj into friends
        setState(() {}); // ? Changing ui
      }
      setState(() {}); // ? Resetting ui
    }
  }

  // ? display connection data in ListDisplay
  List<Widget> _friendListDisplay() {
    List<Widget> friendsList = [];
    for (int i = 0; i < friends.length; i++) {
      Map<String, Object?> friend =
          friends[i]; // ? Copying connection info into list for ui extraction
      friendsList.add(
        ListDisplay(
          // ? Variables to be passed to list
          name: '${friend['firstName']} ${friend['lastName']}',
          role: '${friend['role']}',
          email: '${friend['email']}',
          profileImageUrl: '${friend['imageLink']}',
        ),
      );
    }
    return friendsList;
  }

  // ? Run functions on page load
  @override
  void initState() {
    _getAllConnectionsData();
    super.initState();
  }

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: 390,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.center,
            height: 30,
            width: 340,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(209, 147, 246, 1),
                      Color.fromRGBO(115, 142, 247, 1),
                      Color.fromRGBO(116, 215, 247, 1),
                    ]),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                )),
            child: const Text(
              'All Contacts',
              style: TextStyle(
                  color: Color.fromRGBO(252, 250, 245, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // ? Space between
          const SizedBox(
            height: 20,
          ),
          // ? Contact List
          if (pincodes == null)
            // ? Text prompt
            const TextDisplay(
              text: 'No friends to show yet!',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(115, 142, 247, 1),
            )
          else
            // ? Display contact list
            Column(
              children: _friendListDisplay(),
            )
        ]),
      ),
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ContactsPageState (STATE) * ---------------- *
