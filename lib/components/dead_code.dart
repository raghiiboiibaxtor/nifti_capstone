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
 */
