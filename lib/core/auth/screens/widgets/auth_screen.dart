import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komisains_app/core/auth/bloc/login/login_bloc.dart';
import 'package:komisains_app/core/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:komisains_app/core/auth/repositories/login_auth_repository.dart';
import 'package:komisains_app/models/http_exection.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  final ScrollController? sc;
  const AuthCard({
    @required this.sc,
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late LoginBloc _loginBloc;
  late SignUpBloc _signUpBloc;
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'password_confirmation': '',
    'nohp': '',
    'department': '',
    'sex': '',
    'angkatan_kuliah': '',
  };
  var _isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _noHpController = TextEditingController();
  final _departmentController = TextEditingController();
  final _sexController = TextEditingController();
  final _angkatanKuliahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _signUpBloc = context.read<SignUpBloc>();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        _loginBloc.add(LogIn(
          email: _authData['email']!,
          password: _authData['password']!,
        ));
      } else {
        // Sign user up
        _signUpBloc.add(SignUp(signUpData: _authData));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil Daftar',
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
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

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ListView(
      controller: widget.sc,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Mari Bergabung HMI",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          width: deviceSize.width * 0.85,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Nama',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelStyle: const TextStyle(color: Colors.white)),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kolom tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['name'] = value!;
                    },
                  ),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'E-Mail',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: const TextStyle(color: Colors.white)),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: const TextStyle(color: Colors.white)),
                  cursorColor: Colors.white,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  Column(
                    children: [
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'Password Confirmation',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelStyle: const TextStyle(color: Colors.white)),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kolom tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password_confirmation'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        controller: _noHpController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'No Hp',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelStyle: const TextStyle(color: Colors.white)),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kolom tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['nohp'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        controller: _departmentController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'Jurusan',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelStyle: const TextStyle(color: Colors.white)),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kolom tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['department'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        controller: _sexController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'Jenis Kelamin',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelStyle: const TextStyle(color: Colors.white)),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kolom tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['sex'] = value!;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        controller: _angkatanKuliahController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'Angkatan Kuliah',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelStyle: const TextStyle(color: Colors.white)),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Kolom tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['angkatan_kuliah'] = value!;
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      child: state is LoginLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(_authMode == AuthMode.Login
                              ? 'LOGIN'
                              : 'SIGN UP'),
                      onPressed: state is LoginLoading ? () {} : _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        primary: Colors.white,
                        onPrimary: Color(0xff3BBC86),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  },
                ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
