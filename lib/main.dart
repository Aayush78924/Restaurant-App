import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp1/Screens/home_Screen.dart';
import 'package:temp1/Screens/loading_screen.dart';
import 'package:temp1/Screens/login_Screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const launcher_Screen(),
    );
  }
}

class launcher_Screen extends StatefulWidget {
  const launcher_Screen({Key? key}) : super(key: key);

  @override
  State<launcher_Screen> createState() => _launcher_ScreenState();
}

class _launcher_ScreenState extends State<launcher_Screen> {
  String phone = "";
  String name = "";
  String address = "";
  String verify_id = "";
  bool otp = false;
  Future<List> landingPageDecider() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    print("launcher");
    print(sharedpref.getBool('login'));
    if (sharedpref.getBool('login') ?? false) {
      return ['home'];
    } else {
      return ['login'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: landingPageDecider(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data![0] == 'home') return const MyHomePage();
            if (snapshot.data![0] == 'login') return const login_Screen();
          } else {
            return const loading_Screen();
          }
          return const loading_Screen();
        });

    //for admin screen module
    // return admin_OrderScreen();
    //for user
    // return MyHomePage();
  }
}
