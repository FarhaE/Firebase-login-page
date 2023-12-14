import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //intialising the firebase before everything
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;//shows the current user
            if (user?.emailVerified ?? false){
              print('You are a verified user');
            }
            else {
              print('Verify your email');
            }
             return Text('done');
        default:
        return const Text('Loading...');
          }

        },       
      ),
    );
  }
}
