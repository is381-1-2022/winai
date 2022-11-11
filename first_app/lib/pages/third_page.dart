import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
      ),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  late String _name;
  late int _age;
  late String _password;

  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: context.read<LoginProfileModel>().name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
                icon: Icon(Icons.badge),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }

                if (value.length < 5) {
                  return 'Your name must be at least 5 charactors';
                }

                return null;
              },
              onSaved: (newValue) {
                _name = newValue!;
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: context.read<LoginProfileModel>().age.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your age',
                icon: Icon(Icons.numbers),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }

                try {
                  int.parse(value);
                } catch (ex) {
                  return 'Please enter number only';
                }
              },
              onSaved: (newValue) {
                _age = int.parse(newValue!);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: context.read<LoginProfileModel>().password,
              obscureText: _hidePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
              },
              onSaved: (newValue) {
                _password = newValue!;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your password',
                icon: const Icon(Icons.remove_red_eye),
                suffixIcon: InkWell(
                  child: const Icon(Icons.remove_red_eye),
                  onTap: () {
                    setState(() {
                      _hidePassword = false;
                    });

                    Timer(
                      const Duration(seconds: 5),
                      () {
                        setState(() {
                          _hidePassword = true;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Message : $_message',
                style: TextStyle(color: Color(Colors.red.value))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  context.read<LoginProfileModel>()
                    ..name = _name
                    ..age = _age
                    ..password = _password;

                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _name,
                      password: _password,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      setState(() {
                        _message = 'The password provided is too weak.';
                      });
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      setState(() {
                        _message = 'The account already exists for that email.';
                      });
                    }

                    return;
                  } catch (e) {
                    print(e);
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginProfilePage(
                        profile: LoginProfile(_name, _age, _password),
                      ),
                    ),
                  );
                }
              },
              child: Text('Add User'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    context.read<LoginProfileModel>()
                      ..name = _name
                      ..age = _age
                      ..password = _password;

                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _name, password: _password);
                      setState(() {
                        _message = 'Login sucessfully';
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        setState(() {
                          _message = 'No user found for that email.';
                        });
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        setState(() {
                          _message = 'Wrong password provided for that user.';
                        });
                      }
                    }
                  }
                },
                child: Text('Login')),
          ),
        ],
      ),
    );
  }
}

class LoginProfile {
  final String name;
  final int age;
  final String password;

  const LoginProfile(this.name, this.age, this.password);
}

class LoginProfilePage extends StatelessWidget {
  final LoginProfile profile;

  const LoginProfilePage({key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm login profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your name is ${profile.name}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your age is ${profile.age}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your password is ******'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginProfileModel extends ChangeNotifier {
  String _name = '';
  int _age = 0;
  String _password = '';
  get name => this._name;
  set name(value) {
    this._name = value;
    notifyListeners();
  }

  get age => this._age;
  set age(value) {
    this._age = value;
    notifyListeners();
  }

  get password => this._password;
  set password(value) {
    this._password = value;
    notifyListeners();
  }
}
