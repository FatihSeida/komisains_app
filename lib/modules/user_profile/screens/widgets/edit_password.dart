import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komisains_app/modules/user_profile/bloc/user_profile_bloc.dart';
import 'package:provider/provider.dart';

class EditPasswordScreen extends StatefulWidget {
  static const routeName = '/edit-password';
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  Map<String, String> _editPassword = {
    'old_password': '',
    'new_password': '',
    'confirm_password': '',
  };
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  late String message;
  late UserProfileBloc userProfileBloc;

  @override
  void initState() {
    userProfileBloc = context.read<UserProfileBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    if (_editPassword['id'] != null) {
      userProfileBloc.add(EditPassword(newPasswordData: _editPassword));

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6EA88F),
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white),
                      ),
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: _saveForm,
                            child: Text(
                              'Simpan',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            obscureText: true,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                                labelText: 'Password Lama :',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusColor: Colors.white,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hoverColor: Colors.white,
                                counterStyle:
                                    const TextStyle(color: Colors.white)),
                            textInputAction: TextInputAction.next,
                            focusNode: _oldPasswordFocusNode,
                            controller: _oldPasswordController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_newPasswordFocusNode);
                            },
                            onSaved: (value) {
                              _editPassword['old_password'] = value!;
                            },
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                  labelText: 'New Password :',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusColor: Colors.white,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hoverColor: Colors.white,
                                  counterStyle:
                                      const TextStyle(color: Colors.white)),
                              textInputAction: TextInputAction.next,
                              focusNode: _newPasswordFocusNode,
                              controller: _newPasswordController,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_confirmPasswordFocusNode);
                              },
                              onSaved: (value) {
                                _editPassword['new_password'] = value!;
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password :',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  focusColor: Colors.white,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hoverColor: Colors.white,
                                  counterStyle:
                                      const TextStyle(color: Colors.white)),
                              textInputAction: TextInputAction.next,
                              focusNode: _confirmPasswordFocusNode,
                              controller: _confirmPasswordController,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editPassword['confirm_password'] = value!;
                              },
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
