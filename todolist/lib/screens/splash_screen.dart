import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todolist/screens/todolist_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ToDoListScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50],
      child: const Center(
          child: Text("ToDo List App",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: "Roboto"))),
    );
  }
}
