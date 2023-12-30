import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/screens/Home_screen.dart';
import 'package:flutter_spring/widgets/Nointernet.dart';
import 'package:flutter_spring/screens/login_screen.dart';
import 'package:flutter_spring/screens/waiting_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token;
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _getToken();
      });
    } else {
      print("no internet connection");
    }
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: _token == null
          ? WaitingScreen()
          : _token == ""
              ? LoginScreen()
              : HomeScreen(),
    );
  }
}
