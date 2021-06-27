import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komisains_app/providers/auth.dart';
import 'package:komisains_app/widgets/profile_view.dart';
import 'package:provider/provider.dart';
import 'package:komisains_app/widgets/profile_edit.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'edit_password.dart';

enum EditProfile { View, Edit }

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  var _isInit = true;
  var _isLoading = false;
  late File _storedImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final profileId = ModalRoute.of(context)!.settings.arguments as String;
      if (profileId != null) {
        Provider.of<Auth>(context, listen: false).getProfile();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // void _selectImage(File pickedImage) {
  //   _pickedImage = pickedImage;
  // }

  Future<void> _takePicture() async {
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      if (imageFile != null) {
        _storedImage = File(imageFile.path);
      } else {
        print('No image selected.');
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    // Provider.of<Auth>(context, listen: false).uploadImage(savedImage);
    // Provider.of<Auth>(context, listen: false).editPhoto(savedImage);
    Provider.of<Auth>(context, listen: false).upload(savedImage);
  }

  Future<void> _takeImageGallery() async {
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      if (imageFile != null) {
        _storedImage = File(imageFile.path);
      } else {
        print('No image selected.');
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    // Provider.of<Auth>(context, listen: false).uploadImage(savedImage);
    // Provider.of<Auth>(context, listen: false).editPhoto(savedImage);
    Provider.of<Auth>(context, listen: false).upload(savedImage);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _takeImageGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _takePicture();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Auth>(context).items;

    return ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      child: profile!.photo != null
                          ? Image.network(
                              profile.photo,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/profile.png',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: InkWell(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                profile.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff6EA88F)),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff6EA88F)),
                ),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.25,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(EditProfileScreen.routeName);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Edit Profile',
                          style: const TextStyle(
                            color: const Color(0xff6EA88F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff6EA88F)),
                ),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(EditPasswordScreen.routeName);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Edit Password',
                          style: const TextStyle(
                            color: const Color(0xff6EA88F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 1.0, color: Colors.red),
                ),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.19,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                        Provider.of<Auth>(context, listen: false).logout();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Log Out',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: const Color(0xff6EA88F),
          ),
          child: ProfileView(),
        ),
      ],
    );
  }
}
