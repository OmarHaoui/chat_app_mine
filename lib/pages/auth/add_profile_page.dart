import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../utilities/constants.dart';
import '../../utilities/show_snack_bar.dart';
import '../../widgets/common/default_button.dart';
import '../../widgets/common/costume_text_field.dart';
import 'login_page.dart';

class AddProfilePage extends StatefulWidget {
  static String id = "addprofile";
  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  var usernameController = new TextEditingController();

  var bioController = new TextEditingController();

  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  String _username = "";

  String _bio = "";

  XFile? _profileImage;

  String imageUrl = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String registeredUid =
        ModalRoute.of(context)!.settings.arguments! as String;
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0,
            backgroundColor: kwhiteColor,
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(
                fontSize: 30,
                color: ktextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _profileImage != null
                          ? FileImage(File(_profileImage!.path))
                          : AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                      radius: 120,
                    ),
                    Positioned(
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: _selectProfilePicture,
                        tooltip: 'Select Profile Picture',
                        child: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Form(
                    key: _formkey,
                    child: Expanded(
                      child: Column(
                        children: [
                          CostumeTextField(
                              "Enter your name", usernameController),
                          SizedBox(height: 15),
                          CostumeTextField("Enter your bio", bioController),
                          SizedBox(height: 100),
                          defaultButtton(
                            onPressed: () async =>
                                await _GetProfileData(registeredUid),
                            childText: "Complete",
                            width: 155,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _GetProfileData(String registeredUid) async {
    isLoading = true;
    setState(() {});
    if (_profileImage != null) {
      if (_formkey.currentState!.validate()) {
        //get the user name
        _username = usernameController.text;
        //get the bio
        _bio = bioController.text;
        // Upload profile image to Firebase Storage
        await imageFirebaseStorageUpload();
        //Update the shown image
        setState(() {});
        // Store the user date in the firestore
        await firestoreMergeData(registeredUid);
        // Navigate to the Login page
        Navigator.pushReplacementNamed(context, LoginPage.id);
      }
    } else {
      showSnackBar(context, "Image must be provided");
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> firestoreMergeData(String registeredUid) async {
    await FirebaseFirestore.instance.collection('users').doc(registeredUid).set(
      {
        fireName: _username,
        fireBio: _bio,
        fireImage: imageUrl,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> imageFirebaseStorageUpload() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child(imageFileName);
    UploadTask uploadTask = ref.putFile(File(_profileImage!.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    imageUrl = await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> _selectProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    // handle the selected image here
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _profileImage = image;
    });
  }
}
