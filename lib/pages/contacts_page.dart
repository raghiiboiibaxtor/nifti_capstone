import "package:flutter/material.dart";
import 'package:nifti_locapp/functions/functions.dart';
import 'package:nifti_locapp/components/contact_list_display.dart';

//Contact List Page
class ContactsPage extends StatefulWidget {
  // ContactsPage({super.key});
  const ContactsPage({
    super.key,
  });

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late dynamic pincodes = [];
  late String code = '';
  late Map<String, Object?> friend = {};

  _getAllConnectionsData() async {
    pincodes = await ReadUserData.getPincodeList();
    if (pincodes != null) {
      for (int i = 0; i <= pincodes.length; i++) {
        code = pincodes[i];
        friend = await ReadUserData.getConnectionData(code);
        setState(() {});
      }
      setState(() {});
      return friend;
    }
  }

  @override
  void initState() {
    _getAllConnectionsData();
    super.initState();
  }

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
          // space between
          const SizedBox(
            height: 20,
          ),
          if (pincodes != null)
            for (int i = 0; i < pincodes.length; i++) const ListDisplay(),
          Text('$pincodes'),
        ]),
      ),
    );
  }
}
