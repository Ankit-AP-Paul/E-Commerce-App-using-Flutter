import 'package:e_commerce_app/homepage.dart';
import 'package:e_commerce_app/signInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:e_commerce_app/swipeUpWidget.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// // Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyStore.com',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: const Home(),
        home: FutureBuilder(
          future: FirebaseAuth.instance.authStateChanges().first,
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData) {
                return Home(
                  emailID: user!.email.toString(),
                );
              } else {
                return const SignIn();
              }
            }
          },
        ));
  }
}
