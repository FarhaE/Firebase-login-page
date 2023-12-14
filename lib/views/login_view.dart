import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {

  
    late final TextEditingController _email;
  late final TextEditingController _password;

  @override
void initState() {
  super.initState();
  _email=TextEditingController();
  _password=TextEditingController();
}

@override
  void dispose() {
   _email.dispose();
   _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
              return Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your email here',
              ),
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
                
              ),
              controller: _password,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
            ),
            TextButton(
              onPressed: () async {
                 
                final email=_email.text;
                final password=_password.text;
                try{
               final userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                
               print(userCredential);
              }on FirebaseAuthException catch (e){
                if(e.code == 'user-not-found'){
                print("User not found");}
                else{
                  print(e.code);
                }
                

              }
                },
              child: const Text('Login'))
    
          
              ]);
        default:
        return const Text('Loading...');
          }

        },       
      ),
    );
  }
 


  }