import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komisains_app/core/auth/bloc/authentication/authentication_bloc.dart';
import 'package:komisains_app/modules/user_profile/bloc/user_profile_bloc.dart';

import 'package:komisains_app/modules/user_profile/screens/widgets/profile_edit.dart';
import 'package:komisains_app/modules/user_profile/screens/widgets/profile_view.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'edit_password.dart';

enum EditProfile { View, Edit }

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late File _storedImage;
  final picker = ImagePicker();
  late UserProfileBloc userProfileBloc;
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    userProfileBloc = context.read<UserProfileBloc>();
    authenticationBloc = context.read<AuthenticationBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    userProfileBloc.add(FetchUserProfile());

    super.didChangeDependencies();
  }

  Future<void> _takePicture() async {
    final dynamic imageFile = await picker.getImage(
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
    userProfileBloc.add(UploadPhotoProfile(photoProfile: savedImage));
  }

  Future<void> _takeImageGallery() async {
    final dynamic imageFile = await picker.getImage(
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
    userProfileBloc.add(UploadPhotoProfile(photoProfile: savedImage));
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
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileStateLoaded) {
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
                            child: state.user!.photo != null
                                ? Image.network(
                                    state.user!.photo,
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
                      state.user!.name,
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
                        border: Border.all(
                            width: 1.0, color: const Color(0xff6EA88F)),
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
                        border: Border.all(
                            width: 1.0, color: const Color(0xff6EA88F)),
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
                              authenticationBloc.add(UserLoggedOut());
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: const Color(0xff6EA88F),
                ),
                child: ProfileView(user: state.user),
              ),
            ],
          );
        } else if (state is UserProfileStateLoad) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
