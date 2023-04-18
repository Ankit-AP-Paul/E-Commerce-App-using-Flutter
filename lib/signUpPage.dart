import 'package:e_commerce_app/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confrmPasswd = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confrmPasswd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
            child: TextFormField(
              controller: _email,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return 'Please enter valid Email';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
            child: TextFormField(
              controller: _password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Minimum Password length should be 6';
                }
                return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
            child: TextFormField(
              controller: _confrmPasswd,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Minimum Password length should be 6';
                } else if (value != _password.text) {
                  return 'Password didn\'t Match';
                }
                return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                padding: const EdgeInsets.all(12),
                animationDuration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        SizedBox(width: 24),
                        Text(
                          'Please Wait...',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.account_box),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
              onPressed: () async {
                try {
                  // ignore: unused_local_variable
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _email.text,
                    password: _password.text,
                  );
                  if (isLoading) return;
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 3));
                  CollectionReference users = FirebaseFirestore.instance
                      .collection('MyStore.com_users');
                  users
                      .doc(_email.text)
                      .set({
                        'email': _email.text, // john@gmail.com
                        'name': "", //John Doe
                        'username': "", //john123
                      })
                      .then((value) => debugPrint("User Added"))
                      .catchError(
                          (error) => debugPrint("Failed to add user: $error"));

                  setState(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(
                          emailID: _email.text,
                        ),
                      ),
                    );
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    const snackBar = SnackBar(
                      content: Text(
                        'Password is too weak',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (e.code == 'email-already-in-use') {
                    const snackBar = SnackBar(
                      content: Text(
                        'Email already exists',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } catch (e) {
                  // print(e);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
