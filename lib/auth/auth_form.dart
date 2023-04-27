import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/auth/forgot_pw_screen.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String userFirstName,
    String userLastName,
    String userPhoneNo,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = '';
  var _userFirstName = '';
  var _userLastName = '';
  var _userEmail = '';
  var _userPhoneNo = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userFirstName.trim(),
        _userLastName.trim(),
        _userPhoneNo.trim(),
        _isLogin,
        context,
      );
      print(_userEmail);
      print(_userPhoneNo);
      print(_userPassword);

      //Use those values to send our auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _isLogin ? 'M.O.S.S' : 'Hello! Again',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    _isLogin
                        ? 'A Women Safety Application'
                        : 'Register Here With Your Details',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //firstName
                  if (!_isLogin)
                    Container(
                      padding: EdgeInsets.all(3),
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        key: const ValueKey('firstname'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return 'Please enter valid first name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Firstname',
                          border: InputBorder.none,
                          prefixIcon: Align(
                            heightFactor: 1.0,
                            widthFactor: 1.0,
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.person),
                          ),
                        ),
                        onSaved: (value) {
                          _userFirstName = value!;
                        },
                      ),
                    ),
                  //lastName
                  const SizedBox(
                    height: 10,
                  ),
                  if (!_isLogin)
                    Container(
                      padding: EdgeInsets.all(3),
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        key: const ValueKey('lastname'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return 'Please enter valid last name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Lastname',
                          border: InputBorder.none,
                          prefixIcon: Align(
                            heightFactor: 1.0,
                            widthFactor: 1.0,
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.person),
                          ),
                        ),
                        onSaved: (value) {
                          _userLastName = value!;
                        },
                      ),
                    ),
                  //Phone Number
                  const SizedBox(
                    height: 10,
                  ),
                  if (!_isLogin)
                    Container(
                      padding: EdgeInsets.all(3),
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        key: const ValueKey('phonenumber'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return 'Please enter at least 10 characters';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: InputBorder.none,
                          prefixIcon: Align(
                            heightFactor: 1.0,
                            widthFactor: 1.0,
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.phone),
                          ),
                        ),
                        onSaved: (value) {
                          _userPhoneNo = value!;
                        },
                      ),
                    ),
                  //username
                  const SizedBox(
                    height: 10,
                  ),
                  if (!_isLogin)
                    Container(
                      padding: EdgeInsets.all(3),
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'username',
                          border: InputBorder.none,
                          prefixIcon: Align(
                            heightFactor: 1.0,
                            widthFactor: 1.0,
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.person_outlined),
                          ),
                        ),
                        onSaved: (value) {
                          _userName = value!;
                        },
                      ),
                    ),

                  //Email
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                        border: InputBorder.none,
                        prefixIcon: Align(
                          heightFactor: 1.0,
                          widthFactor: 1.0,
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.email_outlined),
                        ),
                      ),
                      onSaved: (value) {
                        _userEmail = value as String;
                      },
                    ),
                  ),
                  //Password
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Align(
                          heightFactor: 1.0,
                          widthFactor: 1.0,
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.vpn_key),
                        ),
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value as String;
                      },
                    ),
                  ),

                  const SizedBox(height: 12),
                  if (_isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPassword()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue),
                          )),
                    ),
                  const SizedBox(height: 12),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(350, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            // side: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Sign In' : 'Sign Up'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(
                        _isLogin
                            ? 'Not a member? Register now'
                            : 'Already Member? Login now.',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
