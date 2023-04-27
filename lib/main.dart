import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/providers/community_provider.dart';
import 'package:riderapp/providers/places_data.dart';
import 'package:riderapp/screens/bottomscreens/comment/comment_screen.dart';
import 'package:riderapp/screens/bottomscreens/community_screens/edit_confession_screen.dart';
import 'package:riderapp/screens/bottomscreens/community_screens/user_confessions_screen.dart';

import 'auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlacesData(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Confessions(),
        )
      ],
      child: GetMaterialApp(
          title: 'MOSS',
          theme: ThemeData(
            fontFamily: "Brand Bold  ",
            backgroundColor: Colors.grey[300],
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.purple,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepPurpleAccent),
          ),
          // home: SplashScreen(),
          routes: {
            '/': (ctx) => const SplashScreen(),
            UserConfessionsScreen.routeName: (ctx) =>
                const UserConfessionsScreen(),
            EditConfessionScreen.routeName: (ctx) =>
                const EditConfessionScreen(),
            CommentScreen.routeName: (ctx) => CommentScreen(),
          }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
