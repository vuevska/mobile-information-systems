import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab5/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView>
    with TickerProviderStateMixin {
  late AnimationController _linearProgressController;

  static const Duration _linearProgressDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _linearProgressController =
        AnimationController(duration: _linearProgressDuration, vsync: this);
    _linearProgressController.forward();
  }

  @override
  void dispose() {
    _linearProgressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        backgroundColor: Colors.blueGrey,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(loginRoute);
            },
            child: const Text(
              "Log In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Please verify your email",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Verification email sent successfully!",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8.0),
                        AnimatedBuilder(
                          animation: _linearProgressController,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.grey,
                              ),
                              value: 1.0 - _linearProgressController.value,
                            );
                          },
                        ),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    duration: _linearProgressDuration,
                  ),
                );

                _linearProgressController.reset();
                _linearProgressController.forward();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                minimumSize: const Size(150, 40),
              ),
              child: const Text(
                "Send Verification",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
