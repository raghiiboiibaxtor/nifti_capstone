import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/components/button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // ? Top bar that contains Nifti Logo
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(40))),
          // ? Appbar Theme
          iconTheme: CupertinoIconThemeData(color: niftiOffWhite, size: 23),
          elevation: 2,
          shadowColor: niftiGreyShadow,
          surfaceTintColor: niftiOffWhite,
          toolbarHeight: 40,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: niftiGradient,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(40))),
          ),
          // ? Go Back
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              semanticLabel: 'Back',
            ),
          ),
          // ? Nifti Logo
          title: SizedBox(
            width: 70,
            child: Image.asset('images/nifti_logo_white.png'),
          ),
        ),
        // *** Settings page UI & logic starts here
        body: Container(
          alignment: AlignmentDirectional.topStart,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              // ? Logout
              const SizedBox(
                height: 20,
              ),
              Button(
                onTap: () {         
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                text: 'Logout',
                icon: Icons.logout_rounded,
                iconColor: niftiPink,
              )
            ],
          ),
        ));
  }
}
