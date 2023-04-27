import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/auth/auth_form.dart';
import 'package:riderapp/auth/auth_screen.dart';
import 'package:riderapp/screens/bottompage.dart';

// import '../screens/bottomscreens/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const BottomPage();
            } else {
              return const AuthScreen();
            }
          }),
    );
  }
}
