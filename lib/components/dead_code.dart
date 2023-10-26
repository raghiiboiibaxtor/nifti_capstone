// *** NAV BAR
/*bottomNavigationBar: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 55,
          
          decoration: BoxDecoration(
              color: niftiOffWhite,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 26,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,

            items: [
              // ? Contacts Icon
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Color.fromRGBO(252, 250, 245, 1),
                  ),
                  label: 'Contacts',
                  activeIcon: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(252, 250, 245, 0.5),
                          offset: Offset.zero,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromRGBO(252, 250, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Icon(Icons.format_list_bulleted_rounded,
                        color: Color.fromRGBO(
                          209,
                          147,
                          246,
                          1,
                        ),
                        size: 30),
                  )),
              // ? Scan Icon
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color.fromRGBO(252, 250, 245, 1),
                  ),
                  label: 'Scan',
                  activeIcon: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(252, 250, 245, 0.5),
                          offset: Offset.zero,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromRGBO(252, 250, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Icon(Icons.add_circle,
                        color: Color.fromRGBO(115, 142, 247, 1), size: 30),
                  )),
              // ? Profile Icon
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.person_pin_rounded,
                    color: Color.fromRGBO(252, 250, 245, 1),
                  ),
                  label: 'Scan',
                  activeIcon: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(252, 250, 245, 0.5),
                          offset: Offset.zero,
                          spreadRadius: 5,
                        )
                      ],
                      color: Color.fromRGBO(252, 250, 245, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Icon(Icons.person_pin_rounded,
                        color: Color.fromRGBO(116, 215, 247, 1), size: 30),
                  )),
            ],
            // ? Logic to show selected page
            currentIndex: currentPage,
            onTap: (int value) {
              setState(() {
                currentPage = value;
              });
            },
          ),
        ))*/

        //child: Icon(CupertinoIcons.group),
        //child: Icon(CupertinoIcons.question),
        //child: Icon(CupertinoIcons.smiley),

// *** PROFILE PAGE == Media & Content + Editing
/*

  // ? Storage image variables
  final storage = FirebaseStorage.instance.ref();
  Uint8List? _bannerImage;
  Uint8List? _squareImage1;
  Uint8List? _squareImage2;
  Uint8List? _squareImage3;
  bool displayImageEdit = false;
  bool displayImages = true;

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
    setState(() {});
  }

  // ? image selection function
  void selectSquare1() async {
    Uint8List square1 = await pickImage();
    _squareImage1 = square1;
    setState(() {});
  }

  // ? image selection function
  void selectSquare2() async {
    Uint8List square2 = await pickImage();
    _squareImage2 = square2;

    setState(() {});
  }

  // ? image selection function
  void selectSquare3() async {
    Uint8List square3 = await pickImage();
    _squareImage3 = square3;
    setState(() {});
  }
------------------------------------------

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
                // ? if no content = show "Welcome to your media space, add some photos that represent you! + add button"
                // ? else == display media content
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
                  // ? space between
                  const SizedBox(width: 99),

                  if (!displayImageEdit)
                    // ? Edit Button
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
                    // ? Save Button
                    IconButton(
                      color: const Color.fromRGBO(115, 142, 247, 1),
                      iconSize: 25,
                      onPressed: () {
                        // ? Save selected images
                        saveImages();
                        // ? Timer delay added to show updated images
                        Timer(const Duration(seconds: 1), () {
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
                                      image: NetworkImage(
                                          '${details['bannerImageLink']}',
                                          scale: 1.0))
                                  : // ? Prompt text
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
                          // ? Space between
                          const SizedBox(
                            height: 15,
                          ),

                          // ? Square Row
                          Row(
                            children: [
                              Stack(
                                children: [
                                  details['square1ImageLink'] != null
                                      ? ImageDisplay(
                                          width: 110,
                                          height: 110,
                                          onPressed: selectSquare1,
                                          image: NetworkImage(
                                              '${details['square1ImageLink']}',
                                              scale: 1.0))
                                      :
                                      // ? Will show as empty space while keeping image spacing the same
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
                                          image: NetworkImage(
                                              '${details['square2ImageLink']}',
                                              scale: 1.0))
                                      : // ? Will show as empty space while keeping image spacing the same
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
                                          image: NetworkImage(
                                              '${details['square3ImageLink']}',
                                              scale: 1.0))
                                      : // ? Will show as empty space while keeping image spacing the same
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
                          // ? Space between
                          const SizedBox(
                            height: 15,
                          ),

                          // ? Banner

                          // ? Square Row
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

    /*child: ListView(
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
                              backgroundImage: NetworkImage(
                                  '${details['imageLink']}',
                                  scale: 1.0),
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

                TextDisplay(
                  text: '${details['firstName']}' ' ${details['lastName']}',
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(133, 157, 194, 1),
                ),
                // ? Space between first & last name
                const SizedBox(
                  width: 8,
                ), // ? End of name ROW

                // ? Display Bio
                TextDisplay(
                  text: '${details['bio']}',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(133, 157, 194, 1),
                ),
                // ? Space between bio and tags
                const SizedBox(
                  height: 5,
                ),

                // ? Tags = Pronouns, Industry, City
                Wrap(children: [
                  // ? Pronouns
                  TextDisplay(
                    text: '${details['pronouns']}   |',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(116, 215, 247, 1),
                  ),
                  // ? Space between tags
                  const SizedBox(
                    width: 10,
                  ),
                  // ? Industry / Field
                  TextDisplay(
                    text: '${details['industry']}   |',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(115, 142, 247, 1),
                  ),
                  // ? Space between tags
                  const SizedBox(
                    width: 10,
                  ),
                  // ? City / Town
                  TextDisplay(
                    text: '${details['city/town']}',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(209, 147, 246, 1),
                  )
                ]), // ? End of Tag ROW

                // ? faint DIVIDE line
                // ? Divide line
                const Divider(
                    thickness: 0.5,
                    color: Color.fromRGBO(133, 157, 194, 0.422)),

                // ? Space between divide & role
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
                    // ? Space between icon & role
                    const SizedBox(
                      width: 5,
                    ),
                    // ? Role
                    TextDisplay(
                      text: '${details['role']}',
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
                    // ? Space between icon & company
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Company
                    TextDisplay(
                      text: '${details['company']}',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),
                // ? Space between
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
                    // ? Space between icon & years
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Years worked
                    TextDisplay(
                      text: '${details['yearsWorked']}',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(133, 157, 194, 1),
                    ),
                  ],
                ),
                // ? Space between
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
                    // ? Space between icon & years
                    const SizedBox(
                      width: 7,
                    ),
                    // ? Email display + copy
                    GestureDetector(
                      child: CopyTool(
                        text: '${details['email']}',
                        fontSize: 14,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                // ? faint DIVIDE line
                // ? Divide line
                const Divider(
                    thickness: 0.5,
                    color: Color.fromRGBO(133, 157, 194, 0.422)),
                // ? Space between divide & role
                const SizedBox(
                  height: 7,
                ),
              ],
            )*/
 */


// *** REGISTRATION
// ? List of steps to be displayed in the stepper
  /*List<Step> stepList() => [
        // ? First Step == Account Details (First Name, Last Name, Email, Password)
        Step(
            isActive: currentStep >= 0,
            state: currentStep <= 0 ? StepState.editing : StepState.complete,
            title: const Text('Account Details'),
            content: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Nifti!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // ? Space between next widget
                    const SizedBox(height: 20),
                    // ? Name prompt
                    Row(
                      children: [
                        // ? First name
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 0),
                          width: 150,
                          controller: _firstNameController,
                          hintText: 'First Name *',
                          obscureText: false,
                        ),
                        // ? Last name
                        GradientTextFieldComponent(
                          padding: const EdgeInsets.only(left: 20.0),
                          width: 170,
                          controller: _lastNameController,
                          hintText: 'Last Name',
                          obscureText: false,
                        ),
                      ],
                    ),
                    // ? Space between next widget
                    const SizedBox(height: 20),

                    // ? Email Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 350,
                      controller: _emailController,
                      hintText: 'Email *',
                      obscureText: false,
                    ),
                    // ? Space between next widget
                    const SizedBox(height: 20),

                    // ? Password Textfield
                    GradientTextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        width: 350,
                        controller: _passwordController,
                        hintText: 'Password *',
                        obscureText: true),
                    // ? Space between next widget
                    const SizedBox(height: 5),

                    // ? Password prompt
                    const TextDisplay(
                      text:
                          '                                                     6 characters minimum',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(133, 157, 194, 1),
                    ),

                    // ? Space between next widget
                    const SizedBox(height: 15),

                    // ? Confirm Password Textfield
                    GradientTextFieldComponent(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        width: 350,
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password *',
                        obscureText: true),
                    // ? Space between next widget
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            )),

        // ? Second Step == Account Details (Personal & Work Details)
        Step(
          isActive: currentStep >= 1,
          state: currentStep <= 1 ? StepState.editing : StepState.complete,
          title: const Text('Create Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ? Personal prompt
                const Text(
                  'A little about you...                                                  ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ? Space between next widget
                const SizedBox(height: 20),

                Row(
                  children: [
                    Stack(
                      children: [
                        _profileImage != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: MemoryImage(_profileImage!),
                              )
                            : const CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                    'images/defaultProfileImage.png'),
                              ),
                        Positioned(
                          bottom: -14,
                          left: 55,
                          child: IconButton(
                            onPressed: selectProfileImage,
                            icon: const Icon(Icons.add_a_photo_rounded),
                          ),
                        ),
                      ],
                    ),
                    // ? Space between next widget
                    const SizedBox(width: 50),
                    // ? Pronoun dropdown selector
                    DropdownMenuComponent(
                      width: 200,
                      value: pronouns,
                      hintText: const Text('Pronouns'),
                      itemsList: pronouns,
                      onChanged: (value) {
                        setState(() {
                          _pronouns = value as String;
                        });
                      },
                    ),
                  ],
                ),
                // ? Space between next widget
                const SizedBox(height: 20),

                // ? Bio Textfield
                CharacterLimitFieldComponent(
                  controller: _bio,
                  hintText: 'Bio',
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                ),
                // ? Space between next widget
                const SizedBox(height: 10),

                // ? City Textfield
                GradientTextFieldComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  width: 350,
                  controller: _cityController,
                  hintText: 'City / Town',
                  obscureText: false,
                ),
                // ? Space between next widget
                const SizedBox(height: 20),

                // ? Role prompt
                const Text(
                  '...and your current role                                            ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ? Space between next widget
                const SizedBox(height: 20),

                // ? Role Title Textfield
                GradientTextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    width: 350,
                    controller: _roleTitle,
                    hintText: 'Title',
                    obscureText: false),
                // ? Space between next widget
                const SizedBox(height: 20),

                // ? Industry Textfield
                GradientTextFieldComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    width: 350,
                    controller: _industry,
                    hintText: 'Industry',
                    obscureText: false),
                // ? Space between next widget
                const SizedBox(height: 20),

                Row(
                  children: [
                    // ? Place of Work/Study Textfield
                    GradientTextFieldComponent(
                      padding: const EdgeInsets.only(left: 0),
                      width: 190,
                      controller: _companyName,
                      hintText: 'Place of Work/Study',
                      obscureText: false,
                    ),

                    // ? Years Worked dropdown selector
                    DropdownMenuComponent(
                      width: 150,
                      value: years,
                      hintText: const Text('Years'),
                      itemsList: years,
                      onChanged: (value) {
                        setState(() {
                          _yearsWorked = value as String;
                        });
                      },
                    ),
                  ],
                ),
                // ? Space between next widget
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ];*/

      /*

// ? resizeToAvoidBottomInset: false,
        // ? Top bar that contains Nifti Logo
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(252, 250, 245, 1),
          title: SizedBox(
            width: 100,
            child: Image.asset('images/nifti_logo.png'),
          ),
        ),
        // ? Colour & Font theme for Stepper Widget
        body: Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(115, 142, 247, 1),
            ),
            fontFamily: 'Montserrat',
          ),
          // ? Start of Stepper widget
          child: Stepper(
            elevation: 0,
            steps: stepList(),
            currentStep: currentStep,
            // ? Change to next step
            onStepContinue: () {
              if (currentStep < (stepList().length - 1) &&
                  passwordConfirmed()) {
                setState(() {
                  currentStep += 1;
                });
              } else {
                if (currentStep == (stepList().length - 1)) {
                  register();
                }
              }
            },
            // ? Change to previous step
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
            type: StepperType.horizontal,
            // ? Next & Confirm, Cancel & Back Buttons
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == stepList().length - 1;
              return Row(
                children: [
                  // ? If first step = show Next button to continue & cancel prompt to go back to login page
                  if (!isLastStep) ...[
                    // ? Next Button
                    Expanded(
                        child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5),
                      ),
                    )),
                    const SizedBox(
                      width: 30,
                    ),
                    // ? Cancel Prompt
                    Expanded(
                        child: GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.5),
                      ),
                    ))
                  ],

                  // ? If final step = show Confirm button to save info & back prompt to go to previous step
                  if (isLastStep) ...[
                    // ? Confirm Button
                    Expanded(
                      child: CTAButton(
                          onTap: details.onStepContinue,
                          text: 'Confirm',
                          color: const Color.fromRGBO(115, 142, 247, 1)),
                      /*child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5),
                      ),
                    )*/
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    // ? Back Prompt
                    Expanded(
                      child: GestureDetector(
                        onTap: details.onStepCancel,
                        child: const Text(
                          'Back',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        )
 */