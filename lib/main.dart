import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //intialising the firebase before everything
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 45, 0, 122)),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      '/login':(context)=>const LoginView(),
      '/register':(context)=>const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:

  //            final user = FirebaseAuth.instance.currentUser;//shows the current user
  //           // print(user);
  //            if (user?.emailVerified ?? false){
  //            return Text('done');
  //            }
  //            else {
  //             return VerifyEmailView();
  // }
                  
            //  return const VerifyEmailView();
             
            return const LoginView();
            
        default:
        return const CircularProgressIndicator();
          }

        },       
      );
  }
}
