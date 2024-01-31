import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab3/constants/routes.dart';
import 'package:lab3/firebase_options.dart';
import 'package:lab3/views/exam_view.dart';
import 'package:lab3/views/login_view.dart';
import 'package:lab3/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      examsRoute: (context) => const ExamView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const ExamView();
          // final user = FirebaseAuth.instance.currentUser;
          // if (user != null) {
          //   if (user.emailVerified) {
          //     return const ExamView();
          //   } else {
          //     return const VerifyEmailView();
          //   }
          // } else {
          //   return const LoginView();
          // }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
