import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../authentication/data/repositories/users_repo.dart';
import '../../domain/entities/user.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/shadow.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FocusNode _focusNameNode = FocusNode();
  bool _hasNameFocus = false;

  final FocusNode _focusUsernameNode = FocusNode();
  bool _hasUsernameFocus = false;

  final FocusNode _focusBioNode = FocusNode();
  bool _hasBioFocus = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 2:
        if (input.toString().length > 136) {
          return 'Bio should be within 136 characters';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNameNode.addListener(() {
      setState(() {
        _hasNameFocus = _focusNameNode.hasFocus;
      });
    });

    _focusUsernameNode.addListener(() {
      setState(() {
        _hasUsernameFocus = _focusUsernameNode.hasFocus;
      });
    });

    _focusBioNode.addListener(() {
      setState(() {
        _hasBioFocus = _focusBioNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? _selectedImage;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    setState(() {
      _selectedImage = File(image.path);
    });
  }

  void pickSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallary'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: AppColors.iconLightColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                          color: AppColors.textColor, size: 26),
                    ),
                    SizedBox(width: 10),
                    Text('Edit Profile', style: MainFonts.pageTitleText()),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: UsersRepo.userFireInstance.snapshots(),
              builder: (context, snapshot) {
                final documents;
                User? user;
                if (snapshot != null) {
                  documents = snapshot.data?.docs;
                  List<Map<String, dynamic>> usersData = [];

                  if (documents != null && documents.isNotEmpty) {
                    final firstDocument = documents[0];

                    if (firstDocument != null &&
                        firstDocument.data() != null &&
                        firstDocument.data().containsKey('userslist')) {
                      usersData = List<Map<String, dynamic>>.from(
                          firstDocument.data()['userslist']);

                      List<User> usersList = usersData
                          .map((userData) => User.fromMap(userData))
                          .toList();

                      List<User> users = usersList
                          .where((user) => user.uid == MyApp.userId)
                          .toList();
                      user = users.first;
                    }
                  }
                }

                nameController.text = user?.fullName ?? '_';
                usernameController.text = user?.username ?? '_';
                bioController.text = user?.bio ?? '_';
                return Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.primaryColor30,
                          borderRadius: BorderRadius.circular(
                              AppBoarderRadius.reviewUploadRadius),
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    pickSource();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.secondaryColor10,
                                          width: 2,
                                        ),
                                      ),
                                      child: Stack(children: [
                                        _selectedImage != null
                                            ? CircleAvatar(
                                                backgroundImage:
                                                    FileImage(_selectedImage!),
                                                radius: 60,
                                              )
                                            : user?.profileUrl == 'null'
                                                ? CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        "assets/icons/user.png"),
                                                    radius: 60,
                                                  )
                                                : CircleAvatar(
                                                    radius: 60,
                                                    child: ClipOval(
                                                        child: CustomImageShimmer(
                                                            imageUrl:
                                                                user?.profileUrl ??
                                                                    '',
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            fit:
                                                                BoxFit.cover))),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                // Set the background color of the icon
                                                shape: BoxShape
                                                    .circle, // Set the shape of the background to a circle
                                              ),
                                              child: Icon(Icons.add_circle,
                                                  color: AppColors
                                                      .secondaryColor10,
                                                  size: 35)),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 5),
                                  child: Text('Full Name',
                                      style: MainFonts.lableText()),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: nameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: ((value) {
                                      return _validateInput(value, 0);
                                    }),
                                    style: MainFonts.textFieldText(),
                                    focusNode: _focusNameNode,
                                    cursorHeight: TextCursorHeight.cursorHeight,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 20,
                                          right: 20),
                                      fillColor: AppColors.primaryColor30,
                                      filled: true,
                                      hintText:
                                          _hasNameFocus ? 'Enter name' : null,
                                      hintStyle: MainFonts.hintFieldText(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .reviewUploadWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .reviewUploadWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .searchBarWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .searchBarWidth,
                                              color:
                                                  AppBoarderColor.errorColor)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 5),
                                  child: Text('Username',
                                      style: MainFonts.lableText()),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: usernameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: ((value) {
                                      return _validateInput(value, 1);
                                    }),
                                    style: MainFonts.textFieldText(),
                                    focusNode: _focusUsernameNode,
                                    cursorHeight: TextCursorHeight.cursorHeight,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 20,
                                          right: 20),
                                      fillColor: AppColors.primaryColor30,
                                      filled: true,
                                      hintText: _hasUsernameFocus
                                          ? 'Enter username'
                                          : null,
                                      hintStyle: MainFonts.hintFieldText(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .reviewUploadWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .reviewUploadWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .searchBarWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .searchBarWidth,
                                              color:
                                                  AppBoarderColor.errorColor)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 5),
                                  child: Text('Bio (Optional)',
                                      style: MainFonts.lableText()),
                                ),
                                Container(
                                  child: TextFormField(
                                    maxLines: 3,
                                    controller: bioController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: ((value) {
                                      return _validateInput(value, 2);
                                    }),
                                    style: MainFonts.textFieldText(),
                                    focusNode: _focusBioNode,
                                    cursorHeight: TextCursorHeight.cursorHeight,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                          left: 20,
                                          right: 20),
                                      fillColor: AppColors.primaryColor30,
                                      filled: true,
                                      hintText:
                                          _hasBioFocus ? 'Enter bio' : null,
                                      hintStyle: MainFonts.hintFieldText(),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .reviewUploadWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .reviewUploadWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .searchBarWidth,
                                              color: AppBoarderColor
                                                  .searchBarColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppBoarderRadius
                                                  .reviewUploadRadius),
                                          borderSide: BorderSide(
                                              width: AppBoarderWidth
                                                  .searchBarWidth,
                                              color:
                                                  AppBoarderColor.errorColor)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 55,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.secondaryColor10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppBoarderRadius.buttonRadius)),
                                        elevation: AppElevations.buttonElev,
                                      ),
                                      onPressed: () {
                                        _formKey.currentState!.validate();
                                      },
                                      child: Text('Save Changes',
                                          style: AuthFonts.authButtonText())),
                                ),
                              ]),
                        )),
                  ],
                );
              }),
        ));
  }
}
