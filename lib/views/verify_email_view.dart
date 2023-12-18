
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: const Text('Verify Email'),backgroundColor: Colors.blue,),
      body: Column(
          children: [
            const Text('We\'ve send you an email verification. Please open it to verify your account.'),
            const Text('If you haven\'t recieved an email yet, press the button below'),
            TextButton(onPressed: () async{
           final user = FirebaseAuth.instance.currentUser;//shows the current user
           await user?.sendEmailVerification();
      
            }, child: const Text('Send Email Verification')),
            TextButton(onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, registerRoute, (route) => false);
            },child: const Text('Restart'),)
          ],
        ),
    );

  }
}